# 贡献指南

本仓库是个人通用 agent skill 集。提交前请先阅读本文件的准入条件与同步流程。

## 准入条件（新增或修改 skill）

一个新 skill 必须满足全部条件：

1. **触发条件明确而窄**：能区分"该触发"与"不该触发"，不把低风险任务拖进重流程。
2. **解决重复出现的问题**：不是一次性经验或单次观察的制度化。
3. **提供实际可执行的方法**：不是换一种措辞重复 AGENTS.md 的既有规则。
4. **不独占任何 always-applicable 的 gate**：授权、scope、证据、完成验证等全局门槛永远在部署的 AGENTS.md；skill 只能实现其流程。
5. **不复制 fact owner 的环境事实**：主机、路径、代理、版本、部署位置等 volatile / machine-specific 事实在权威 fact owner，不进 skill 正文。
6. **与已有 skill 边界清晰**：重叠时优先扩展或收窄已有 skill，不堆叠新 skill。
7. **配套运行时 metadata**：`agents/openai.yaml` 与 `SKILL.md` 的 name/description 一致；catalog description 只识别适用场景，不教做法。
8. **修改后一致性检查**：更新 README 的 skill 表；检查 catalog、安装副本与 identifier 一致性。

## 目录形态

```text
<skill-name>/
├── SKILL.md
└── agents/
    └── openai.yaml
```

`SKILL.md` 保持简短；存在可复用细节时放入 `references/`，避免正文膨胀。

## 同步安装副本

以本仓库作为安装源时，修改后同步到当前 agent 运行时的 skills 安装目录（`~/.codex/skills/`），并检查安装副本与源文件一致（哈希比对）。部署的全局 AGENTS.md 单独维护（chezmoi 管理），不复制进本仓库。

## 提交约定

- 小步提交，提交信息说明改动内容（仓库历史为短句风格，如 `Narrow governance skill triggers`）。
- 不提交密钥、PII 或业务敏感样本；示例一律使用占位符。
- 合入前运行 `.github/scripts/validate_structure.py` 本地核对结构；CI 在 push 到 main 与 PR 时运行结构校验与本地链接检查。
