# 运营判断技能集

本仓库保存一组面向智能体、自动化、业务流程和工程交付的判断型 skills。它们不覆盖所有编码任务，只处理容易被模型、流程工具或局部工程视角低估的边界：授权、责任、数据血缘、规则状态、外部副作用、候选晋升、渐进侵蚀，以及用户判断归属。`context-sufficiency` 补充修改前的信息门禁，`privacy-and-sensitive-data-boundary` 统一隐私边界，`skill-orchestrator` 只路由需要多项治理判断的复杂任务。

始终适用的任务范围、命令权限和完成验证由独立维护的 `~/.codex/AGENTS.md` 负责，不在本仓库重复。`scope-safety` 只在新增持久能力、依赖或长期声明时检查承载、供应链、证据和退役条件。

## 当前 skill

| Skill                            | 覆盖范围                                           | 触发场景                                                      | 边界                                                         |
| -------------------------------- | ---------------------------------------------- | --------------------------------------------------------- | ---------------------------------------------------------- |
| `scope-safety`                   | 持久新增的承载、供应链、证据与退役条件                            | 新增服务、依赖、自动化、规则、指标、配置，或形成会长期引用的事实声明时                         | 不用于普通本地修改；AGENTS 已负责通用范围和命令门禁                              |
| `context-sufficiency`            | 代码上下文充分性                                       | 修改代码前，检查是否已读取调用方、测试、配置、schema、迁移和环境                       | 不替代 code review；只在信息不完整可能误导修改时触发                           |
| `authorization-map`              | 授权、批准、否决、责任、补偿、受影响方                            | 模型、规则、人、系统或组织共同执行会影响资源、记录、客户、政策或公开沟通的行动                   | 不替代普通 code review；只在行动权限和后果归属重要时触发                         |
| `data-contract-and-lineage`      | 字段契约、来源、状态、版本、证据、使用限制                          | 抽取、分类、BI、评估、审计、CRM/ERP 同步、SOP、catalog enrichment 等数据流     | 不替代接口设计；公共兼容性问题转交 `api-and-interface-design`              |
| `incremental-erosion`            | 多个小例外造成的边界和质量门槛退化                              | 同类跳测、弱断言、降低阈值、临时绕过、特殊分支反复出现                               | 不处理单次孤立权衡；必须有趋势或复发信号                                       |
| `judgment-ownership`             | 用户判断框架、证据缝隙、剩余决策点                              | 战略、架构、定位、命名、品味、路线、优先级等判断重的任务                              | 不用于低风险格式化、直接实现或事实查找                                        |
| `rollout-and-promotion`          | 候选到正式行为的晋升、冻结、评分、弃用、公开声明                       | prompt、规则、阈值、数据集、模型、workflow、评估结果准备变成官方行为                 | 不替代 CI/CD 或发布工具；关注“能否声称官方支持”                               |
| `rule-state-hygiene`             | candidate / official / deprecated 规则分离         | 业务规则、配置、mock、fixture、README、迁移说明、临时 workaround 可能被误认为正式规则 | 不用于纯重命名、格式化或行为不变的清理                                        |
| `side-effect-safety`             | 不可逆副作用、幂等、补偿、回滚、显式失败                           | 写数据库、发邮件/短信、删除/迁移、外部 API 写入、队列发布、基础设施变更                   | 不替代安全审计；它保护执行副作用本身                                         |
| `workflow-decomposition`         | 业务/agent workflow 的输入、状态机、人工节点、守卫、副作用、异常、证据、指标 | RPA、ERP/CRM/BI、审批、客服、catalog、agentic operations、运营自动化     | 不替代普通函数设计；只在 durable state 或跨系统流程存在时触发                     |
| `privacy-and-sensitive-data-boundary` | PII、日志脱敏、截图隐私、第三方 API 外发、训练数据隔离、最小必要访问、保留期限 | 用户数据、反馈文本、CSV 导入、外部 API 调用、截图、错误报告等场景 | 不替代 AGENTS 的凭证访问门禁；扩展到完整敏感数据分类与流转边界 |
| `skill-orchestrator`             | 复杂任务的最小治理链路选择                                  | 跨系统流程、授权责任、敏感数据、正式规则晋升或重复例外同时涉及多个边界时                     | 普通代码修改由 AGENTS 和开发类 skills 处理，不触发治理全家桶                       |

## 组合方式

### 编码任务的上下文门禁

修改代码前，在缺失调用方、测试、配置、schema、迁移或运行边界可能改变设计时，使用 `context-sufficiency`。命令权限和完成验证直接遵循 AGENTS。

### 全局路由

当任务确实涉及多个治理边界时，使用 `skill-orchestrator` 选择最小路径。普通代码、格式化、只读分析和单一领域任务不经过该路由；持久新增或长期声明才额外使用 `scope-safety`。

### 隐私 / 敏感数据

当任务涉及用户数据、PII、外部 API 调用或截图时，使用 `privacy-and-sensitive-data-boundary`。
该 skill 可与任何其他路径并行运行。

### 持久新增与长期声明

新增会跨任务存在的服务、依赖、自动化、规则、指标、配置或事实声明时，使用 `scope-safety`：

1. 拟新增的是否是持久物（服务、依赖、自动化、规则、配置、指标、声明）？
2. 系统能否承受这次扩张？（参考容量指标、维护负担、故障域边界）
3. 这个结论是候选还是正式？（证据来源、指标是否已验证、谁承担后果）

低风险、可逆且不持久的普通修改不触发该 skill。

### 外部闭环能力

以下能力来自更高优先级的已安装第三方 skills，不复制进本仓库：

- `verification-before-completion`：完成前证据门禁；本地增量原则进入 AGENTS。
- `api-and-interface-design`：公共接口兼容性与弃用。
- `observability-and-instrumentation`：生产运行证据。
- `security-best-practices` / `security-threat-model`：安全编码与威胁建模。
- `documentation-and-adrs` / `review`：决策记录与变更审查。

### 业务流程或智能体流程

1. 使用 `workflow-decomposition` 拆出状态、流转、人工节点、自动节点、确定性守卫、外部副作用、异常路径、记录和指标。
2. 使用 `authorization-map` 明确谁提出、谁验证、谁批准、谁执行、谁否决、谁补偿、谁承担问责。
3. 如果流程会转换字段、标签、证据、报表、评分、prompt 或生成输出，使用 `data-contract-and-lineage`。
4. 在任何不可逆写入、发布、发送、删除、迁移或外部 API 变更前，使用 `side-effect-safety`。
5. 如果 workflow、prompt、规则、阈值或模型行为可能变成正式能力或对外声明，使用 `rollout-and-promotion`。

### 规则、政策、fixture、prompt 或文档变更

1. 如果变更承载战略、品味、架构、定位或优先级判断，使用 `judgment-ownership`。
2. 使用 `rule-state-hygiene` 标记材料属于 candidate、official 还是 deprecated。
3. 如果声明依赖证据、数据集、prompt、阈值、offset 或版本化产物，使用 `data-contract-and-lineage`。
4. 在声称某行为已支持、已晋升、可生产使用或正式可用之前，使用 `rollout-and-promotion`。

### 重复的小例外

1. 当同类 workaround、弱断言、跳过检查、特殊分支、降低阈值或“之后修”反复出现时，使用 `incremental-erosion`。
2. 使用 `rule-state-hygiene`，避免 workaround 被默默当成 official rule。
3. 如果降低门槛会影响质量声明，使用 `rollout-and-promotion`。

## 质量门槛

一个 skill 只有同时满足以下条件，才应保留在本仓库：

- 它保护的边界会反复造成真实风险、返工、错误声明、错误写入、错误授权或责任混淆。
- 它的触发条件足够具体，不会把低风险任务拖进重流程。
- 它的正文提供可执行检查，而不是抽象价值观。
- 它与 Codex 自带、插件和外部高优先级 skill 的边界清楚。
- 它不重复更高优先级 skill；除非它有对方没有覆盖的更窄运营判断角度。
- 它有与 `SKILL.md` 匹配的 `agents/openai.yaml` 元数据。

## 维护规则

- 重复覆盖时，优先删除或收窄，而不是继续堆叠。
- 如果新的外部 skill 取代了本仓库某个 skill，应删除本地 skill，并更新本 README。
- 如果某个 skill 虽有重叠但仍需保留，必须在 README 和 skill description 中说明边界。
- `SKILL.md` 保持简短。只有真正存在可复用细节时，才把长资料放入 `references/`。
- 以本仓库作为安装源时，修改后要同步 `~/.codex/skills` 下的安装副本。
- 修改 skill 后，检查 git 状态，并确认安装副本与源文件一致。
- 第三方 skill 保持上游来源，不复制到本仓库；本地通用增量进入 AGENTS 或自有 skill。
- `~/.codex/AGENTS.md` 是单独维护、始终加载的运行时执行规则；本仓库不再保存其版本化副本。它不属于 skill，也不计入 skill 数量。

## 目录结构

每个 skill 使用标准 Codex skill 目录形态：

~~~text
<skill-name>/
├── SKILL.md
└── agents/
    └── openai.yaml
~~~

仓库 README 本身不是任何 skill 的触发内容。它只说明这组运营判断 skill 如何嵌入当前更大的本机 skill 体系。
