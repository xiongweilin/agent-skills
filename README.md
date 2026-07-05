# Operational Judgment Skills

这是一组面向 agent、自动化、业务流程和工程交付的判断型 skills。它们不试图覆盖所有编码任务；它们只处理容易被聪明模型、流程工具或局部工程视角低估的边界：授权、责任、数据血缘、规则状态、外部副作用、候选晋升、渐进侵蚀，以及用户判断归属。

## Priority in the local skill stack

这些 skill 的优先级低于 Codex 自带 skill、已安装插件 skill，以及外部高优先级 skill 仓库（Superpowers、Anthropic、Matt Pocock、Addy Osmani、Vercel、Karpathy）。如果本仓库 skill 与更高优先级来源功能重复，应删除、合并或收窄本仓库 skill，而不是保留重复触发面。

当前保留的 8 个 skill 是因为它们主要覆盖 operational judgment：它们与代码实现、测试、文档写作、浏览器控制、文件处理和通用项目规划类 skill 互补，而不是替代它们。

## Current skills

| Skill | Covers | Use when | Boundary |
| --- | --- | --- | --- |
| `authorization-map` | 授权、批准、否决、责任、补偿、受影响方 | 模型、规则、人、系统或组织共同执行会影响资源、记录、客户、政策或公开沟通的行动 | 不替代普通 code review；只在行动权限和后果归属重要时触发 |
| `data-contract-and-lineage` | 字段契约、来源、状态、版本、证据、使用限制 | 抽取、分类、BI、评估、审计、CRM/ERP 同步、SOP/catalog enrichment 等数据流 | 不替代文档/表格处理；关注数据从输入到输出声明的可追踪性 |
| `incremental-erosion` | 多个小例外造成的边界和质量门槛退化 | 同类跳测、弱断言、降低阈值、临时绕过、特殊分支反复出现 | 不处理单次孤立权衡；必须有趋势或复发信号 |
| `judgment-ownership` | 用户判断框架、证据缝隙、剩余决策点 | 战略、架构、定位、命名、品味、路线、优先级等判断重的任务 | 不用于低风险格式化、直接实现或事实查找 |
| `rollout-and-promotion` | 候选到正式行为的晋升、冻结、评分、弃用、公开声明 | prompt、规则、阈值、数据集、模型、workflow、评估结果准备变成官方行为 | 不替代 CI/CD 或发布工具；关注“能否声称官方支持” |
| `rule-state-hygiene` | candidate / official / deprecated 规则分离 | 业务规则、配置、mock、fixture、README、迁移说明、临时 workaround 可能被误认为正式规则 | 不用于纯重命名、格式化或行为不变的清理 |
| `side-effect-safety` | 不可逆副作用、幂等、补偿、回滚、显式失败 | 写数据库、发邮件/短信、删除/迁移、外部 API 写入、队列发布、基础设施变更 | 不替代安全审计；它保护执行副作用本身 |
| `workflow-decomposition` | 业务/agent workflow 的输入、状态机、人工节点、守卫、副作用、异常、证据、指标 | RPA、ERP/CRM/BI、审批、客服、catalog、agentic operations、运营自动化 | 不替代普通函数设计；只在 durable state 或跨系统流程存在时触发 |

## How to combine them

### Business or agent workflow

1. Use `workflow-decomposition` to identify states, transitions, human nodes, automated nodes, deterministic guards, external effects, exception paths, records, and metrics.
2. Use `authorization-map` to decide who proposes, validates, approves, executes, vetoes, compensates, and owns accountability.
3. Use `data-contract-and-lineage` when the workflow transforms fields, labels, evidence, reports, scores, prompts, or generated outputs.
4. Use `side-effect-safety` before any irreversible write, publish, send, delete, migration, or external API mutation.
5. Use `rollout-and-promotion` if the workflow, prompt, rule, threshold, or model behavior may become official or publicly claimed.

### Rule, policy, fixture, prompt, or documentation change

1. Use `judgment-ownership` if the change carries strategy, taste, architecture, positioning, or prioritization.
2. Use `rule-state-hygiene` to label the material as candidate, official, or deprecated.
3. Use `data-contract-and-lineage` if claims depend on evidence, datasets, prompts, thresholds, offsets, or versioned artifacts.
4. Use `rollout-and-promotion` before saying the behavior is supported, promoted, production-ready, or official.

### Repeated small exceptions

1. Use `incremental-erosion` when the same workaround, weakened assertion, skipped check, special case, lowered threshold, or “fix later” pattern recurs.
2. Use `rule-state-hygiene` to keep the workaround from becoming an implicit official rule.
3. Use `rollout-and-promotion` if lowered gates affect quality claims.

## Replacement history

The following skills were removed because higher-priority installed skills now cover their primary behavior:

- `problem-framing` → covered by Superpowers `writing-plans`, Addy `spec-driven-development` / `idea-refine` style coverage, Matt `codebase-design`, and existing planning/design skills.
- `verification-skepticism` → covered by Superpowers `verification-before-completion` and Addy `doubt-driven-development`.
- `scope-honesty-and-stopping` → covered by Superpowers `verification-before-completion` plus Addy `doubt-driven-development`; completion reporting is now handled by higher-priority verification skills and assistant-level final-status discipline.

## Quality bar

A skill should stay in this repository only if it meets all of these conditions:

- It protects a boundary that repeatedly causes real risk, rework, false claims, bad writes, bad authorization, or confused responsibility.
- Its trigger is specific enough that low-risk tasks are not dragged into a heavy process.
- Its body gives executable checks, not abstract virtues.
- Its boundary against Codex built-in, plugin, and external high-priority skills is clear.
- It does not duplicate a higher-priority skill unless it has a narrower operational angle that the other skill does not cover.
- It has `agents/openai.yaml` metadata that matches `SKILL.md`.

## Maintenance rules

- Prefer deletion or narrowing over duplicate coverage.
- If a new external skill supersedes one here, remove the local skill and update this README.
- If a skill is retained despite overlap, document the boundary in this README and in the skill description.
- Keep `SKILL.md` concise. Move long reference material into `references/` only when there is real reusable detail.
- Keep generated metadata synchronized with the installed copy under `~/.codex/skills` when this repository is used as the source of installed skills.
- After changing skills, verify that the repository is clean and that installed copies match the source files intended for active use.

## Directory shape

Each skill uses the standard Codex skill folder shape:

~~~text
<skill-name>/
├── SKILL.md
└── agents/
    └── openai.yaml
~~~

The repository README is intentionally not part of any skill trigger. It explains how this small operational judgment layer fits into the larger local skill stack.
