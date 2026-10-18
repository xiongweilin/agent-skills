---
name: chezmoi-management
description: "用于管理由 chezmoi 实际跟踪的文件，或定位受管 runtime 文件的源文件。全局 AGENTS.md 不由 chezmoi 跟踪，不属于本 skill 的适用范围。"
---

# Chezmoi 管理

chezmoi 只拥有其实际跟踪的 dotfiles。全局 Codex `AGENTS.md` 不由 chezmoi 跟踪；其权威源位于 `codex-agents-md/AGENTS.md`，运行副本由 `codex-agents-md/sync-codex-agents.ps1` 同步。不要把全局 `AGENTS.md` 当作 chezmoi 管理文件，也不要对它运行 `chezmoi apply`。

下面的同步和仓库步骤属于 managed-file closure，不是可选的通用自我审查。只要本 skill 适用，它们仍然是必需步骤，但不能因此重复检查同一个同步事实。

## 何时使用

当变更触及已确认由 chezmoi 跟踪的文件，或需要定位某个受管 runtime 文件的源文件时使用。全局 Codex `AGENTS.md` 不属于本 skill 的适用范围。若只是只读查询来源位置，不要 apply、commit 或 push。

## 方法

1. **编辑源文件。** 在 chezmoi source root 下定位确切的受管路径，只编辑对应源文件；不要猜测源路径或直接编辑运行副本。
2. **应用到 runtime 副本。** 运行 `chezmoi apply`，让 runtime 副本从源文件重新生成。非交互运行可能停在 “...has changed since chezmoi last wrote it?” 提示；当授权工作流要求覆盖受管目标时，使用 `chezmoi apply --force`。
3. **只检查一次同步。** 使用一个规范检查，直接证明受管目标现在与预期源状态一致。不要叠加 hash、diff 和 managed-list 检查重复确认同一事实。
4. **仅在适用的 managed-file 工作流要求时 commit 和 push。** 不要从只读请求推导出发布仓库的权限。

## 成功信号

runtime 副本已从权威源重新生成；一次同步检查建立了预期状态；任何必须执行的仓库发布步骤也已经完成。
