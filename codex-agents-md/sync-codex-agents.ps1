[CmdletBinding()]
param(
    [string]$Destination = (Join-Path $env:USERPROFILE '.codex\AGENTS.md')
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
