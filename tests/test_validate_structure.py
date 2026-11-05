"""验证结构校验器能发现真实回归，而不只验证当前文件布局。"""

from __future__ import annotations

import importlib.util
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

SCRIPT = Path(__file__).resolve().parents[1] / ".github" / "scripts" / "validate_structure.py"
spec = importlib.util.spec_from_file_location("validate_structure", SCRIPT)
validator = importlib.util.module_from_spec(spec)
assert spec.loader is not None
spec.loader.exec_module(validator)


class StructureTests(unittest.TestCase):
    def setUp(self) -> None:
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        for en, zh in validator.REQUIRED_LANGUAGE_PAIRS:
            (self.root / en).write_text("# Title\n", encoding="utf-8")
            (self.root / zh).write_text("# 标题\n", encoding="utf-8")
        (self.root / "LICENSE").write_text("MIT\n", encoding="utf-8")
        self.skill = self.root / "example-skill"
        (self.skill / "agents").mkdir(parents=True)
        (self.skill / "SKILL.md").write_text(
            "---\nname: example-skill\ndescription: Use for a precise task.\n---\n# Example\n",
            encoding="utf-8",
        )
        (self.skill / "agents" / "openai.yaml").write_text(
            'interface:\n  display_name: "Example Skill"\n'
            '  short_description: "A task"\n'
            '  default_prompt: "Use $example-skill for the task."\n',
            encoding="utf-8",
        )
        for name in ("README.md", "README.zh-CN.md"):
            (self.root / name).write_text(
                "# Title\n\n## Skill List\n\n| Skill | Description |\n|---|---|\n"
                "| `example-skill` | Demo |\n",
                encoding="utf-8",
            )
        self.patcher = patch.object(validator, "ROOT", self.root)
        self.patcher.start()
        self.addCleanup(self.patcher.stop)

    def test_valid_fixture(self) -> None:
        self.assertEqual(validator.validate(), [])

    def test_chinese_catalog_must_match(self) -> None:
        (self.root / "README.zh-CN.md").write_text("# 缺少目录\n", encoding="utf-8")
        self.assertTrue(any("README.zh-CN.md: missing skill" in item for item in validator.validate()))

    def test_invalid_runtime_prompt_is_caught(self) -> None:
        metadata = self.skill / "agents" / "openai.yaml"
        metadata.write_text(
            'interface:\n  display_name: "Example Skill"\n'
            '  short_description: "A task"\n'
            '  default_prompt: "Do something else."\n', encoding="utf-8",
        )
        self.assertTrue(any("must explicitly invoke" in item for item in validator.validate()))

    def test_malformed_metadata_is_caught(self) -> None:
        (self.skill / "agents" / "openai.yaml").write_text(
            'interface:\n  display_name: "Incomplete"\n', encoding="utf-8",
        )
        self.assertTrue(any("interface.short_description" in item for item in validator.validate()))

    def test_nonexistent_anchor_is_caught(self) -> None:
        path = self.root / "README.md"
        path.write_text(path.read_text(encoding="utf-8") + "\n[Jump](#not-a-title)\n", encoding="utf-8")
        self.assertTrue(any("missing heading anchor" in item for item in validator.validate()))

    def test_valid_chinese_anchor_is_supported(self) -> None:
        path = self.root / "README.zh-CN.md"
        path.write_text(path.read_text(encoding="utf-8") + "\n## 使用方法\n[跳转](#使用方法)\n", encoding="utf-8")
        self.assertEqual(validator.validate(), [])

    def test_path_escape_is_caught(self) -> None:
        path = self.root / "README.md"
        path.write_text(path.read_text(encoding="utf-8") + "\n[Escape](../outside.md)\n", encoding="utf-8")
        self.assertTrue(any("link escapes repository" in item for item in validator.validate()))

    def test_unexpected_skill_translation_is_caught(self) -> None:
        (self.skill / "SKILL.zh-CN.md").write_text("# 不允许\n", encoding="utf-8")
        self.assertTrue(any("unexpected translated" in item for item in validator.validate()))


if __name__ == "__main__":
    unittest.main()
