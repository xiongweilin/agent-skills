---
name: chezmoi-management
description: "通过 chezmoi 源文件管理 dotfiles。变更触及 chezmoi 管理文件（包括 AGENTS.md）时使用：先编辑源文件，再 apply 到运行时副本，执行一次规范同步检查；只有对应 managed-file 工作流授权时才 commit 和 push。"
---

# Chezmoi 管理

chezmoi 管理的文件（包括全局 AGENTS.md）只有一个事实 owner：chezmoi source 目录中的源文件。直接编辑 runtime 副本会制造竞争 owner。

下面的同步和仓库步骤属于 managed-file closure，不是可选的通用自我审查。只要本 skill 适用，它们仍然是必需步骤，但不能因此重复检查同一个同步事实。

## 何时使用

当变更触及 chezmoi 管理文件（例如 `.codex/AGENTS.md`），或需要定位某个受管 runtime 文件的来源时使用。若只是只读查询来源位置，不要 apply、commit 或 push。

## 方法

1. **编辑源文件。** 在 source root 下定位受管路径（例如 `.codex/AGENTS.md` → `dot_codex/AGENTS.md`），只编辑源文件。
2. **应用到 runtime 副本。** 运行 `chezmoi apply`，让 runtime 副本从源文件重新生成。非交互运行可能停在 “...has changed since chezmoi last wrote it?” 提示；当授权工作流要求覆盖受管目标时，使用 `chezmoi apply --force`。
3. **只检查一次同步。** 使用一个规范检查，直接证明受管目标现在与预期源状态一致。不要叠加 hash、diff 和 managed-list 检查重复确认同一事实。
4. **仅在适用的 managed-file 工作流要求时 commit 和 push。** 不要从只读请求推导出发布仓库的权限。

## 成功信号

runtime 副本已从权威源重新生成；一次同步检查建立了预期状态；任何必须执行的仓库发布步骤也已经完成。
