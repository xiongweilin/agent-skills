---
name: system-reliability-review
description: 仅当持久或长期运行的系统、工作流、标准或基础设施依赖需要检查 common-mode failure、恢复独立性、lock-in、重新授权或未来机动能力丧失时使用。一次性变更、日常调试、普通可观测性或单组件韧性检查不要触发。
---

# 系统可靠性审查

使用本 skill 检查一个持续运行的系统，是否仍能发现重要故障、阻止有害传播、恢复控制，并随着时间改变方向。不要把可靠性压成单一分数。

## 审查维度

1. **纠正闭环：**识别 observation、dissent、verification、correction 和 memory 路径。检查名义上独立的路径是否共享相同数据、模型、operator、incentive、authority 或技术根。
2. **故障隔离：**区分正常运行依赖、故障传播依赖和恢复依赖。识别会同时击穿主路径和恢复路径的 common cause。
3. **速率兼容：**比较 detection、judgment、stopping、recovery、reauthorization 延迟，与 damage accumulation、propagation 和 lock-in 速度。
4. **有效可逆性：**分别检查 state、control，以及形成和执行替代方案所需 knowledge 是否真正可恢复。
5. **重新授权：**寻找 temporary、emergency、elevated 或长期权限，并确认 expiry、review、takeover 和 termination 路径仍然真实存在。
6. **机动能力：**检查替代 supplier、implementation、model、operator、migration path、control entry point，以及所需知识/资源是否仍能现实取得。

## 最低规则

- 多个 validator 如果共享同一 failure source，就不构成独立性。
- 运行冗余不能证明恢复冗余。
- 有 rollback 机制不等于具备有效可逆性。
- 曾经获得授权不等于现在仍然获得授权。
- 更多选项不自动更好；审查关注的是当前路径失败时，是否仍有真正可用的重要替代方案。

本 skill 不替代针对具体 mutation 的 `side-effect-safety`，也不替代变更后验证使用的 `change-closure`。它同样不替代 security threat modeling 或 observability design；它审查的是跨时间的 failure structure 与 recovery capacity。

## 输出

按维度返回 reliability profile、重要 common cause 或 lock-in 路径、缺失的独立 stop/recovery 能力，以及所需的具体 review、reauthorization、diversification、containment 或 recovery 行动。
