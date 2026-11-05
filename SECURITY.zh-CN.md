# 安全说明

本仓库保存一组面向智能体与流程的判断型 skill 指令，不包含运行时数据、凭据或业务敏感内容。

## 报告问题

优先使用 GitHub 的[私密漏洞报告渠道](https://github.com/xiongweilin/agent-skills/security/advisories)（如已启用），或通过维护者提供的其他私密渠道联系；不要在公开 issue 中透露密钥值、内部路径或可利用细节。

## 内容边界

- Skill 正文不得携带真实密钥、token、口令或 `.env` 值；涉及敏感操作时只给出流程与边界，不给出真实凭据。
- Skill 正文不应包含用户真实 PII 或业务敏感样本；示例一律使用占位符。
- 本仓库的 skill 本身是“边界指令”，不是授权来源：具体任务授权仍以部署的全局 AGENTS.md 与相关运行手册为准。
- 修改或新增 skill 涉及秘密、PII 或敏感数据时，应遵守 `agents-md/AGENTS.md` 的常驻授权与敏感数据边界，不假定仓库存在独立隐私 skill。
