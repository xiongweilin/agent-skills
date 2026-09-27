---
name: pwsh-execution
description: 仅当 Windows shell 操作存在实质非平凡的 PowerShell 处理要求时使用，例如 quoting 边界、多行脚本、native exit-code 语义、跨环境 encoding、嵌套 shell 或 SSH。不要仅因为任务使用 PowerShell、Git 或其他 native executable 就触发。
---

# PowerShell 执行

Windows 上使用 PowerShell。只有当 shell 语义本身会给待执行操作带来实质风险时才使用本 skill；普通单命令调用不需要。

## 方法

**Quoting 边界。** 需要传递字面量 `$...` 文本时使用单引号字符串。变量后紧跟字面量冒号时写成 `${name}:`。只有确实存在 PowerShell、SSH 和嵌套 shell 边界时，才明确处理这些 quoting 层。

**多行逻辑。** 当多行或跨 shell 逻辑否则需要脆弱的嵌套 quoting 时，优先使用 here-string 或脚本文件。不要把 CRLF 敏感内容通过 pipe 送入远端 shell。文本跨 Windows/Linux 边界时明确使用 UTF-8。

**Native exit code。** 如果有后果的下一步依赖 native command 结果，使用 `$LASTEXITCODE` 或相应结果区分成功、预期非零和异常非零。

**结构化错误处理。** 把预期失败视为数据，并让非预期失败保持可见。不要静默把失败转换成成功。

**Windows 上的远端 SSH。** 环境要求 wrapper 时使用环境 owner 提供的 wrapper。远端逻辑包含重要 quoting、redirection 或多行语义时，优先使用远端脚本，而不是深层嵌套 inline shell。

## 成功信号

关键 shell 边界已被明确处理，使 quoting、encoding、exit status 或远端 shell 语义不会静默改变预期操作。
