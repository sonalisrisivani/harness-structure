# Claude Code Harness Structure

A modular, turnkey template for **Claude Code** harnesses.

This project provides a professional-grade scaffold to turn basic Claude Code projects into **deterministic, safe, automated software engineering systems**.

> 🔗 **Reference & Origin**: This harness structure and its examples are derived from the [Claude Code Examples](https://github.com/Ayodet/Claude-Code/tree/main/examples?utm_source=chatgpt.com) repository.

---

## 🏗️ Architecture

```text
harness-structure/
├── .claude/                # Base harness configuration
│   ├── agents/             # Persona-based AI agents
│   ├── commands/           # Automated slash commands
│   ├── hooks/              # Pre/Post-tool security & productivity
│   ├── rules/              # Governance and behavior logic
│   └── settings.json       # Hook configuration
├── CLAUDE.md               # Workspace memory & instructions
├── examples/               # Library of templates (agents, commands, etc.)
│   └── workspaces/         # Turnkey injection-ready presets
│       ├── fullstack-nextjs/
│       ├── python-ai-datascience/
│       ├── security-appsec-redteam/
│       └── ...
└── scripts/
    └── harness.sh          # Harness Manager CLI
```

---

## 🚀 Quick Start

1. **Clone this harness template** into your target project.
2. **Explore available workspaces**:
   ```bash
   ./scripts/harness.sh list
   ```
3. **Inject a preset** (e.g., `fullstack-nextjs`):
   ```bash
   ./scripts/harness.sh apply fullstack-nextjs
   ```
4. **Launch Claude Code**:
   ```bash
   claude
   ```
   *The harness will automatically pick up your injected configuration!*

---

## 💡 How to Customize

- **Add Agents**: Create new persona files in `.claude/agents/`.
- **Add Workflows**: Define new slash commands in `.claude/commands/`.
- **Enforce Safety**: Customize bash hooks in `.claude/hooks/` (e.g., block dangerous commands, enforce secrets scanning).
- **Export Presets**: Once you have a configuration you love, you can crystallize it into a reuseable preset:
  ```bash
  ./scripts/harness.sh export my-custom-preset
  ```

---

*This project is designed to make your AI-assisted engineering workflow modular, safe, and highly reproducible.*
EOF
