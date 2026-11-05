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
    agent-skills repository root. Default: the parent of this script's directory

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
    [string]$RepoRoot = (Split-Path -Parent $PSScriptRoot),
    [string[]]$DestinationRoots = @(
        (Join-Path $env:USERPROFILE '.codex'),
        (Join-Path $env:USERPROFILE '.dsh'),
        (Join-Path $env:USERPROFILE '.config\opencode'),
        (Join-Path $env:USERPROFILE '.workbuddy')
    ),
    [hashtable]$AgentsRelativePaths = @{
        (Join-Path $env:USERPROFILE '.workbuddy') = 'rules\AGENTS.md'
    },
    [switch]$ForceManagedOverwrite
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$sourceAgents = Join-Path $RepoRoot 'agents-md\AGENTS.md'
$manifestName = '.xiongweilin-agent-skills-sync.json'

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


function Assert-RelativePath {
    param([Parameter(Mandatory)][string]$Value)
    $normalized = $Value.Replace('\', '/')
    if ([IO.Path]::IsPathRooted($Value) -or $normalized.StartsWith('/') -or
        $normalized -match '(^|/)(\.|\.\.|)(/|$)' -or $normalized.Contains(':') -or
        $normalized -match '[\x00-\x1f]' -or $normalized.EndsWith('/')) {
        throw "Unsafe managed relative path: $Value"
    }
    return $normalized
}

function Get-ExistingFileHash {
    param([Parameter(Mandatory)][string]$Path)
    $entry = Get-Item -LiteralPath $Path -Force -ErrorAction SilentlyContinue
    if ($null -eq $entry) { return $null }
    if ($entry.PSIsContainer -or ($entry.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
        throw "Managed destination is not a regular file: $Path"
    }
    return (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant()
}

function Get-ManifestFiles {
    param([Parameter(Mandatory)][string]$ManifestPath)
    $files = @{}
    if (-not (Test-Path -LiteralPath $ManifestPath)) { return $files }
    $manifest = Get-Content -LiteralPath $ManifestPath -Raw | ConvertFrom-Json -ErrorAction Stop
    if ($null -eq $manifest -or $manifest.source -ne 'xiongweilin/agent-skills' -or
        $manifest.version -notin @(1, 2)) {
        throw "Unsupported ownership manifest: $ManifestPath"
    }
    if ($manifest.version -eq 1) {
        if ($null -eq $manifest.skills -or $manifest.skills -isnot [array]) {
            throw "Invalid legacy manifest: $ManifestPath"
        }
        Write-Warning 'Migrating manifest v1: stale files cannot be safely attributed and will be preserved.'
        return $files
    }
    if ($null -eq $manifest.files -or $manifest.files -isnot [pscustomobject]) {
        throw "Invalid version 2 manifest: $ManifestPath"
    }
    foreach ($entry in $manifest.files.PSObject.Properties) {
        $relative = Assert-RelativePath $entry.Name
        if ($relative -notmatch '^(?:AGENTS\.md|rules/AGENTS\.md|skills/[a-z0-9-]+/.+)$') {
            throw "Unexpected managed file path in manifest: $relative"
        }
        if ($entry.Value -isnot [string] -or $entry.Value -notmatch '^[a-fA-F0-9]{64}$') {
            throw "Invalid file hash in manifest: $relative"
        }
        $files[$relative] = $entry.Value.ToLowerInvariant()
    }
    return $files
}

function Sync-Target {
    param(
        [Parameter(Mandatory)][string]$DestinationRoot,
        [Parameter(Mandatory)][string]$SourceAgents,
        [Parameter(Mandatory)][object[]]$SkillSources,
        [string]$AgentsRelativePath = 'AGENTS.md',
        [switch]$ForceManagedOverwrite
    )

    $agentsPath = Assert-RelativePath $AgentsRelativePath
    $destinationSkills = Join-Path $DestinationRoot 'skills'
    $manifestPath = Join-Path $destinationSkills $manifestName
    $oldFiles = Get-ManifestFiles -ManifestPath $manifestPath
    $desired = @{}
    $desired[$agentsPath] = $SourceAgents
    $skillNames = @()
    foreach ($skillSource in $SkillSources) {
        $skillNames += $skillSource.Name
        foreach ($sourceFile in (Get-ChildItem -LiteralPath $skillSource.FullName -File -Recurse -Force)) {
            if ($sourceFile.Attributes -band [IO.FileAttributes]::ReparsePoint) {
                throw "Skill source may not be a symbolic link: $($sourceFile.FullName)"
            }
            $subPath = $sourceFile.FullName.Substring($skillSource.FullName.Length + 1).Replace('\', '/')
            $relative = Assert-RelativePath "skills/$($skillSource.Name)/$subPath"
            $desired[$relative] = $sourceFile.FullName
        }
    }

    # 写入前检查整个目标，避免遇到后面的冲突才覆盖前面的文件。
    $desiredHashes = @{}
    $copyList = @()
    foreach ($relative in ($desired.Keys | Sort-Object)) {
        $source = $desired[$relative]
        $sourceHash = (Get-FileHash -LiteralPath $source -Algorithm SHA256).Hash.ToLowerInvariant()
        $desiredHashes[$relative] = $sourceHash
        $destination = Join-Path $DestinationRoot ($relative.Replace('/', [IO.Path]::DirectorySeparatorChar))
        $existingHash = Get-ExistingFileHash -Path $destination
        if ($null -ne $existingHash -and $existingHash -ne $sourceHash) {
            $previousHash = if ($oldFiles.ContainsKey($relative)) { $oldFiles[$relative] } else { $null }
            if (-not $ForceManagedOverwrite -and $existingHash -ne $previousHash) {
                throw "Destination conflict; local or unmanaged content would be overwritten: $destination"
            }
        }
        if ($existingHash -ne $sourceHash) {
            $copyList += [pscustomobject]@{ Source = $source; Destination = $destination; Hash = $sourceHash }
        }
    }

    # 仅清理前版清单已登记且仍未被修改的文件。
    $staleDelete = @()
    $stalePreserved = @()
    foreach ($relative in ($oldFiles.Keys | Sort-Object)) {
        if ($desired.ContainsKey($relative)) { continue }
        $destination = Join-Path $DestinationRoot ($relative.Replace('/', [IO.Path]::DirectorySeparatorChar))
        $existingHash = Get-ExistingFileHash -Path $destination
        if ($null -eq $existingHash) { continue }
        if ($existingHash -eq $oldFiles[$relative]) {
            $staleDelete += $destination
        }
        else {
            $stalePreserved += $destination
        }
    }

    foreach ($item in $copyList) {
        $parent = Split-Path -Parent $item.Destination
        if (-not (Test-Path -LiteralPath $parent -PathType Container)) {
            New-Item -ItemType Directory -Path $parent -Force | Out-Null
        }
        Copy-Item -LiteralPath $item.Source -Destination $item.Destination -Force
        if ((Get-ExistingFileHash -Path $item.Destination) -ne $item.Hash) {
            throw "Hash mismatch after copy: $($item.Destination)"
        }
    }
    foreach ($destination in $staleDelete) {
        Remove-Item -LiteralPath $destination -Force
    }
    foreach ($destination in $stalePreserved) {
        Write-Warning "Preserved modified stale file and released ownership: $destination"
    }

    # 只删除空目录，不递归删除未识别的用户内容。
    foreach ($skillSource in $SkillSources) {
        $skillDirectory = Join-Path $destinationSkills $skillSource.Name
        if (Test-Path -LiteralPath $skillDirectory -PathType Container) {
            Get-ChildItem -LiteralPath $skillDirectory -Directory -Recurse -Force |
                Sort-Object { $_.FullName.Length } -Descending |
                Where-Object { -not @(Get-ChildItem -LiteralPath $_.FullName -Force).Count } |
                ForEach-Object { Remove-Item -LiteralPath $_.FullName }
        }
    }

    if (-not (Test-Path -LiteralPath $destinationSkills -PathType Container)) {
        New-Item -ItemType Directory -Path $destinationSkills -Force | Out-Null
    }
    $orderedFiles = [ordered]@{}
    foreach ($relative in ($desiredHashes.Keys | Sort-Object)) {
        $orderedFiles[$relative] = $desiredHashes[$relative]
    }
    $manifestContent = [ordered]@{
        source = 'xiongweilin/agent-skills'
        version = 2
        skills = @($skillNames | Sort-Object -Unique)
        files = $orderedFiles
    } | ConvertTo-Json -Depth 6
    $tempManifest = Join-Path $destinationSkills "$manifestName.tmp-$PID"
    try {
        Set-Content -LiteralPath $tempManifest -Value $manifestContent -Encoding utf8
        Move-Item -LiteralPath $tempManifest -Destination $manifestPath -Force
    }
    finally {
        if (Test-Path -LiteralPath $tempManifest) { Remove-Item -LiteralPath $tempManifest -Force }
    }
    Write-Output "[$DestinationRoot] $($skillNames.Count) skills; $($copyList.Count) files updated, $($staleDelete.Count) owned stale files removed, $($stalePreserved.Count) modified stale files preserved."
}

$failures = @()
foreach ($destinationRoot in $DestinationRoots) {
    if ([string]::IsNullOrWhiteSpace($destinationRoot)) {
        $failures += 'Empty destination root.'
        continue
    }
    $resolvedRoot = [IO.Path]::GetFullPath($destinationRoot)
    $agentsRelativePath = 'AGENTS.md'
    foreach ($rootKey in $AgentsRelativePaths.Keys) {
        if ([IO.Path]::GetFullPath($rootKey).TrimEnd('\', '/') -eq $resolvedRoot.TrimEnd('\', '/')) {
            $agentsRelativePath = $AgentsRelativePaths[$rootKey]
            break
        }
    }
    try {
        Sync-Target -DestinationRoot $resolvedRoot -SourceAgents $sourceAgents -SkillSources $skillSources -AgentsRelativePath $agentsRelativePath -ForceManagedOverwrite:$ForceManagedOverwrite
    }
    catch {
        $failures += "$($resolvedRoot): $($_.Exception.Message)"
        Write-Warning "Sync failed for $($resolvedRoot): $($_.Exception.Message)"
    }
}
if ($failures.Count -gt 0) {
    throw ("Synchronization failed for $($failures.Count) destination(s):" +
        [Environment]::NewLine + ($failures -join [Environment]::NewLine))
}
