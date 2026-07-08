# AGENTS.md — Codex Always-Loaded Execution Rules

This document is read by Codex at the start of every session. It defines
environment conventions, behavioral discipline, mandatory pre-action gates,
and self-improvement protocols. It is the runtime copy; the source of truth
lives in the Obsidian vault (智能体前置运行守则).

Skills handle conditional domain expertise. This document handles what must
always be active.

---

## 1. Shell & Execution Entry

- Windows commands: default to `pwsh -NoProfile -NonInteractive`. Third-party
  installers or vendor tools that internally invoke other shells are not
  considered an active choice.
- WSL2 entry: `wsl -d Ubuntu-22.04 -u ratio`.
- Cloud server entry: run `ssh metratio` from Windows; do not SSH from within
  WSL2.
- Before any persistent addition (container, cron job, scheduled task, alert
  rule, dashboard panel, Python/Node dependency): execute the scope-safety
  checklist (4 capacity + 4 warrant items) and write results to commentary or
  final. Any failing item must downgrade to candidate, add evidence, set a
  rollback/retirement condition, or stop execution.
- Before installing a CLI tool: check `scoop list` first. Reuse existing tools.
- Python projects: prefer `uv`. When `pyproject.toml` / `uv.lock` exist, use
  `uv sync` then `uv run ...`. Never use global `pip install` to fix project
  dependencies.
- When using `uv sync` on an existing project, check
  `[project.optional-dependencies]` first. Do not use only `--extra dev` which
  drops unlisted extras. Use `--all-extras` or explicitly include existing extras
  to preserve full capability.
- When the system `python.exe` is a WindowsApps shim or unavailable, prefer
  project-level `uv run python`. Only fall back to the Codex bundled runtime
  Python when no project context exists.
- After installing Scoop Python on Windows, verify with
  `Get-Command python -All` that `python` does not still resolve to WindowsApps.
  If Scoop only created a `python3` shim, run
  `scoop shim add python "$HOME\scoop\apps\python\current\python.exe"`.
- Inside WSL, do not implicitly depend on Windows-side Node/npm/Python/Codex
  tools under `/mnt/c/...`. Use WSL-native tools for Linux semantics; invoke
  Windows tools only when explicitly operating on the Windows side.
- When running a bare script in WSL (`bash script.sh`), the login shell's user
  PATH is not loaded automatically. Either add
  `export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"` at the top of the
  script, or invoke commands that need the user PATH via `bash -lc`.

## 2. Command Construction Rules

- Codex tool calls may pass through an outer PowerShell parsing layer. Avoid
  constructions that risk double-expansion of variables.
- Complex inline scripts: prefer writing a here-string into `$script`, then
  `pwsh -NoProfile -NonInteractive -Command $script`.
- Do not embed PowerShell backtick escapes inside JS template strings. Use
  plain blank lines, string array `join()`, here-strings, or script files
  instead.
- PowerShell does not support bash `<<EOF`. To pass multi-line text to Python
  or another interpreter, pipe a PowerShell here-string.
- PowerShell here-strings piped to WSL/bash may retain CRLF (`\r`), corrupting
  bash arguments. Do not pipe newline-sensitive bash scripts to `bash -s`;
  prefer `bash -lc` arguments or write an LF temporary script and execute it
  inside WSL.
- When text must contain a literal `$skill-name`, use PowerShell single-quoted
  strings. Double-quoted strings expand `$variable` and may silently corrupt
  content.
- When generating `pwsh -EncodedCommand`, encode as UTF-16LE then Base64.
- Before any command that emits download/extraction progress, set
  `$ProgressPreference = 'SilentlyContinue'` to suppress CLIXML/progress noise.
- When Python or localized Windows commands may encounter non-UTF-8 text, set
  `$env:PYTHONUTF8 = '1'` or explicitly set console encoding.
- For one-shot Python tools, prefer `uvx <tool>` or `uv run <module>`. Use a
  temporary interpreter path only when the tool has no uv entry point and is
  confirmed not to pollute the project environment.

## 3. PowerShell Behavior Traps

- `Select-String -LiteralPath` does not expand wildcards. Use `-Path` for
  wildcards, `-LiteralPath` for exact paths.
- Regex metacharacters such as `[` must be escaped in `Select-String` patterns.
- PowerShell variable names are case-insensitive. Avoid `$pid`; use explicit
  names like `$targetPid`, `$servicePid`.
- `if (...) { ... } else { ... } | ConvertTo-Json` cannot be used as an
  expression. Assign the result to a variable first, then place it in an object
  or pipeline. Likewise, assign conditional values to a variable before
  creating a `[PSCustomObject]`.
- `foreach (...) { ... } | Format-Table` has pipeline-shape issues. Collect
  first: `$rows = foreach (...) { ... }; $rows | Format-Table`.
- When calling Windows API functions, `0x80000000` may need an explicit cast:
  `[uint32]0x80000000`.
- Probing protected system directories: even `Test-Path` can emit access-denied
  noise. Narrow the probe scope first, and add `-ErrorAction SilentlyContinue`
  when necessary.

## 4. File Editing Rules

- Prefer `apply_patch` for local file edits. Do not use `cat`, redirection, or
  temporary scripts to write files when a patch suffices.
- `apply_patch` Add File content must use standard diff added lines, each
  prefixed with `+`.
- `apply_patch` Update File hunks: context lines begin with a space, added
  lines with `+`, removed lines with `-`.
- When deleting a Markdown list item via `apply_patch`, the list marker `-`
  must be kept in the removal. Deleting `- foo` is written as `-- foo`;
  context `- foo` is written as ` - foo`.
- When constructing patches in JS, every line must be a string. Avoid
  accidental unary `+` expressions.
- When patch content contains Markdown backticks or literal `$`, avoid JS
  template strings; prefer plain string arrays or another safe representation.
- In the current Codex JS `exec` environment, `tools.shell_command` returns
  rendered command output. Do not assume it returns an object with
  `{ stdout, stderr }` unless the current tool description explicitly documents
  that shape.

## 5. Search, Download & Diagnosis

- Prefer `rg` / `rg --files` for text and file search. Constrain directories,
  extensions, and exclusion rules to avoid scanning large logs or binaries.
- For external facts, prefer official pages, source repositories, docs, or
  forum originals over search-summary snippets alone.
- GitHub zip downloads may fail with `RemoteDisconnected`. Retry with the git
  method (`--method git`) before changing the install approach.
- When using Codex skill install scripts, pass multiple skill paths as a single
  `--path` argument with all paths. Repeating `--path` multiple times may only
  install the last one.
- On Windows, when using `skill-creator`'s `generate_openai_yaml.py`, pass
  `--name <skill-name>` explicitly and enable UTF-8; otherwise it may fail due
  to missing `yaml` or default code-page read errors.
- A vendor skill's frontmatter `name` may differ from its directory name.
  Confirm the actual installed name by reading `SKILL.md`, not by directory
  name alone.

## 6. Windows Service & Process Diagnostics

- Start services through the SCM: `Start-Service <ServiceName>` or
  `sc.exe start <ServiceName>`. Running the service EXE directly is not an
  equivalent verification.
- For short-lived processes, do not rely on a single process snapshot. Combine
  PID changes, service state, registry, event logs, and application logs.
- `procdump -ma -e 1 -w` suits crash-type failures. For normal exits or
  short-lived processes, consider termination dumps, ProcMon, ETW, event logs,
  or application-level probes instead.
- Manual execution and service execution run under different privilege contexts.
  Only attribute access-denied to a service permission problem when logs or
  probes confirm elevated/SYSTEM context.
- ProcMon PML/CSV exports can be large and may briefly show 0 bytes. Check the
  export process and log state before concluding failure.
- When a pre-filtered ProcMon CSV already exists, reuse the analysis. Do not
  re-capture wide-scope logs unnecessarily.
- Avoid high-frequency polling of `Get-NetTCPConnection`; it can skew sampling.
  Prefer lightweight process, registry, and state probes; snapshot network
  connections at low frequency separately.

## 7. Tool Integration & Verification

- **SonarQube Codex MCP**: `sonar integrate codex --global --non-interactive`
  may silently fail (output `operation timed out` without writing config).
  After integration, verify `~/.codex/config.toml` contains
  `[mcp_servers.sonarqube]`. If missing, manually add:

      [mcp_servers.sonarqube]
      command = 'C:\\Users\\metra\\AppData\\Local\\sonarqube-cli\\bin\\sonar.exe'
      args = ["run", "mcp"]

  Restart Codex after adding the block for MCP tools to load.

- **sonar-scanner (Windows projects)**: requires Java
  (`scoop install temurin21-jdk`). Set `$env:JAVA_HOME` before running.

- **sonar-scanner (WSL projects)**: do not use the Windows scanner to scan
  `\\wsl.localhost\...` UNC paths; Java file locks in
  `.scannerwork/.sonar_lock` may fail. WSL already has
  `openjdk-17-jre-headless`; no additional Java needed. Inside the WSL project
  directory, run the scanner directly and pass `SONAR_TOKEN` as a temporary
  environment variable.

- **SonarQube MCP container cleanup**: after using SonarQube MCP tools, exited
  `sonarsource/sonarqube-mcp` containers may remain. Run:
  `docker ps -a --filter "ancestor=sonarsource/sonarqube-mcp" --filter "status=exited" --format '{{.ID}}' | xargs -r docker rm`
  to prevent resource leaks.

## 8. Behavioral Discipline

Derived from Andrej Karpathy's observations on LLM coding pitfalls. These
guidelines bias toward caution over speed. For trivial tasks, use judgment.

### 8.1 Think Before Coding

Do not assume. Do not hide confusion. Surface tradeoffs.

- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them — do not pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what is confusing. Ask.

### 8.2 Simplicity First

Minimum code that solves the problem. Nothing speculative.

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that was not requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Test: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

### 8.3 Surgical Changes

Touch only what you must. Clean up only your own mess.

- Do not "improve" adjacent code, comments, or formatting.
- Do not refactor things that are not broken.
- Match existing style, even if you would do it differently.
- If you notice unrelated dead code, mention it — do not delete it.
- Remove only imports/variables/functions that your changes made unused.
- Every changed line should trace directly to the user's request.

### 8.4 Goal-Driven Execution

Define success criteria. Loop until verified.

- Transform tasks into verifiable goals: "Add validation" becomes "Write tests
  for invalid inputs, then make them pass."
- For multi-step tasks, state a brief plan with verification at each step.
- Strong success criteria enable independent iteration. Weak criteria ("make it
  work") require constant clarification.

## 9. Mandatory Pre-Action Gates

These gates fire unconditionally, regardless of which skills are active:

- **scope-safety trigger**: before any persistent addition (container, cron,
  scheduled task, alert rule, dashboard panel, dependency, configuration,
  metric definition, or factual claim derived from observed data), run the
  scope-safety checklist. Capacity: what resource does this consume, what does
  it displace, what is the retirement condition, what is the blast radius.
  Warrant: is the evidence measured or inferred, has the metric been validated,
  is the claim marked candidate or official. Any failing item must be
  downgraded to candidate, supplemented with evidence, given a rollback or
  retirement condition, or blocked.

- **command-permission-boundary trigger**: before any shell command that
  deletes, installs, modifies lockfiles, accesses secrets, changes git history,
  connects to external networks, or starts/stops services, classify the command
  as read-only, reversible, or irreversible. Irreversible commands require
  explicit user approval. Accessing secrets or .env files is never read-only
  and always requires approval.

## 10. Self-Improvement Protocols

### 10.1 Snag Update Protocol

When a snag causes command failure, repeated runs, wrong file edits,
quote/encoding surprises, wrong install assumptions, or minutes of avoidable
uncertainty:

1. Complete enough diagnosis to confirm a reusable rule.
2. Before continuing the main task, update the most relevant section of this
   document. If a new rule replaces an old one, replace directly — do not append
   contradictory text.
3. Do not record one-off noise unlikely to recur.
4. Once a rule is absorbed into a main section, remove the corresponding entry
   from Section 10.2. The main sections are the single source of truth.

New entries use this compact format:

    YYYY-MM-DD — Symptom: <what failed or got stuck>.
      Rule: <stable approach for next time>.
      Safer form: <minimal command or structure if applicable>.

### 10.2 Recent Snags (Pending Absorption)

(Entries already absorbed into main sections are not repeated here. Only
one-off records not yet promoted to main sections remain.)

Currently no pending entries.

### 10.3 Skill Creation Protocol

After completing a task, self-evaluate. If any of the following hold, propose
at the end of the final answer: "Should this workflow be captured as a skill?":

- The task involved 20 or more tool calls.
- The task followed a complete "trial → root cause → fix" diagnostic chain.
- The task involved a new tool combination or cross-system coordination
  (Windows/WSL/SSH).
- Key steps in the task had no existing skill or rule coverage.

If the user confirms, use the `skill-creator` skill and record key knowledge in
the relevant section of this document.

### 10.4 Session Archive Protocol

When a session produces knowledge of the following types, propose archiving at
the end of the final answer:

- New environment configuration rules → update this document.
- Architecture decisions → write to project `docs/adr/`, link back to Obsidian
  vault: 个人平台总览.
- Reproducible problems and solutions → append to Section 10.2 above.
- Capability boundary changes → update Obsidian: RUNBOOK/环境运维手册.
- Environment state changes → update Obsidian: RUNBOOK/环境运维手册.

Archive in Obsidian wikilink format so new knowledge remains searchable.

### 10.5 Knowledge Retrieval Protocol

At the start of every task:

- Confirm the current environment closed-loop state (see Obsidian: 个人平台总览).
- If the task touches a domain marked by other Obsidian documents, search the
  vault for relevant notes before acting.
- If search results include documents last updated more than 30 days ago and
  the content is relevant to the current task, proactively ask: "This document
  may be outdated — verify first?"

The goal: retrieve existing knowledge before acting, rather than exploring from
scratch every time.

## 11. Pre-Completion Verification

Before claiming any task is complete:

1. Identify: what command proves the claim?
2. Run: execute the full command (fresh, complete).
3. Read: full output, check exit code, count failures.
4. Verify: does the output confirm the claim? If no, state actual status with
   evidence. If yes, state the claim with evidence.
5. Only then: make the claim.

No completion claims without fresh verification evidence. "Should work,"
"probably," and "seems to" are not verification.

Before reporting completion, check real file state; if a repository was
modified, check git status; if skills were synced, check the installed copy
state; if skills were added or removed, state whether a Codex restart is needed
for discovery.
