---
name: side-effect-safety
description: 仅用于已经授权、且存在重大不可逆或外部可见 blast radius、回滚困难或明显 partial-failure 风险的状态变更。不要只根据操作类别或关键词触发，也不要用于普通可逆本地编辑。
---

# 副作用安全

只有待执行 effect 的真实风险足以证明额外安全工作有必要时才使用。本 skill 不会创造 effect 权限，也不是通用 validation checklist。

执行 effect 前：

1. 如果精确 target 和 scope 尚未建立，先解析它们。
2. 只识别安全执行真正需要的重要 blast radius、partial-failure mode、reversibility 和 rollback/compensation path。
3. 当 retry 确实可能发生时，让 retry 具备幂等性或明确边界。
4. 只有拆分工作会实质改善恢复能力或防止不可逆部分失败时才拆分。

如果淘汰旧资源会让恢复明显更困难，在淘汰前先确认恢复所需的 replacement 或 backup 可用。

effect 完成后，只有当 operation result 含糊、effect 是外部异步的，或后续不可逆动作依赖结果状态时，才执行一次直接状态检查。否则，把确定性的成功 operation result 直接作为该操作的证据。

不要仅因为某类操作“通常这么做”就添加额外安全步骤、检查、备份或 retry。

## 成功信号

有后果的 effect 已被限制在边界内，必要时可恢复；所有额外安全工作都只覆盖真实风险要求的部分。
