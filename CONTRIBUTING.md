# Contributing to Claude Code Harness

Thank you for your interest in contributing to **Claude Code Harness**! 🚀

Claude Code Harness provides turnkey workspace configurations, security guardrails, context compression anchors, and custom agent/command workflows for Anthropic's Claude Code CLI.

Whether you are contributing a new language workspace preset, building a security hook, creating an agent persona, or improving our CLI tooling, your contributions are welcome.

---

## 🧭 How You Can Contribute

1. **Workspace Presets**: Add ready-to-use workspace templates for popular frameworks and languages (e.g., Rust, Go, Flutter, Elixir, Ruby on Rails, Data/MLOps).
2. **Bash Hooks**: Build security scanners, secret detectors, linter hooks, or context injectors for PreToolUse and PostToolUse lifecycle events.
3. **Agent Personas & Slash Commands**: Define specialized subagent prompts (e.g., `accessibility-auditor`, `perf-profiler`) and markdown commands.
4. **CLI & Tooling**: Enhance `scripts/harness.sh` or `scripts/install.sh` with new capabilities, checks, and platform compatibility.
5. **Documentation & Guides**: Improve setup guides, explain context decay mitigation techniques, or share best practices.

---

## 🏗️ Repository & Harness Structure

Every workspace preset in `examples/workspaces/<preset-name>/` follows the standard 4-Tier Harness Model:

```text
examples/workspaces/<preset-name>/
├── CLAUDE.md                       # Tier 1: Context Compression & Invariant Rules
└── .claude/
    ├── settings.json               # CLI configuration & hook bindings
    ├── mcp.json                    # Model Context Protocol servers (optional)
    ├── rules/                      # Tier 2: Domain-specific coding & test rules
    │   ├── code-standards.md
    │   └── testing.md
    ├── hooks/                      # Tier 3: Security & lifecycle automation hooks
    │   └── bash/
    │       ├── security-check.sh
    │       └── auto-format.sh
    ├── agents/                     # Tier 4: Specialized subagent personas
    │   └── code-reviewer.md
    └── commands/                   # Tier 4: Custom slash commands (/pr, /test, etc.)
        └── pr.md
```

---

## 🛠️ Step-by-Step Contribution Guide

### 1. Adding a New Workspace Preset

1. Create a new directory under `examples/workspaces/<your-preset-name>/`.
2. Add a customized `CLAUDE.md` with:
   - Framework/stack architecture standards.
   - Session invariants (hard constraints that Claude must never violate).
   - Common build, test, and lint commands.
3. Create `.claude/settings.json` configuring relevant permissions, commands, and hooks.
4. Add applicable `.claude/rules/`, `.claude/hooks/`, `.claude/agents/`, and `.claude/commands/`.
5. Ensure all bash scripts are executable:
   ```bash
   chmod +x examples/workspaces/<your-preset-name>/.claude/hooks/bash/*.sh
   ```
6. Verify your preset using the built-in audit tool:
   ```bash
   ./scripts/harness.sh audit <your-preset-name>
   ```
   *Your preset should achieve a 5/5 score before submitting.*

---

### 2. Adding a Bash Hook

- Place reusable hooks in `examples/hooks/bash/<hook-name>.sh`.
- Always begin bash scripts with `#!/usr/bin/env bash` and `set -euo pipefail`.
- Keep hook execution fast (< 500ms) to avoid lagging Claude's tool execution loop.
- Hooks that block dangerous actions must exit with a non-zero exit code (`exit 1`) and print clear, actionable feedback to `stderr` explaining why the action was prevented.

---

### 3. Testing Your Changes Locally

Run the harness doctor and audit commands to verify health:

```bash
# Verify local environment and settings
./scripts/harness.sh doctor

# List available presets
./scripts/harness.sh list

# Audit a specific preset
./scripts/harness.sh audit <preset-name>

# Test applying your preset to a temporary directory
TMP_DIR=$(mktemp -d)
./scripts/harness.sh apply <preset-name> "$TMP_DIR"
./scripts/harness.sh doctor "$TMP_DIR"
rm -rf "$TMP_DIR"
```

---

## 📋 Pull Request Guidelines

1. **Fork and branch**: Create a descriptive feature branch from `main`:
   ```bash
   git checkout -b feat/rust-systems-preset
   ```
2. **Commit style**: Follow [Conventional Commits](https://www.conventionalcommits.org/):
   - `feat:` for new presets, hooks, or commands.
   - `fix:` for bug fixes in scripts or templates.
   - `docs:` for documentation improvements.
   - `refactor:` for code organization changes.
3. **No sensitive data**: Double-check that no personal paths, tokens, or API keys are present in templates.
4. **Open a PR**: Fill out the PR template with a description of what you added and sample testing output.

---

## 💬 Community & Help

- Check out existing [Good First Issues](https://github.com/sonalisrisivani/harness-structure/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22) for newcomer-friendly tasks.
- Join the discussion in [GitHub Discussions](https://github.com/sonalisrisivani/harness-structure/discussions) to propose new preset ideas or discuss Claude Code best practices.
