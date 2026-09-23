---
name: pwsh-execution
description: Use only when a Windows shell action needs materially non-trivial PowerShell handling such as quoting boundaries, multiline scripts, native exit-code semantics, encoding across environments, nested shells, or SSH. Do not trigger merely because the task uses PowerShell, Git, or another native executable.
---

# PowerShell Execution

PowerShell is the shell on Windows. Use this skill only when shell semantics themselves create a material execution risk for the pending action; ordinary single-command invocations do not require it.

## Method

**Quoting boundaries.** Pass literal `$...` text through single-quoted strings. Delimit a variable before a literal colon as `${name}:`. Keep PowerShell, SSH, and nested-shell quoting boundaries explicit when they are actually present.

**Multiline logic.** Prefer a here-string or script file when multiline or cross-shell logic would otherwise require fragile nested quoting. Do not pipe CRLF-sensitive content into a remote shell. Use UTF-8 explicitly when text crosses Windows and Linux boundaries.

**Native exit codes.** When a consequential next step depends on a native command, use `$LASTEXITCODE` or the relevant result to distinguish success from expected or unexpected nonzero outcomes.

**Structured error handling.** Treat expected failures as data and keep unexpected failure visible. Do not silently convert failure into success.

**Remote SSH from Windows.** Use the environment-owned wrapper when one is required. If remote logic contains material quoting, redirection, or multiline semantics, prefer a remote script over deeply nested inline shell syntax.

## Success signal

The material shell boundary was handled explicitly enough that quoting, encoding, exit status, or remote-shell semantics cannot silently change the intended operation.
