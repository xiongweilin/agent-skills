---
name: delegation-prompt-guard
description: 在一个已经获得授权的非测试委派即将 dispatch 前立即使用，用于准备最小充分的外发任务并保持权限边界。普通本地工作、独立测试或从另一个 Agent 收到的 prompt 不使用。
---

# 委派提示保护

仅在当前 Agent 已经从用户或适用仓库规则获得 delegation 权限，并即将调用非测试 delegation 工具时使用。本 skill 用于准备 dispatch，不会创造 delegation 权限。

## Dispatch gate

- 只 dispatch 已经授权、边界明确的目标。
- 调用 delegation 工具之前，确保外发 prompt 包含精确句子：“不要派发智能体，由你执行”。
- 只给接收 Agent 完成该目标所需的上下文和权限。
- 除非接收 Agent 本身被明确授权继续 dispatch，否则不要把本 skill 传给它。
- 有顺序依赖时，只 dispatch 当前目标；等当前结果返回后再形成依赖性的后续目标。
- 当 delegated Agent 不再需要时，及时关闭。

## 独立搜索委派

当独立搜索委派已经获得授权，而且 substantial search 是边界明确的目标时：

- 本轮只 dispatch 一个 search Agent。
- 包含精确句子 `你是独立搜索子智能体。`，并要求使用 `independent-search`。
- 明确边界搜索问题和范围，并保持任务只读。
- 不要把后续设计、实现、修复、测试或决策工作打包进 search prompt。

## 并行简单工作

当并行 delegation 已经获得授权，而且多个简单单元确实彼此独立时：

- 把它们划分为边界明确、互不重叠的单元。
- 只有不存在顺序依赖、共享可变状态或重叠写入范围的单元才并行。
- 每个 Agent 只获得其分配单元和必要上下文。
