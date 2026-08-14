# 贡献指南

本仓库是个人运营判断 skill 集，维护遵循 `README.md` 的“质量门槛”与“维护规则”。提交前请先阅读 `README.md` 全文。

## 新增或修改 skill

1. 按 `README.md` 的质量门槛逐条核对：边界是否反复造成真实风险、触发条件是否足够具体、正文是否提供可执行检查、是否与更高优先级 skill 重复、是否有配套 `agents/openai.yaml`。
2. 使用标准目录形态：

   ```text
   <skill-name>/
   ├── SKILL.md
   └── agents/
       └── openai.yaml
   ```

3. `SKILL.md` 保持简短；存在可复用细节时放入 `references/`，避免正文膨胀。
4. 重复覆盖优先删除或收窄，不继续堆叠；被外部 skill 取代的本地 skill 应删除并更新 `README.md`。
5. 更新 `README.md` 中的 skill 表格（覆盖范围、触发场景、边界）。

## 同步安装副本

以本仓库作为安装源时，修改后同步到当前 agent 运行时的 skills 安装目录，并检查 `git status` 确认安装副本与源文件一致。部署的全局 AGENTS.md 单独维护，不复制进本仓库。

## 提交约定

- 小步提交，提交信息说明改动内容（仓库历史为短句风格，如 `Narrow governance skill triggers`）。
- 不提交密钥、PII 或业务敏感样本；示例一律使用占位符。
- 本仓库不配置 CI；合入前自行核对 `README.md` 质量门槛与目录结构完整性。
