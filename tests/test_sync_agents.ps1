# 在临时目录中验证同步的归属边界、冲突保护及升级路径。
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$scriptPath = Join-Path (Split-Path -Parent $PSScriptRoot) 'agents-md\sync-agents.ps1'
$root = Join-Path ([IO.Path]::GetTempPath()) "agent-skills-sync-test-$PID"
$repo = Join-Path $root 'repo'
$target = Join-Path $root 'runtime'
$skill = Join-Path $repo 'example-skill'

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}
function File-Hash([string]$Path) {
    return (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant()
}
function Sync([switch]$ForceManagedOverwrite) {
    & $scriptPath -RepoRoot $repo -DestinationRoots @($target) -AgentsRelativePaths @{} -ForceManagedOverwrite:$ForceManagedOverwrite | Out-Null
}

try {
    foreach ($directory in @((Join-Path $repo 'agents-md'), $skill, $target)) {
        New-Item -ItemType Directory -Path $directory -Force | Out-Null
    }
    Set-Content -LiteralPath (Join-Path $repo 'agents-md\AGENTS.md') -Value 'policy-v1' -Encoding utf8
    Set-Content -LiteralPath (Join-Path $skill 'SKILL.md') -Value 'skill-v1' -Encoding utf8
    Sync
    $installedSkill = Join-Path $target 'skills\example-skill\SKILL.md'
    $installedAgents = Join-Path $target 'AGENTS.md'
    $manifestPath = Join-Path $target 'skills\.xiongweilin-agent-skills-sync.json'
    Assert-True ((Get-Content -LiteralPath $installedSkill -Raw).Contains('skill-v1')) 'Initial skill sync failed'
    $manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
    Assert-True ($manifest.version -eq 2) 'Manifest must have version 2'
    Assert-True ($manifest.files.'skills/example-skill/SKILL.md' -eq (File-Hash $installedSkill)) 'Ownership hash mismatch'

    # 重复同步不得删除技能目录里未管理的自定义文件。
    $custom = Join-Path $target 'skills\example-skill\notes.txt'
    Set-Content -LiteralPath $custom -Value 'user-owned' -Encoding utf8
    Sync
    Assert-True (Test-Path -LiteralPath $custom) 'Unmanaged file must survive resync'

    # 源文件变更应正确替换未被用户修改的已管理副本。
    Set-Content -LiteralPath (Join-Path $skill 'SKILL.md') -Value 'skill-v2' -Encoding utf8
    Sync
    Assert-True ((Get-Content -LiteralPath $installedSkill -Raw).Contains('skill-v2')) 'Managed update failed'

    # 手工修改的已管理文件必须阻止默认覆盖。
    Set-Content -LiteralPath $installedSkill -Value 'user-changed' -Encoding utf8
    Set-Content -LiteralPath (Join-Path $skill 'SKILL.md') -Value 'skill-v3' -Encoding utf8
    $blocked = $false
    try { Sync } catch { $blocked = $true }
    Assert-True $blocked 'Locally edited managed file must block overwrite'
    Assert-True ((Get-Content -LiteralPath $installedSkill -Raw).Contains('user-changed')) 'Conflict destroyed local edit'
    Sync -ForceManagedOverwrite
    Assert-True ((Get-Content -LiteralPath $installedSkill -Raw).Contains('skill-v3')) 'Explicit overwrite failed'

    # 已登记且未修改的过期文件可以清理，新增文件不能误删。
    $extraSource = Join-Path $skill 'obsolete.txt'
    Set-Content -LiteralPath $extraSource -Value 'previously-owned' -Encoding utf8
    Sync
    Remove-Item -LiteralPath $extraSource
    Sync
    Assert-True (-not (Test-Path -LiteralPath (Join-Path $target 'skills\example-skill\obsolete.txt'))) 'Owned stale file not removed'
    Assert-True (Test-Path -LiteralPath $custom) 'Custom file must not be removed with stale file'

    # 变更过的过期文件保留，且释放其所有权。
    Set-Content -LiteralPath $extraSource -Value 'recreated' -Encoding utf8
    Sync
    $extraDest = Join-Path $target 'skills\example-skill\obsolete.txt'
    Set-Content -LiteralPath $extraDest -Value 'customized' -Encoding utf8
    Remove-Item -LiteralPath $extraSource
    Sync
    Assert-True (Test-Path -LiteralPath $extraDest) 'Modified stale file should survive'
    $manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
    Assert-True ($manifest.files.PSObject.Properties.Name -notcontains 'skills/example-skill/obsolete.txt') 'Stale file must be released from ownership'

    # 不拥有旧副本的 v1 清单升级时不得误删未知文件。
    $legacy = [ordered]@{ source = 'xiongweilin/agent-skills'; version = 1; skills = @('example-skill') } | ConvertTo-Json
    Set-Content -LiteralPath $manifestPath -Value $legacy -Encoding utf8
    Sync
    Assert-True (Test-Path -LiteralPath $custom) 'Legacy migration deleted unowned file'

    # 独立目标目录下，WorkBuddy 风格 AGENTS.md 路径应被支持。
    $other = Join-Path $root 'workbuddy'
    & $scriptPath -RepoRoot $repo -DestinationRoots @($other) -AgentsRelativePaths @{ $other = 'rules\AGENTS.md' } | Out-Null
    Assert-True (Test-Path -LiteralPath (Join-Path $other 'rules\AGENTS.md')) 'WorkBuddy policy destination missing'
    Assert-True (Test-Path -LiteralPath $installedAgents) 'Original policy missing'

    # 自定义规则路径必须能连续同步并被写入 v2 归属清单。
    $customRoot = Join-Path $root 'custom-policy'
    & $scriptPath -RepoRoot $repo -DestinationRoots @($customRoot) -AgentsRelativePaths @{ $customRoot = 'config\agent\AGENTS.md' } | Out-Null
    & $scriptPath -RepoRoot $repo -DestinationRoots @($customRoot) -AgentsRelativePaths @{ $customRoot = 'config\agent\AGENTS.md' } | Out-Null
    $customManifest = Get-Content -LiteralPath (Join-Path $customRoot 'skills\.xiongweilin-agent-skills-sync.json') -Raw | ConvertFrom-Json
    Assert-True ($customManifest.agents_path -eq 'config/agent/AGENTS.md') 'Custom policy ownership path not recorded'

    # 删除整个 skill 后仅清理已归属的文件和空目录。
    New-Item -ItemType Directory -Path (Join-Path $repo 'replacement-skill') -Force | Out-Null
    Set-Content -LiteralPath (Join-Path $repo 'replacement-skill\SKILL.md') -Value 'replacement' -Encoding utf8
    Remove-Item -LiteralPath $skill -Recurse -Force
    & $scriptPath -RepoRoot $repo -DestinationRoots @($other) -AgentsRelativePaths @{ $other = 'rules\AGENTS.md' } | Out-Null
    Assert-True (-not (Test-Path -LiteralPath (Join-Path $other 'skills\example-skill'))) 'Empty retired skill directory should be removed'

    # 恶意清单路径不得触发越界操作。
    $badManifest = [ordered]@{
        source = 'xiongweilin/agent-skills'
        version = 2
        agents_path = 'AGENTS.md'
        skills = @('example-skill')
        files = [ordered]@{ 'skills/../unexpected' = ('0' * 64) }
    } | ConvertTo-Json -Depth 6
    Set-Content -LiteralPath $manifestPath -Value $badManifest -Encoding utf8
    $blockedPath = $false
    try { Sync } catch { $blockedPath = $true }
    Assert-True $blockedPath 'Unsafe manifest path must be rejected'

    Write-Output 'sync-agents tests OK'
}
finally {
    if (Test-Path -LiteralPath $root) { Remove-Item -LiteralPath $root -Recurse -Force }
}
