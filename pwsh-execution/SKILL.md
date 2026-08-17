---
name: pwsh-execution
description: Execute robust PowerShell workflows on Windows. Use when shell work needs quoting boundaries, multiline scripts, native exit-code handling, encoding discipline, or remote SSH calls from Windows. Do not use for pure file reads or read-only searches.
---

# PowerShell Execution

PowerShell is the agent's shell on Windows. Most failures here are quoting and state-boundary failures, not missing commands. This skill carries the executable method; the always-loaded invariants (check exit status before a consequential step, do not repeat an unchanged failed call) live in AGENTS.md.

## Use when

Use for shell work that involves command construction, multi-line logic, native executables, encoding across Windows/Linux boundaries, or SSH from Windows.

## Method

**Quoting boundaries.** Pass literal `$...` text through single-quoted strings. Delimit a variable before a literal colon as `${name}:`. Keep PowerShell, SSH, and nested-shell quoting boundaries explicit; verify the resolved command before running it.

**Multiline logic → script file.** Prefer a here-string or a script file for cross-shell or multi-line scripts. Do not pipe CRLF-sensitive content into a remote shell. Use UTF-8 explicitly when text crosses Windows and Linux boundaries. Multi-line logic inside remote commands goes into a script file first; do not nest shell quoting inside inline commands.

**Native exit codes.** Capture the native command exit status and check it before a consequential next step. Treat expected no-match and nonzero native-command results explicitly (`$LASTEXITCODE`). A missing check turns a silent failure into a wrong next step.

**Structured error handling.** Treat expected failures as data: check for them, branch on them, and leave failure visible. Do not silently record failure as success.

**Remote SSH from Windows.** Invoke the fixed wrapper entry from the environment fact owner. Remote commands are interpreted by the remote login shell (Linux): logic containing spaces, redirection, or quoting must not be packed into an argument array — write a remote script and invoke the script path instead. Declare expected non-zero exit codes explicitly.

## Success signal

A command was constructed with explicit quoting and encoding boundaries, its exit status was checked before the consequential next step, and any failure stayed visible.
