---
name: independent-testing-dispatch
description: 仅在独立测试已依据当前政策得到充分理由并获得授权之后使用，无论来自明确请求、适用规则要求，还是高门槛 independent-testing gate 的自主许可。用于准备边界明确的 handoff，并判断后续变更是否使既有 testing basis 失效。
---

# 独立测试 Dispatch

只在 implementing/parent Agent 中、且独立测试权限已经存在时使用。本 skill 管理 handoff 和复用边界；它不负责决定独立测试是否值得做。

## 准备可测试候选

完成一个连贯实现阶段后再 dispatch。不要每完成一个小实现步骤就 dispatch。

当边界变更已经足够连贯、可以整体测试时，候选就算 ready。候选规模、复杂度、风险或重要性本身都不能独立证明测试有必要。

## 准备 handoff

外发 prompt 必须包含精确句子 `你是独立测试子智能体。`，并说明：

- 边界候选和测试范围；
- 权威验收依据或仓库契约；
- 重要环境或依赖约束；
- 当前授权边界。

明确任务是独立测试，而不是 code review。independent-testing 子 Agent 在该边界内负责选择最小充分的正确性测试策略。

只有当本地可执行检查、GitHub CI 或 required status check 属于权威验收依据或适用强制工作流时才加入。不要为了制造更多证据扩大权限。

## 等待结果

dispatch 后等待一个终止测试结果。重复 wait/poll 可能是正常现象，本身不会证明需要再次 dispatch 或扩大检查。

只有子 Agent 返回、runtime 报告终止失败/取消、用户介入，或具体证据说明 delegated run 已无法完成时才停止等待。

## 复用或更新 testing basis

既有 testing basis 可以复用，直到一个具体已覆盖假设或义务被实质改变。

在该 basis 内进行后续修复时，只重新运行其证据被修复实际使失效的最小既有检查。不要仅因为实现变化就自动重跑完整本地 suite、对应 GitHub CI 或独立测试。

只有在权限仍存在，且后续变化实质性地使既有 basis 失效或超出该 basis 时，才重新 dispatch 独立测试。例如：行为、契约、架构、集成边界、依赖假设、状态或 migration 语义、并发、授权、恢复行为，或验收依据本身发生重要变化。

如果无法指出具体失效点，就复用已有 qualified basis。
