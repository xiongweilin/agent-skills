<#
.SYNOPSIS
    Deploy the neutral AGENTS.md and agent skills to user-global harness locations.

.DESCRIPTION
    Source: <RepoRoot>\agents-md\AGENTS.md, plus every <RepoRoot>\<name>\SKILL.md bundle.
    Destinations: each -DestinationRoots entry receives AGENTS.md and skills\<name>\...

    Default destinations are the Codex, DSH, OpenCode, and WorkBuddy user-global
    homes. WorkBuddy reads standing rules from <root>\rules\, so its AGENTS.md is
    placed at rules\AGENTS.md (see -AgentsRelativePaths); skills keep the usual
    skills\<name>\ layout. The source is copied verbatim; no harness-specific
    substitutions are applied. Files are copied only when their SHA-256 differs,
    and every copy is verified. Each destination's skills manifest tracks the
    managed skill set so stale files and stale managed skill directories can be
    removed.

.PARAMETER RepoRoot
    agent-skills repository root. Default: D:\agent\agent-skills

.PARAMETER DestinationRoots
    One or more harness home directories. Default: the Codex, DSH, OpenCode, and WorkBuddy homes.

.PARAMETER AgentsRelativePaths
    Map of destination root to an AGENTS.md path relative to that root. Roots not
    listed use 'AGENTS.md'. Default: the WorkBuddy root uses 'rules\AGENTS.md'.

.EXAMPLE
    pwsh -NoProfile -File .\sync-agents.ps1
#>
[CmdletBinding()]
param(
    [string]$RepoRoot = 'D:\agent\agent-skills',
    [string[]]$DestinationRoots = @(
        (Join-Path $env:USERPROFILE '.codex'),
        (Join-Path $env:USERPROFILE '.dsh'),
        (Join-Path $env:USERPROFILE '.config\opencode'),
        (Join-Path $env:USERPROFILE '.workbuddy')
    ),
    [hashtable]$AgentsRelativePaths = @{
        (Join-Path $env:USERPROFILE '.workbuddy') = 'rules\AGENTS.md'
    }
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$sourceAgents = Join-Path $RepoRoot 'agents-md\AGENTS.md'

if (-not (Test-Path -LiteralPath $RepoRoot -PathType Container)) {
    throw "Repository root not found: $RepoRoot"
}
if (-not (Test-Path -LiteralPath $sourceAgents -PathType Leaf)) {
    throw "AGENTS source not found: $sourceAgents"
}
if ($null -eq $DestinationRoots -or $DestinationRoots.Count -eq 0) {
    throw 'At least one destination root is required.'
}

$skillSources = @(Get-ChildItem -LiteralPath $RepoRoot -Directory |
    Where-Object { Test-Path -LiteralPath (Join-Path $_.FullName 'SKILL.md') -PathType Leaf } |
    Sort-Object Name)
if ($skillSources.Count -eq 0) {
    throw "No skill bundles found under: $RepoRoot"
}

function Copy-VerifiedFile {
    param(
        [Parameter(Mandatory)][string]$Source,
        [Parameter(Mandatory)][string]$Destination
    )

    $sourceHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $Source).Hash
    $destinationHash = $null
    if (Test-Path -LiteralPath $Destination -PathType Leaf) {
        $destinationHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $Destination).Hash
    }

    $copied = $false
    if ($sourceHash -ne $destinationHash) {
        $parent = Split-Path -Parent $Destination
        if (-not (Test-Path -LiteralPath $parent -PathType Container)) {
            New-Item -ItemType Directory -Path $parent -Force | Out-Null
        }
        Copy-Item -LiteralPath $Source -Destination $Destination -Force
        $copied = $true
    }

    $afterHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $Destination).Hash
    if ($afterHash -ne $sourceHash) {
        throw "Hash mismatch after copy: $Destination"
    }

    return $copied
}

function Sync-Target {
    param(
        [Parameter(Mandatory)][string]$DestinationRoot,
        [Parameter(Mandatory)][string]$SourceAgents,
        [Parameter(Mandatory)][object[]]$SkillSources,
        [string]$AgentsRelativePath = 'AGENTS.md'
    )

    $destinationAgents = Join-Path $DestinationRoot $AgentsRelativePath
    $destinationSkills = Join-Path $DestinationRoot 'skills'
    $manifestPath = Join-Path $destinationSkills '.xiongweilin-agent-skills-sync.json'
    $currentSkillNames = @($SkillSources | ForEach-Object { $_.Name } | Sort-Object -Unique)

    if (-not (Test-Path -LiteralPath $DestinationRoot -PathType Container)) {
        New-Item -ItemType Directory -Path $DestinationRoot -Force | Out-Null
    }
    if (-not (Test-Path -LiteralPath $destinationSkills -PathType Container)) {
        New-Item -ItemType Directory -Path $destinationSkills -Force | Out-Null
    }

    $agentsCopied = Copy-VerifiedFile -Source $SourceAgents -Destination $destinationAgents

    $previousManagedSkillNames = @()
    if (Test-Path -LiteralPath $manifestPath) {
        if (-not (Test-Path -LiteralPath $manifestPath -PathType Leaf)) {
            throw "Skill sync manifest path is not a file: $manifestPath"
        }

        try {
            $manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json -ErrorAction Stop
        }
        catch {
            throw "Unable to read skill sync manifest: $manifestPath. $($_.Exception.Message)"
        }

        if ($null -eq $manifest) {
            throw "Skill sync manifest is empty: $manifestPath"
        }
        $manifestProperties = @($manifest.PSObject.Properties.Name)
        if (($manifestProperties -notcontains 'source') -or
            ($manifestProperties -notcontains 'version') -or
            ($manifestProperties -notcontains 'skills') -or
            ($manifest.source -ne 'xiongweilin/agent-skills') -or
            ($manifest.version -ne 1) -or
            ($null -eq $manifest.skills)) {
            throw "Skill sync manifest has an unsupported format or owner: $manifestPath"
        }

        foreach ($managedSkillName in @($manifest.skills)) {
            if (($managedSkillName -isnot [string]) -or
                [string]::IsNullOrWhiteSpace($managedSkillName) -or
                ($managedSkillName -in @('.', '..')) -or
                ($managedSkillName.IndexOfAny([IO.Path]::GetInvalidFileNameChars()) -ge 0)) {
                throw "Invalid skill name in sync manifest: $manifestPath"
            }
            $previousManagedSkillNames += $managedSkillName
        }
    }
    else {
        $previousManagedSkillNames = @($currentSkillNames)
    }

    $skillFilesByName = @{}
    foreach ($skillSource in $SkillSources) {
        $skillFilesByName[$skillSource.Name] = @(Get-ChildItem -LiteralPath $skillSource.FullName -File -Recurse -Force)
    }

    $skillFileCount = 0
    $skillFilesCopied = 0
    foreach ($skillSource in $SkillSources) {
        $skillDestination = Join-Path $destinationSkills $skillSource.Name
        foreach ($sourceFile in $skillFilesByName[$skillSource.Name]) {
            $relativePath = $sourceFile.FullName.Substring($skillSource.FullName.Length + 1)
            $destinationFile = Join-Path $skillDestination $relativePath
            if (Copy-VerifiedFile -Source $sourceFile.FullName -Destination $destinationFile) {
                $skillFilesCopied++
            }
            $skillFileCount++
        }
    }

    $staleSkillFilesRemoved = 0
    foreach ($skillSource in $SkillSources) {
        $skillDestination = Join-Path $destinationSkills $skillSource.Name
        $expectedFilePaths = @{}
        foreach ($sourceFile in $skillFilesByName[$skillSource.Name]) {
            $relativePath = $sourceFile.FullName.Substring($skillSource.FullName.Length + 1)
            $expectedFilePaths[$relativePath] = $true
        }

        if (Test-Path -LiteralPath $skillDestination -PathType Container) {
            foreach ($destinationFile in Get-ChildItem -LiteralPath $skillDestination -File -Recurse -Force) {
                $relativePath = $destinationFile.FullName.Substring($skillDestination.Length + 1)
                if (-not $expectedFilePaths.ContainsKey($relativePath)) {
                    Remove-Item -LiteralPath $destinationFile.FullName -Force
                    $staleSkillFilesRemoved++
                    Write-Output "Removed stale skill file: $($destinationFile.FullName)"
                }
            }

            Get-ChildItem -LiteralPath $skillDestination -Directory -Recurse -Force |
                Sort-Object { $_.FullName.Length } -Descending |
                Where-Object { -not (Get-ChildItem -LiteralPath $_.FullName -Force) } |
                ForEach-Object { Remove-Item -LiteralPath $_.FullName -Force }
        }
    }

    $staleSkillsRemoved = 0
    foreach ($managedSkillName in $previousManagedSkillNames) {
        if ($currentSkillNames -contains $managedSkillName) {
            continue
        }

        $skillDestination = Join-Path $destinationSkills $managedSkillName
        if (Test-Path -LiteralPath $skillDestination) {
            if (-not (Test-Path -LiteralPath $skillDestination -PathType Container)) {
                throw "Managed skill destination is not a directory: $skillDestination"
            }

            Remove-Item -LiteralPath $skillDestination -Recurse -Force
            $staleSkillsRemoved++
            Write-Output "Removed stale skill directory: $skillDestination"
        }
    }

    $manifestContent = [ordered]@{
        source = 'xiongweilin/agent-skills'
        version = 1
        skills = @($currentSkillNames | Sort-Object -Unique)
    } | ConvertTo-Json -Depth 3
    Set-Content -LiteralPath $manifestPath -Value $manifestContent -Encoding UTF8

    $agentsState = if ($agentsCopied) { 'updated' } else { 'current' }
    Write-Output "[$DestinationRoot] $AgentsRelativePath $agentsState; $($SkillSources.Count) skills, $skillFilesCopied of $skillFileCount files copied, $staleSkillFilesRemoved stale files and $staleSkillsRemoved stale skills removed."
}

$failures = @()
foreach ($destinationRoot in $DestinationRoots) {
    if ([string]::IsNullOrWhiteSpace($destinationRoot)) {
        $failures += 'Empty destination root.'
        continue
    }

    $resolvedRoot = [IO.Path]::GetFullPath($destinationRoot)
    $agentsRelativePath = 'AGENTS.md'
    $mapKey = $resolvedRoot.TrimEnd('\')
    if ($AgentsRelativePaths.ContainsKey($mapKey)) {
        $agentsRelativePath = $AgentsRelativePaths[$mapKey]
    }
    try {
        Sync-Target -DestinationRoot $resolvedRoot -SourceAgents $sourceAgents -SkillSources $skillSources -AgentsRelativePath $agentsRelativePath
    }
    catch {
        $failures += "${resolvedRoot}: $($_.Exception.Message)"
        Write-Warning "Sync failed for ${resolvedRoot}: $($_.Exception.Message)"
    }
}

if ($failures.Count -gt 0) {
    throw ("Synchronization failed for $($failures.Count) destination(s):" + [Environment]::NewLine + ($failures -join [Environment]::NewLine))
}
