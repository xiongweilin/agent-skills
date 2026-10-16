[CmdletBinding()]
param(
    [string]$Destination = (Join-Path $env:USERPROFILE '.codex\AGENTS.md'),
    [string]$SkillsDestination = (Join-Path $env:USERPROFILE '.codex\skills')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$source = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot 'AGENTS.md'))
if (-not (Test-Path -LiteralPath $source -PathType Leaf)) {
    throw "AGENTS source not found: $source"
}

$destinationParent = Split-Path -Parent $Destination
if (-not (Test-Path -LiteralPath $destinationParent -PathType Container)) {
    New-Item -ItemType Directory -Path $destinationParent -Force | Out-Null
}

$sourceHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $source).Hash
$destinationHash = $null
if (Test-Path -LiteralPath $Destination -PathType Leaf) {
    $destinationHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $Destination).Hash
}

if ($sourceHash -ne $destinationHash) {
    Copy-Item -LiteralPath $source -Destination $Destination -Force
}

$afterHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $Destination).Hash
if ($afterHash -ne $sourceHash) {
    throw "Runtime AGENTS hash mismatch after synchronization: $Destination"
}

Write-Output "Synchronized $Destination from $source (SHA256 $afterHash)."

$skillsSourceRoot = [IO.Path]::GetFullPath((Split-Path -Parent $PSScriptRoot))
$skillsDestinationRoot = [IO.Path]::GetFullPath($SkillsDestination)
$skillSources = @(Get-ChildItem -LiteralPath $skillsSourceRoot -Directory | Where-Object {
    Test-Path -LiteralPath (Join-Path $_.FullName 'SKILL.md') -PathType Leaf
})
if ($skillSources.Count -eq 0) {
    throw "No skill sources found under: $skillsSourceRoot"
}

if (-not (Test-Path -LiteralPath $skillsDestinationRoot -PathType Container)) {
    New-Item -ItemType Directory -Path $skillsDestinationRoot -Force | Out-Null
}

$manifestPath = Join-Path $skillsDestinationRoot '.xiongweilin-agent-skills-sync.json'
$currentSkillNames = @($skillSources | Select-Object -ExpandProperty Name)
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
    # Adopt the skills currently synchronized by the previous script version.
    $previousManagedSkillNames = @($currentSkillNames)
}

$skillFilesByName = @{}
foreach ($skillSource in $skillSources) {
    $skillFilesByName[$skillSource.Name] = @(Get-ChildItem -LiteralPath $skillSource.FullName -File -Recurse -Force)
}

$skillFileCount = 0
$skillFilesCopied = 0
foreach ($skillSource in $skillSources) {
    $skillDestination = Join-Path $skillsDestinationRoot $skillSource.Name
    $sourceFiles = $skillFilesByName[$skillSource.Name]
    foreach ($sourceFile in $sourceFiles) {
        $relativePath = $sourceFile.FullName.Substring($skillSource.FullName.Length + 1)
        $destinationFile = Join-Path $skillDestination $relativePath
        $destinationParent = Split-Path -Parent $destinationFile
        if (-not (Test-Path -LiteralPath $destinationParent -PathType Container)) {
            New-Item -ItemType Directory -Path $destinationParent -Force | Out-Null
        }

        $sourceFileHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $sourceFile.FullName).Hash
        $destinationFileHash = $null
        if (Test-Path -LiteralPath $destinationFile -PathType Leaf) {
            $destinationFileHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $destinationFile).Hash
        }

        if ($sourceFileHash -ne $destinationFileHash) {
            Copy-Item -LiteralPath $sourceFile.FullName -Destination $destinationFile -Force
            $skillFilesCopied++
        }

        $afterFileHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $destinationFile).Hash
        if ($afterFileHash -ne $sourceFileHash) {
            throw "Runtime skill hash mismatch after synchronization: $destinationFile"
        }
        $skillFileCount++
    }
}

$staleSkillFilesRemoved = 0
foreach ($skillSource in $skillSources) {
    $skillDestination = Join-Path $skillsDestinationRoot $skillSource.Name
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
    }
}

$staleSkillsRemoved = 0
foreach ($managedSkillName in $previousManagedSkillNames) {
    if ($currentSkillNames -contains $managedSkillName) {
        continue
    }

    $skillDestination = Join-Path $skillsDestinationRoot $managedSkillName
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

Write-Output "Synchronized $($skillSources.Count) skills ($skillFilesCopied of $skillFileCount files copied) to $skillsDestinationRoot."
Write-Output "Removed $staleSkillFilesRemoved stale files and $staleSkillsRemoved stale skills."
