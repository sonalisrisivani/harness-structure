# Claude Code Harness Template

This is a baseline workspace configuration for Claude Code (`CLAUDE.md`).
You can use `CLAUDE.md` to define instructions, memory, guidelines, architecture rules, and project patterns that Claude will autonomously load into every conversation context.

## 🏗️ Project Architecture
- **Environment**: General Polyglot Project
- **Primary Languages**: [Customize]
- **Key Frameworks**: [Customize]

## 🛠️ Code Standards
- **Style**: Follow standard idioms. Prefer clear, maintainable, and self-documenting code.
- **Errors**: Fail fast. Do not swallow exceptions silently. Log effectively.
- **Testing**: Write unit tests for business logic. Strive for high test coverage but prioritize critical paths.

## 🔒 Security & Git Rules
- **Security Check**: Do not output secrets, API keys, or raw passwords in code snippets.
- **Git Commits**: Use conventional commits (e.g., `feat:`, `fix:`, `chore:`, `refactor:`).
- **PRs**: Run tests before submitting opening Pull Requests. Use `/pr`.

## 🧠 Harness & Tools
This workspace is powered by a **Claude Code Harness**.
- **Commands**: Try typing `/help` or explore `/commands` to see automated slash commands like `/pr`, `/commit`, `/refactor`, `/security`.
- **Agents**: Try spawning specialized experts like `code-reviewer`, `test-writer`, `planner`, or `security-auditor` using the `Agent` tool or directly pinging them with `@`.
- **Hooks**: This harness includes Bash hooks (PreToolUse, PostToolUse, etc.) located in `.claude/hooks/` which enforce security and quality automations.

---

> _To inject a specialized preset (like Next.js, Rust, DevOps, AppSec), run: `./scripts/harness.sh apply <workspace-name>`_
