---
name: workflow-authority
description: 仅在设计或实质修改一个包含多个 actor、人工审批、delegated authority、retry 或外部副作用的持久工作流之前使用。普通函数、单 owner 编辑、简单读取或日常 API 变更不要触发。
---

# 工作流权限

当 state、authority 和 responsibility 跨越 actor 或系统边界时，使用本 skill 生成紧凑工作流图。不要把普通实现变成治理演习。

## 程序

1. 识别 trigger、input、state、terminal state、retryable state 和 invalid transition。
2. 映射 proposal、validation、approval、execution、veto、affected subject、compensation、accountability 和 audit ownership。
3. 标出 human node、automated node、deterministic guard、external effect 和 exception path。
4. 指明证明每个重要 transition 所需的 evidence 和 metric。

模型和规则可以 propose、classify、validate 和 route，但不能授予 authority，也不能成为不可逆 transition 的 owner。

## 输出

返回一张紧凑的 state/actor map，并列出每个 transition 的 owner。不要增加一般治理理论，也不要重设计系统无关部分。
