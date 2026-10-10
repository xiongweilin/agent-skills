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

$skillFileCount = 0
$skillFilesCopied = 0
foreach ($skillSource in $skillSources) {
    $skillDestination = Join-Path $skillsDestinationRoot $skillSource.Name
    $sourceFiles = @(Get-ChildItem -LiteralPath $skillSource.FullName -File -Recurse -Force)
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

Write-Output "Synchronized $($skillSources.Count) skills ($skillFilesCopied of $skillFileCount files copied) to $skillsDestinationRoot."
