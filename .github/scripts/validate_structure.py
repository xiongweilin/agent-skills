"""Validate the skill-index repository structure.

Checks, using only the standard library:

1. every top-level directory is a skill with the canonical layout
   (``SKILL.md`` + ``agents/openai.yaml``);
2. ``SKILL.md`` frontmatter ``name`` matches the directory and a
   ``description`` is present;
3. ``agents/openai.yaml`` carries display metadata that references the skill;
4. the README skill table and the on-disk skill set agree in both directions;
5. local Markdown links (relative paths and fragments) resolve.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path
from urllib.parse import unquote, urlsplit

ROOT = Path(__file__).resolve().parent.parent.parent
TOP_LEVEL_FILES = {"README.md", "CONTRIBUTING.md", "SECURITY.md", "LICENSE", "LICENSE.md", "CODE_OF_CONDUCT.md", "CODE_OF_CONDUCT", ".editorconfig", ".gitignore", ".gitattributes"}
SKILL_FILE = "SKILL.md"
AGENT_META = Path("agents") / "openai.yaml"


def read_frontmatter(path: Path) -> dict[str, str]:
    """Read the ``---`` delimited frontmatter block of a Markdown file."""
    text = path.read_text(encoding="utf-8")
    match = re.match(r"^---\s*\n(.*?)\n---\s*\n", text, flags=re.DOTALL)
    if not match:
        return {}
    fields: dict[str, str] = {}
    for line in match.group(1).splitlines():
        field = re.match(r"^([A-Za-z0-9_-]+):\s*(.*)$", line)
        if field:
            fields[field.group(1)] = field.group(2).strip().strip("\"'")
    return fields


def check_skill_layout(skill_dir: Path, failures: list[str]) -> None:
    skill_md = skill_dir / SKILL_FILE
    agent_yaml = skill_dir / AGENT_META
    if not skill_md.is_file():
        failures.append(f"{skill_dir.name}: missing {SKILL_FILE}")
    if not agent_yaml.is_file():
        failures.append(f"{skill_dir.name}: missing {AGENT_META}")
        return

    frontmatter = read_frontmatter(skill_md) if skill_md.is_file() else {}
    if frontmatter.get("name") != skill_dir.name:
        failures.append(
            f"{skill_dir.name}: SKILL.md frontmatter name must be '{skill_dir.name}', "
            f"got {frontmatter.get('name')!r}"
        )
    if not frontmatter.get("description"):
        failures.append(f"{skill_dir.name}: SKILL.md frontmatter description is missing or empty")

    yaml_text = agent_yaml.read_text(encoding="utf-8")
    has_display_name = re.search(r"^\s*display_name\s*:", yaml_text, flags=re.MULTILINE) is not None
    has_short_description = re.search(r"^\s*short_description\s*:", yaml_text, flags=re.MULTILINE) is not None
    references_skill = skill_dir.name in yaml_text
    if not (has_display_name and has_short_description):
        failures.append(f"{skill_dir.name}: agents/openai.yaml must declare display_name and short_description")
    if not references_skill:
        failures.append(f"{skill_dir.name}: agents/openai.yaml must reference the skill name {skill_dir.name!r}")


def check_readme_table(skill_names: set[str], failures: list[str]) -> None:
    readme = ROOT / "README.md"
    if not readme.is_file():
        failures.append("README.md is missing")
        return
    listed: set[str] = set()
    for line in readme.read_text(encoding="utf-8").splitlines():
        if not line.startswith("|"):
            continue
        cells = [cell.strip() for cell in line.strip("|").split("|")]
        if not cells:
            continue
        match = re.search(r"`([a-z0-9-]+)`", cells[0])
        if match:
            listed.add(match.group(1))
    missing = skill_names - listed
    dead = listed - skill_names
    for name in sorted(missing):
        failures.append(f"README skill table is missing entry for {name!r}")
    for name in sorted(dead):
        failures.append(f"README skill table lists {name!r} but no such skill directory exists")


def check_local_links(failures: list[str]) -> None:
    for path in ROOT.rglob("*.md"):
        if ".github" in path.parts:
            continue
        text = path.read_text(encoding="utf-8")
        for target in re.findall(r"\[[^\]]*\]\(([^)]+)\)", text):
            parts = urlsplit(target)
            if parts.scheme or parts.netloc or target.startswith(("mailto:", "#")):
                continue
            resolved = (path.parent / unquote(parts.path)).resolve()
            if not resolved.exists():
                failures.append(f"{path.relative_to(ROOT)}: broken link -> {target}")
                continue
            if parts.fragment and resolved.suffix.lower() in {".md", ".html"}:
                body = resolved.read_text(encoding="utf-8")
                anchor = parts.fragment.lower()
                if anchor not in body.lower():
                    failures.append(f"{path.relative_to(ROOT)}: missing fragment -> {target}")


def main() -> int:
    failures: list[str] = []
    skill_names = {d.name for d in ROOT.iterdir() if d.is_dir() and not d.name.startswith(".")}
    for entry in sorted(ROOT.iterdir()):
        if entry.is_dir() and not entry.name.startswith("."):
            check_skill_layout(entry, failures)
    check_readme_table(skill_names, failures)
    for entry in sorted(ROOT.iterdir()):
        if entry.is_file() and entry.name not in TOP_LEVEL_FILES:
            failures.append(f"unexpected top-level file: {entry.name}")
    check_local_links(failures)

    if failures:
        for failure in failures:
            print(f"error: {failure}")
        return 1
    print(f"structure OK: {len(skill_names)} skills validated")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

