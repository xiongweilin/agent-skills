<#
.SYNOPSIS
    Deploy the neutral AGENTS.md and agent skills to the DSH user-global locations.

.DESCRIPTION
    Source: <RepoRoot>\agents-md\AGENTS.md, plus every <RepoRoot>\<name>\SKILL.md bundle.
    Destination: $env:USERPROFILE\.dsh\AGENTS.md and $env:USERPROFILE\.dsh\skills\<name>\...

    The source is copied verbatim; no harness-specific substitutions are applied.
    Files are copied only when their SHA-256 differs, and every copy is verified.
    Stale files inside a synced skill directory are removed; unrelated skill
    directories are left untouched.

.PARAMETER RepoRoot
    agent-skills repository root. Default: D:\agent\agent-skills

.PARAMETER DestinationRoot
    DSH home directory. Default: $env:USERPROFILE\.dsh

.EXAMPLE
    pwsh -NoProfile -File .\sync-dsh-agents.ps1
#>
[CmdletBinding()]
param(
    [string]$RepoRoot = 'D:\agent\agent-skills',
    [string]$DestinationRoot = (Join-Path $env:USERPROFILE '.dsh')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$sourceAgents = Join-Path $RepoRoot 'agents-md\AGENTS.md'
$destinationAgents = Join-Path $DestinationRoot 'AGENTS.md'
$destinationSkills = Join-Path $DestinationRoot 'skills'

if (-not (Test-Path -LiteralPath $RepoRoot -PathType Container)) {
    throw "Repository root not found: $RepoRoot"
}
if (-not (Test-Path -LiteralPath $sourceAgents -PathType Leaf)) {
    throw "AGENTS source not found: $sourceAgents"
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

if (Copy-VerifiedFile -Source $sourceAgents -Destination $destinationAgents) {
    Write-Output "Deployed AGENTS.md -> $destinationAgents"
}
else {
    Write-Output "AGENTS.md already current -> $destinationAgents"
}

$skillSources = @(Get-ChildItem -LiteralPath $RepoRoot -Directory |
    Where-Object { Test-Path -LiteralPath (Join-Path $_.FullName 'SKILL.md') -PathType Leaf } |
    Sort-Object Name)

if ($skillSources.Count -eq 0) {
    throw "No skill bundles found under: $RepoRoot"
}

if (-not (Test-Path -LiteralPath $destinationSkills -PathType Container)) {
    New-Item -ItemType Directory -Path $destinationSkills -Force | Out-Null
}

$fileTotal = 0
$fileCopied = 0
$fileRemoved = 0

foreach ($skillSource in $skillSources) {
    $skillDestination = Join-Path $destinationSkills $skillSource.Name
    $expectedFiles = @{}

    foreach ($sourceFile in Get-ChildItem -LiteralPath $skillSource.FullName -File -Recurse -Force) {
        $relativePath = $sourceFile.FullName.Substring($skillSource.FullName.Length + 1)
        $expectedFiles[$relativePath] = $true
        if (Copy-VerifiedFile -Source $sourceFile.FullName -Destination (Join-Path $skillDestination $relativePath)) {
            $fileCopied++
        }
        $fileTotal++
    }

    if (Test-Path -LiteralPath $skillDestination -PathType Container) {
        foreach ($destinationFile in Get-ChildItem -LiteralPath $skillDestination -File -Recurse -Force) {
            $relativePath = $destinationFile.FullName.Substring($skillDestination.Length + 1)
            if (-not $expectedFiles.ContainsKey($relativePath)) {
                Remove-Item -LiteralPath $destinationFile.FullName -Force
                $fileRemoved++
            }
        }

        Get-ChildItem -LiteralPath $skillDestination -Directory -Recurse -Force |
            Sort-Object { $_.FullName.Length } -Descending |
            Where-Object { -not (Get-ChildItem -LiteralPath $_.FullName -Force) } |
            ForEach-Object { Remove-Item -LiteralPath $_.FullName -Force }
    }
}

Write-Output "Synced $($skillSources.Count) skill bundles ($fileCopied of $fileTotal files copied, $fileRemoved stale files removed) -> $destinationSkills"
