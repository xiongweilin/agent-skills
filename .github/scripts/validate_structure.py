"""用标准库验证 agent-skills 的文件、运行时元数据和本地文档链接。"""

from __future__ import annotations

import json
import re
from pathlib import Path
from urllib.parse import unquote, urlsplit

ROOT = Path(__file__).resolve().parents[2]
TOP_LEVEL_FILES = {
    "README.md", "README.zh-CN.md", "CONTRIBUTING.md",
    "CONTRIBUTING.zh-CN.md", "SECURITY.md", "SECURITY.zh-CN.md",
    "LICENSE", "LICENSE.md", "CODE_OF_CONDUCT.md", "CODE_OF_CONDUCT.zh-CN.md",
    "CODE_OF_CONDUCT", ".editorconfig", ".gitignore", ".gitattributes",
}
NON_SKILL_DIRS = {"agents-md", "tests"}
REQUIRED_LANGUAGE_PAIRS = (
    ("README.md", "README.zh-CN.md"),
    ("CONTRIBUTING.md", "CONTRIBUTING.zh-CN.md"),
    ("SECURITY.md", "SECURITY.zh-CN.md"),
    ("CODE_OF_CONDUCT.md", "CODE_OF_CONDUCT.zh-CN.md"),
)
SKILL_NAME_PATTERN = re.compile(r"^[a-z0-9]+(?:-[a-z0-9]+)*$")
MARKDOWN_LINK = re.compile(r"(?<!!)\[[^\]]*\]\(<?([^\s)>]+)>?(?:\s+['\"][^)]*['\"])?\)")


def read_frontmatter(path: Path) -> dict[str, str]:
    """解析仓库当前采用的简单单行 YAML frontmatter。"""
    content = path.read_text(encoding="utf-8")
    match = re.match(r"\A---\r?\n(.*?)\r?\n---\r?\n", content, re.DOTALL)
    if not match:
        return {}
    fields: dict[str, str] = {}
    for line in match.group(1).splitlines():
        item = re.fullmatch(r"([A-Za-z0-9_-]+):\s*(.+)", line)
        if item:
            value = item.group(2).strip()
            if value.startswith('"'):
                try:
                    value = json.loads(value)
                except json.JSONDecodeError:
                    pass
            fields[item.group(1)] = value
    return fields


def read_agent_interface(path: Path) -> dict[str, str]:
    """只接受仓库约定的 interface 字符串字段，不依赖外部 YAML 库。"""
    lines = [line for line in path.read_text(encoding="utf-8").splitlines()
             if line.strip() and not line.lstrip().startswith("#")]
    if not lines or lines[0] != "interface:":
        return {}
    result: dict[str, str] = {}
    for line in lines[1:]:
        match = re.fullmatch(r"  ([a-z_]+):\s*(\"(?:[^\"\\]|\\.)*\")\s*", line)
        if not match or match.group(1) in result:
            return {}
        try:
            value = json.loads(match.group(2))
        except json.JSONDecodeError:
            return {}
        if not isinstance(value, str):
            return {}
        result[match.group(1)] = value
    return result


def check_skill_layout(skill_dir: Path, failures: list[str]) -> None:
    name = skill_dir.name
    skill_md = skill_dir / "SKILL.md"
    agent_yaml = skill_dir / "agents" / "openai.yaml"
    if not SKILL_NAME_PATTERN.fullmatch(name):
        failures.append(f"{name}: invalid skill directory name")
    if not skill_md.is_file():
        failures.append(f"{name}: missing SKILL.md")
    for extra in sorted(skill_dir.glob("SKILL.*")):
        if extra.name != "SKILL.md":
            failures.append(f"{name}: unexpected translated/alternate skill file {extra.name}")
    if not agent_yaml.is_file():
        failures.append(f"{name}: missing agents/openai.yaml")
    if not skill_md.is_file() or not agent_yaml.is_file():
        return
    fields = read_frontmatter(skill_md)
    if fields.get("name") != name:
        failures.append(f"{name}: SKILL.md frontmatter name must equal directory name")
    if not isinstance(fields.get("description"), str) or not fields["description"].strip():
        failures.append(f"{name}: SKILL.md requires a nonempty description")
    metadata = read_agent_interface(agent_yaml)
    for key in ("display_name", "short_description", "default_prompt"):
        if not metadata.get(key, "").strip():
            failures.append(f"{name}: missing or malformed interface.{key}")
    if metadata.get("default_prompt") and ("$" + name) not in metadata["default_prompt"]:
        failures.append(f"{name}: interface.default_prompt must explicitly invoke $" + name)


def read_catalog(path: Path) -> set[str]:
    names = set()
    for line in path.read_text(encoding="utf-8").splitlines():
        if not line.startswith("|"):
            continue
        first_cell = line.strip("|").split("|", 1)[0].strip()
        match = re.fullmatch(r"`([a-z0-9-]+)`", first_cell)
        if match:
            names.add(match.group(1))
    return names


def check_catalog(skill_names: set[str], failures: list[str]) -> None:
    for readme in ("README.md", "README.zh-CN.md"):
        path = ROOT / readme
        if not path.is_file():
            failures.append(f"{readme}: missing")
            continue
        listed = read_catalog(path)
        for name in sorted(skill_names - listed):
            failures.append(f"{readme}: missing skill {name}")
        for name in sorted(listed - skill_names):
            failures.append(f"{readme}: stale skill {name}")


def github_slugs(content: str) -> set[str]:
    """计算当前文档中 Markdown ATX 标题的 GitHub 风格锚点。"""
    slugs: set[str] = set()
    counters: dict[str, int] = {}
    in_fence = False
    for line in content.splitlines():
        if re.match(r"^\s*(```|~~~)", line):
            in_fence = not in_fence
            continue
        if in_fence:
            continue
        match = re.match(r"^\s{0,3}#{1,6}\s+(.+?)\s*#*\s*$", line)
        if not match:
            continue
        heading = re.sub(r"<[^>]+>", "", match.group(1))
        heading = re.sub(r"\[([^]]+)\]\([^)]+\)", r"\1", heading)
        heading = heading.replace("`", "").replace("*", "").replace("_", "")
        heading = re.sub(r"[^\w\- ]", "", heading.lower()).replace(" ", "-")
        number = counters.get(heading, 0)
        counters[heading] = number + 1
        slugs.add(f"{heading}-{number}" if number else heading)
    return slugs


def check_local_links(failures: list[str]) -> None:
    root_resolved = ROOT.resolve()
    for path in ROOT.rglob("*.md"):
        content = path.read_text(encoding="utf-8")
        for target in MARKDOWN_LINK.findall(content):
            parsed = urlsplit(target)
            if parsed.scheme or parsed.netloc or target.startswith("mailto:"):
                continue
            target_path = unquote(parsed.path)
            resolved = (path.parent / target_path).resolve() if target_path else path.resolve()
            try:
                resolved.relative_to(root_resolved)
            except ValueError:
                failures.append(f"{path.relative_to(ROOT)}: link escapes repository -> {target}")
                continue
            if not resolved.exists():
                failures.append(f"{path.relative_to(ROOT)}: broken link -> {target}")
                continue
            if parsed.fragment and resolved.suffix.lower() == ".md":
                anchor = unquote(parsed.fragment).lower()
                if anchor not in github_slugs(resolved.read_text(encoding="utf-8")):
                    failures.append(f"{path.relative_to(ROOT)}: missing heading anchor -> {target}")


def validate() -> list[str]:
    failures: list[str] = []
    skill_dirs = sorted(
        entry for entry in ROOT.iterdir()
        if entry.is_dir() and not entry.name.startswith(".") and entry.name not in NON_SKILL_DIRS
    )
    for directory in skill_dirs:
        check_skill_layout(directory, failures)
    check_catalog({entry.name for entry in skill_dirs}, failures)
    for english, chinese in REQUIRED_LANGUAGE_PAIRS:
        if not (ROOT / english).is_file() or not (ROOT / chinese).is_file():
            failures.append(f"missing language pair: {english} / {chinese}")
    for entry in sorted(ROOT.iterdir()):
        if entry.is_file() and entry.name not in TOP_LEVEL_FILES:
            failures.append(f"unexpected top-level file: {entry.name}")
    check_local_links(failures)
    return failures


def main() -> int:
    failures = validate()
    if failures:
        for failure in failures:
            print(f"error: {failure}")
        return 1
    print("structure OK: skill catalogs, metadata and local links validated")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
