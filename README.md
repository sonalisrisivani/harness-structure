# Claude Code Workspace Manager & Harness Ecosystem

[![GitHub Stars](https://img.shields.io/github/stars/sonalisrisivani/harness-structure?style=social)](https://github.com/sonalisrisivani/harness-structure)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-6366f1.svg)](https://claude.ai/code)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/sonalisrisivani/harness-structure/pulls)

**The missing workspace manager for Claude Code.** Instantly inject battle-tested AI personas, security guardrails, memory layers, and workflow automation into any repository with **one command**.

> 🔗 **Reference & Source Attribution**: Foundational templates in this repository are based on the official [Claude Code Examples Catalog](https://github.com/Ayodet/Claude-Code/tree/main/examples?utm_source=chatgpt.com).

---

## ⚡ 15-Second Workspace Generator (NEW)

Instead of manually configuring a project, just drop the `/start` command into your global Claude config and let Claude scaffold the perfect environment for you.

```bash
# 1. Download the global start command
mkdir -p ~/.claude/commands
curl -fsSL https://raw.githubusercontent.com/sonalisrisivani/harness-structure/main/examples/commands/start.md -o ~/.claude/commands/start.md

# 2. Open any project and run:
claude
> /start
```

Claude will intelligently detect your stack (Next.js, Python, Rust, etc.) and generate a tailored `CLAUDE.md`, task trackers, bug logs, and custom slash commands in seconds.

---

## ⚡ 1-Line Remote Install (No Clone Required)

Inject a specialized Claude Code harness directly into your active project:

```bash
# Inject the Fullstack Next.js harness
curl -fsSL https://raw.githubusercontent.com/sonalisrisivani/harness-structure/main/scripts/install.sh | bash -s -- fullstack-nextjs

# Or inject the DevOps & SRE harness
curl -fsSL https://raw.githubusercontent.com/sonalisrisivani/harness-structure/main/scripts/install.sh | bash -s -- devops-cloud-sre

# Or inject the AppSec & Red Team security harness
curl -fsSL https://raw.githubusercontent.com/sonalisrisivani/harness-structure/main/scripts/install.sh | bash -s -- security-appsec-redteam
```

---

## 🚀 Why Use a Claude Code Harness?

| Feature | 🚫 Bare Claude Code | ⚡ With Harness Manager |
| :--- | :--- | :--- |
| **Context Retention** | Suffers from context decay in long sessions | `CLAUDE.md` context compression anchors retain instructions |
| **Security Guardrails** | Can accidentally run `rm -rf` or leak API keys | `PreToolUse` hooks block dangerous commands & detect secrets |
| **Code Quality** | Manual review required after every edit | `PostToolUse` hooks auto-format & typecheck code on save |
| **Domain Expertise** | Generic coding persona | 16+ specialized agents (DevOps SRE, AppSec, Architecture Reviewer) |
| **Setup Time** | 30+ minutes configuring `.claude/` files | **5 seconds (1-click turnkey injection)** |

---

## 🛠️ Interactive Workspace Manager (`harness.sh`)

If you clone the repository, you can use the built-in CLI manager with interactive selection and health checks:

### 1. Interactive Selection Menu
Simply run the script with no arguments to launch the interactive picker:
```bash
./scripts/harness.sh
```

### 2. Run Health Checks (`doctor`)
Inspect your current project to verify permissions, hook configurations, and JSON syntax:
```bash
./scripts/harness.sh doctor
```

### 3. List & Inspect Workspaces
```bash
./scripts/harness.sh list
./scripts/harness.sh info fullstack-nextjs
```

---

## 📂 Structure

*(... rest of the original structure table was here, this is a reconstruction ...)*
| Folder | Description | Count |
| :--- | :--- | :--- |
| [`examples/agents/`](./examples/agents/) | Custom AI personas for specialized tasks | 14 + 2 collections |
| [`examples/commands/`](./examples/commands/) | Slash commands (workflow automation) | 31 |
| [`examples/hooks/`](./examples/hooks/) | Event-driven security & automation scripts | 34 |
| [`examples/skills/`](./examples/skills/) | Reusable knowledge modules | 17 |
| [`examples/claude-md/`](./examples/claude-md/) | CLAUDE.md configuration profiles | 7 |
| [`examples/config/`](./examples/config/) | Settings, MCP, git templates | 8 |
| [`examples/workspaces/`](./examples/workspaces/) | Ready-to-inject turn-key customized workspaces | 5 |

---

## 📍 File Locations

| Type | Project Location | Global Location |
| :--- | :--- | :--- |
| **Agents** | `.claude/agents/` | `~/.claude/agents/` |
| **Commands** | `.claude/commands/` | `~/.claude/commands/` |
| **Hooks** | `.claude/hooks/` | `~/.claude/hooks/` |
| **Config** | `.claude/` | `~/.claude/` |
| **Memory** | `./CLAUDE.md` | `~/.claude/CLAUDE.md` |

---

*(Note: The full table list was truncated here for brevity, users can click into individual directories to explore templates.)*
