---
document_type: skill-index

document_status: active
knowledge_scope: skill-governance
---

[![CI](https://github.com/xiongweilin/agent-skills/actions/workflows/ci.yml/badge.svg)](https://github.com/xiongweilin/agent-skills/actions/workflows/ci.yml) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) [![Docs: EN / 中文](https://img.shields.io/badge/docs-EN%20%7C%20%E4%B8%AD%E6%96%87-blue.svg)](README.zh-CN.md)

[English](README.md) | [简体中文](README.zh-CN.md)

# Agent Skills

用于 Agent 工作的可复用工程程序与决策协议。

本仓库不是角色提示词或人格模板集合。每个 skill 都封装一个边界明确的程序，用来处理反复出现的工程问题：保持权限边界、追踪数据来源、限定证据资格、控制副作用、通过最新验证闭合变更、分派独立测试，或在具体工具环境中可靠运行。

目标是让可复用的工程纪律能够按需加载，同时不把始终适用的安全或授权规则移出全局运行时政策。

## 为什么需要 skills

过长的全局指令文件会产生两个相反的问题：

- 如果所有程序都始终加载，操作指南会变得嘈杂且难以维护；
- 如果关键规则只存在于可选 skill 中，Agent 可能完全错过安全、授权、证据或完成门槛。

因此，本仓库把**始终生效的门槛**与**按需执行的程序**分开。

```text
global AGENTS.md
= 必须始终适用的范围 / 授权 / 证据 / 安全 / 完成规则

skill
= 某个门槛被触发时使用的详细程序
```

skill 可以实现某个门槛对应的程序，但不能成为始终适用门槛的唯一规则所有者。

## Skills 防止哪些问题

例如：

- 把历史结论当作当前仍然合格的证据；
- 数据跨系统流动时丢失字段来源；
- 把候选、正式和已弃用状态压成同一个版本；
- 在新状态尚未验证之前执行有后果的替换；
- 仅根据编辑结果就宣告仓库或部署变更完成；
- 在缺少范围、权限或返回契约上下文时让委派 Agent 行动；
- 因为候选方案的作者同时完成了测试，就直接接受该方案；
- 构建与主路径共享同一故障模式的恢复路径；
- 把机器特定事实包装成所谓可复用政策。

这些 skills 通过明确程序降低上述失败模式，而不是通过塑造模型人格来实现。

## 治理边界

- **始终适用的范围、授权、证据、安全门槛和完成要求，继续由已部署的全局 `AGENTS.md` 持有。**
- **Skills 可以实现这些全局规则触发的程序，但不能成为始终适用门槛的唯一所有者。**
- **委派 Agent 的 dispatch prompting 由全局 `AGENTS.md` 路由到 `delegation-prompt-guard`；详细程序位于该 skill 中。**
- **易变化的机器、工作区、服务和环境事实继续保存在其权威事实所有者中，不复制到 skills。**

`codex-agents-md/AGENTS.md` 是已部署全局 Codex 指南的源文件。运行 [`codex-agents-md/sync-codex-agents.ps1`](codex-agents-md/sync-codex-agents.ps1) 可同步已部署副本。

## 当前 skills

| Skill | 工程用途 |
| --- | --- |
| `workflow-authority` | 映射工作流状态、参与者、审批和交接，同时不把工作流进度误当成隐式授权 |
| `data-contract-and-lineage` | 在转换过程中保持字段来源、状态、所有权和版本可追踪 |
| `evidence-qualification-and-revalidation` | 重新检查既有证据和结论在当前范围内是否仍可使用 |
| `candidate-lifecycle` | 明确区分候选、正式、已被替代和已弃用版本 |
| `side-effect-safety` | 约束有后果的状态变化、替换顺序和副作用验证 |
| `change-closure` | 在宣告持久变更完成前，要求最新验证和跨表面一致性 |
| `delegation-prompt-guard` | 为委派 Agent 的派发设置门槛，并准备有边界的搜索或并行工作提示 |
| `independent-search` | 只读搜索一个边界明确的问题，并返回父 Agent 下一目标所需证据 |
| `independent-testing-dispatch` | 定义独立测试交接，并判断后续修复是否使之前的测试基础失效 |
| `independent-testing` | 独立测试一个边界明确的候选，并保存可复用的验证基础 |
| `system-reliability-review` | 检查共因故障、恢复独立性、锁定、重新授权和机动能力 |
| `pwsh-execution` | 可靠执行 PowerShell 工作流，避免 shell 特有的解析和状态错误 |
| `chezmoi-management` | 通过权威 chezmoi 源文件管理 dotfiles，而不是编辑生成副本 |

## 目录结构

每个 skill 都是一个扁平目录，包含 `SKILL.md` 和 `agents/openai.yaml`：

```text
<skill-name>/
├── SKILL.md
└── agents/
    └── openai.yaml
```

`SKILL.md` frontmatter 中的 `name` 必须与目录名一致。目录描述负责说明适用场景；过程检查清单位于 `SKILL.md`。

仓库 CI 会验证 skill 结构和本地文档链接，避免目录静默偏离实际可执行程序文件。

准入标准和安装副本同步流程见 `CONTRIBUTING.md`。
