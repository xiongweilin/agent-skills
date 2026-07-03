# Skills

本目录存放可复用的任务操作规则，用于在特定场景中稳定触发检查、约束和执行步骤。

这些规则不是通用建议，也不是写作风格模板。它们面向反复出现、容易被低估的执行风险：判断被悄悄替换、问题边界没有钉住、临时规则被写成正式规则、外部副作用失控、验证证据不足、完成状态被过度声称、多个小例外逐步侵蚀系统边界、工作流被简化成一句“让 agent 处理”、授权责任不清、数据来源和状态混淆，以及候选方案未经纪律化晋升就被当成正式能力。

每个 skill 目录对应一个独立主题，通常包含：

```text
<skill-name>/
└── SKILL.md
```

`SKILL.md` 描述该主题的适用场景、跳过条件、核心原则、检查步骤和成功信号。不同 skill 之间保持独立，但可以在复杂任务中组合使用。

## 目录结构

当前 skills 以编号排序，编号仅表示阅读和维护顺序，不表示总是按顺序触发。

```text
skills/
├── README.md
├── judgment-ownership/
│   └── SKILL.md
├── problem-framing/
│   └── SKILL.md
├── rule-state-hygiene/
│   └── SKILL.md
├── side-effect-safety/
│   └── SKILL.md
├── verification-skepticism/
│   └── SKILL.md
├── scope-honesty-and-stopping/
│   └── SKILL.md
├── incremental-erosion/
│   └── SKILL.md
├── workflow-decomposition/
│   └── SKILL.md
├── authorization-map/
│   └── SKILL.md
├── data-contract-and-lineage/
│   └── SKILL.md
└── rollout-and-promotion/
    └── SKILL.md
```

## Skill 索引

| Skill                        | 主要用途                                                     | 核心保护对象                                                                               |
| ---------------------------- | -------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| `judgment-ownership`         | 用于战略、架构、定位、命名、品味、承诺类问题                                   | 保留用户原始判断框架，避免助手把自己的重构伪装成中立答案                                                         |
| `problem-framing`            | 用于写代码、改架构、加缓存、配置、校验、清理、数据摄入前                             | 先明确对象、范围、遗漏、契约和成功信号，避免精确地解决错问题                                                       |
| `rule-state-hygiene`         | 用于业务规则、配置、mock、fixture、README、迁移说明和临时规则                  | 区分 candidate、official、deprecated，避免临时材料泄漏成正式规则                                       |
| `side-effect-safety`         | 用于邮件、短信、数据库写入、删除、迁移、外部 API 写入、队列发布、基础设施变更                | 将决策与副作用分离，用确定性守卫、幂等、补偿和显式失败路径保护不可逆操作                                                 |
| `verification-skepticism`    | 用于声称代码可用、bug 已修、任务完成、更安全、更快、更稳之前                         | 主动尝试推翻完成声明，检查测试是否覆盖真实变更路径和真实回归                                                       |
| `scope-honesty-and-stopping` | 用于收尾、状态汇报、PR 描述、交接、停止继续加工时                               | 清楚区分已完成、已验证、假设、mock、stub、未测和不处理的范围                                                   |
| `incremental-erosion`        | 用于重复出现的跳测、弱断言、降低阈值、特殊分支、临时绕过                             | 识别多个小例外造成的累计退化，而不是默默再加一个例外                                                           |
| `workflow-decomposition`     | 用于 RPA、ERP/CRM/BI、客服、审批、catalog、agentic operations 等业务流程 | 把工作流拆成输入、状态机、自动节点、人工节点、守卫、副作用、异常、证据和指标                                               |
| `authorization-map`          | 用于模型、规则、人、系统或组织共同采取会影响资源、记录、客户、政策或公开沟通的行动                | 明确提议、验证、批准、执行、否决、受影响方、补偿、问责和审计边界                                                     |
| `data-contract-and-lineage`  | 用于抽取、分类、报表、BI、评估、审计、同步、SOP、catalog enrichment 等数据流       | 保持字段来源、状态、写入者、验证、血缘、版本和使用限制可追踪                                                       |
| `rollout-and-promotion`      | 用于 prompt、规则、阈值、workflow、模型、数据集、评估结果从实验进入正式行为            | 用 draft → candidate → frozen → scored → promoted / unpromoted / deprecated 管理晋升和对外声明 |

## 使用原则

不要把所有 skill 机械套到每个任务上。先判断任务风险，再触发相关 skill。

优先触发那些能阻止实质性错误的 skill，而不是只改善表达的 skill。一个简单格式修改通常不需要完整流程；一个会写入 CRM、发送邮件、影响客户记录或生成对外质量声明的流程，需要多个 skill 组合。

当多个 skill 同时适用时，按风险发生的阶段组合：先界定问题，再确定规则状态，再拆解工作流和授权，再保护副作用，再验证，再诚实收尾。涉及数据或评估晋升时，必须额外处理数据血缘和版本绑定。

## 常见组合

### 代码实现或修复

```text
problem-framing
→ rule-state-hygiene（如果涉及业务规则、配置、fixture 或文档声明）
→ side-effect-safety（如果有外部写入或不可逆操作）
→ verification-skepticism
→ scope-honesty-and-stopping
```

目标是先防止做错问题，再防止临时规则污染正式行为，最后防止用不足的测试或模糊总结声称完成。

### Agent / RPA / 业务工作流

```text
workflow-decomposition
→ authorization-map
→ data-contract-and-lineage
→ side-effect-safety
→ rollout-and-promotion（如果候选流程会被评估、发布或称为正式能力）
→ scope-honesty-and-stopping
```

目标是避免把业务流程压缩成“模型处理”。工作流必须显示状态、责任、授权、证据、异常路径、外部写入和可观测指标。

### Prompt、规则、阈值或评估体系

```text
judgment-ownership
→ rule-state-hygiene
→ data-contract-and-lineage
→ verification-skepticism
→ rollout-and-promotion
```

目标是保留设计判断，区分候选规则和正式规则，并确保任何质量声明都绑定版本、数据集、评分脚本和晋升记录。

### 文档、README、SOP 或公开声明

```text
judgment-ownership（如果文档承载定位、策略或取舍）
→ rule-state-hygiene
→ rollout-and-promotion（如果声明某能力已正式支持）
→ scope-honesty-and-stopping
```

目标是让文档与系统真实状态一致。mock、demo、fallback、单次实验或未晋升候选不能写成生产能力。

### 重复小例外或质量门槛下降

```text
incremental-erosion
→ rule-state-hygiene
→ verification-skepticism
→ scope-honesty-and-stopping
```

目标是识别累计方向。一次跳测可能只是局部权衡；同类跳测、弱断言、降低阈值或临时绕过反复出现时，必须命名模式、记录风险，并给出修复或退出条件。

## `SKILL.md` 编写约定

每个 `SKILL.md` 应包含 frontmatter：

```yaml
---
name: skill-name
description: One sentence describing when and why this skill should trigger.
---
```

正文通常包含：

```text
# Skill Title

## Use when
触发场景。

## Skip when / Skip
跳过条件。

## Core rule / Behavior / Checklist
执行原则或检查步骤。

## Output check / Success signal
完成前的检查或可观察成功信号。
```

写 skill 时应避免三类问题：

1. 把偏好写成规则。只有能稳定减少误判、风险或返工的内容才应沉淀为 skill。
    
2. 把候选实践写成正式要求。实验、mock、临时绕过和单次经验应标为 candidate，不能直接进入 official 规则。
    
3. 与已有 skill 重叠但不说明边界。新 skill 应有独立触发条件和明确跳过条件。
    

## 维护规则

新增或修改 skill 前，先判断它解决的是哪类反复风险，而不是哪类一次性任务。

修改现有 skill 时，应同时检查：

- 触发条件是否过宽，导致低风险任务被过度流程化。
    
- 跳过条件是否清楚，避免 trivial task 被拖慢。
    
- 检查步骤是否可执行，而不是抽象价值观。
    
- 是否把候选、正式、废弃规则混在一起。
    
- 是否会把模型判断、人工批准、系统执行和组织责任混为一谈。
    
- 是否需要版本、数据来源、评估记录或晋升状态来支撑对外声明。
    

删除或废弃 skill 时，不要直接移除上下文。应把它标为 deprecated，说明替代 skill、保留原因和不再用于新任务的边界。

## 判断是否需要新增 skill

满足以下条件时，才考虑新增 skill：

- 同类错误已经重复出现，或一旦出现会造成高成本返工、错误写入、错误授权、错误声明或真实损害。
    
- 错误无法靠普通注意力稳定避免，需要明确触发条件和检查步骤。
    
- 该规则可以跨多个任务复用，而不是只服务一次对话或一个项目。
    
- 它与已有 skill 的边界清楚，或者能明确替代、合并、拆分已有 skill。
    

如果只是一次性提醒、局部代码风格、个人偏好或尚未验证的工作假设，不应新增 skill；可以先记录为 candidate 观察项。

## 总体目标

这些 skills 的目标不是让任务变复杂，而是让复杂任务的关键边界更清楚：

- 判断归属清楚。
    
- 问题范围清楚。
    
- 规则状态清楚。
    
- 副作用路径清楚。
    
- 验证证据清楚。
    
- 完成边界清楚。
    
- 质量侵蚀趋势清楚。
    
- 工作流状态清楚。
    
- 授权责任清楚。
    
- 数据血缘清楚。
    
- 候选到正式的晋升过程清楚。
    

当一个 skill 不能减少真实风险、澄清真实边界或改善可复用执行质量时，不应触发它。