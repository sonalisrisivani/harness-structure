# Claude Code Harness & Template Library

Annotated templates that teach you **why** patterns work, not just how to configure them. Each template includes comments explaining trade-offs, alternatives, and when to deviate.

> 🔗 **Reference & Source Attribution**: All foundational templates and tables in this repository are referenced from the official [Claude Code Examples Catalog](https://github.com/Ayodet/Claude-Code/tree/main/examples?utm_source=chatgpt.com).

---

## ⚡ Workspace Injection Quick Start

This repository includes a built-in **Harness Manager** (`./scripts/harness.sh`) that allows you to instantly inject pre-packaged workspace presets into your active project.

### 1. View Available Workspaces
```bash
./scripts/harness.sh list
```

### 2. Inject a Specialized Workspace
```bash
./scripts/harness.sh apply fullstack-nextjs
# or: ./scripts/harness.sh apply devops-cloud-sre
# or: ./scripts/harness.sh apply security-appsec-redteam
# or: ./scripts/harness.sh apply python-ai-datascience
# or: ./scripts/harness.sh apply minimal-starter
```

### 3. Launch Claude Code
```bash
claude
```

---

## 📂 Structure

| Folder | Description | Count |
| :--- | :--- | :--- |
| [`examples/agents/`](./examples/agents/) | Custom AI personas for specialized tasks | 14 + 2 collections |
| [`examples/commands/`](./examples/commands/) | Slash commands (workflow automation) | 31 |
| [`examples/hooks/`](./examples/hooks/) | Event-driven security & automation scripts | 34 |
| [`examples/skills/`](./examples/skills/) | Reusable knowledge modules — [9 on SkillHub](https://skills.palebluedot.live/owner/FlorianBruniaux) | 17 |
| [`examples/claude-md/`](./examples/claude-md/) | CLAUDE.md configuration profiles | 7 |
| [`examples/config/`](./examples/config/) | Settings, MCP, git templates | 8 |
| [`examples/memory/`](./examples/memory/) | CLAUDE.md memory file templates | 2 |
| [`examples/rules/`](./examples/rules/) | Behavioral rules for common review patterns | 5 |
| [`examples/scripts/`](./examples/scripts/) | Diagnostic & utility scripts | 16 |
| [`examples/team-config/`](./examples/team-config/) | Team onboarding templates | 3 |
| [`examples/templates/`](./examples/templates/) | Session and workflow templates | 1 |
| [`examples/github-actions/`](./examples/github-actions/) | CI/CD workflows | 4 |
| [`examples/workflows/`](./examples/workflows/) | Advanced development workflows | 3 |
| [`examples/plugins/`](./examples/plugins/) | Community plugins (SE-CoVe, claude-mem) | 2 |
| [`examples/integrations/`](./examples/integrations/) | External tool integrations (Agent Vibes TTS) | 1 |
| [`examples/mcp-configs/`](./examples/mcp-configs/) | MCP server configurations | 1 |
| [`examples/modes/`](./examples/modes/) | Behavioral modes (SuperClaude) | 1 |
| [`examples/semantic-anchors/`](./examples/semantic-anchors/) | Precise vocabulary for better LLM outputs | 1 |
| [`examples/workspaces/`](./examples/workspaces/) | Ready-to-inject turn-key customized workspaces | 5 |

---

## 🚀 Quick Start (Manual Setup)

1. Copy the template you need from [`examples/`](./examples/)
2. Customize for your project
3. Place in the correct location (see paths below)

---

## 📍 File Locations

| Type | Project Location | Global Location |
| :--- | :--- | :--- |
| **Agents** | `.claude/agents/` | `~/.claude/agents/` |
| **Skills** | `.claude/skills/` | `~/.claude/skills/` |
| **Commands** | `.claude/commands/` | `~/.claude/commands/` |
| **Hooks** | `.claude/hooks/` | `~/.claude/hooks/` |
| **Config** | `.claude/` | `~/.claude/` |
| **Memory** | `./CLAUDE.md` or `.claude/CLAUDE.md` | `~/.claude/CLAUDE.md` |
| **Modes** | — | `~/.claude/MODE_*.md` |

> **Windows**: Replace `~/.claude/` with `%USERPROFILE%\.claude\`

---

## 📚 Templates Index

### 🤖 Agents (16)

| File | Purpose | Model |
| :--- | :--- | :--- |
| [code-reviewer.md](./examples/agents/code-reviewer.md) | Thorough code review | Sonnet |
| [test-writer.md](./examples/agents/test-writer.md) | TDD/BDD test generation | Sonnet |
| [security-auditor.md](./examples/agents/security-auditor.md) | Security vulnerability detection | Sonnet |
| [refactoring-specialist.md](./examples/agents/refactoring-specialist.md) | Clean code refactoring | Sonnet |
| [output-evaluator.md](./examples/agents/output-evaluator.md) | LLM-as-a-Judge quality gate | Haiku |
| [devops-sre.md](./examples/agents/devops-sre.md) | Infrastructure troubleshooting with FIRE framework | Sonnet |
| [planner.md](./examples/agents/planner.md) | Strategic planning — read-only, before implementation | Opus |
| [implementer.md](./examples/agents/implementer.md) | Mechanical execution — bounded scope | Haiku |
| [architecture-reviewer.md](./examples/agents/architecture-reviewer.md) | Architecture & design review — read-only | Opus |
| [adr-writer.md](./examples/agents/adr-writer.md) | Architecture Decision Record generator — read-only | Opus |
| [integration-reviewer.md](./examples/agents/integration-reviewer.md) | Runtime integration validator — read-only | Sonnet |
| [plan-challenger.md](./examples/agents/plan-challenger.md) | Adversarial plan review across 5 dimensions — read-only | Sonnet |
| [planning-coordinator.md](./examples/agents/planning-coordinator.md) | Synthesis agent for dynamic research teams — read-only | Sonnet |
| [security-patcher.md](./examples/agents/security-patcher.md) | Apply security patches from audit findings — proposes for review | Sonnet |
| [analytics-with-eval/](./examples/agents/analytics-with-eval/) | Collection: analytics agent + evaluation hooks | — |
| [cyber-defense/](./examples/agents/cyber-defense/) | Collection: anomaly detector, log ingestor, risk classifier, threat reporter | — |

---

### 🧠 Skills (17)

| File | Purpose |
| :--- | :--- |
| [design-patterns/](./examples/skills/design-patterns/) | Detect and analyze GoF design patterns with stack-aware suggestions |
| [tdd-workflow.md](./examples/skills/tdd-workflow.md) | Test-Driven Development process |
| [security-checklist.md](./examples/skills/security-checklist.md) | OWASP Top 10 security checks |
| [pdf-generator.md](./examples/skills/pdf-generator.md) | Professional PDF generation (Quarto/Typst) |
| [voice-refine/](./examples/skills/voice-refine/) | Writing voice refinement with before/after examples |
| [ast-grep-patterns.md](./examples/skills/ast-grep-patterns.md) | AST-based code search patterns |
| [rtk-optimizer/](./examples/skills/rtk-optimizer/) | RTK token optimization analysis |
| [audit-agents-skills/](./examples/skills/audit-agents-skills/) | Quality audit for agents, skills, and commands |
| [skill-creator/](./examples/skills/skill-creator/) | Create new skills with proper structure and best practices |
| [landing-page-generator/](./examples/skills/landing-page-generator/) | Generate deploy-ready landing pages from any repository |
| [ccboard/](./examples/skills/ccboard/) | Comprehensive TUI/Web dashboard for Claude Code monitoring |
| [guide-recap/](./examples/skills/guide-recap/) | Transform CHANGELOG entries into social content (LinkedIn, Twitter/X, Slack) |
| [release-notes-generator/](./examples/skills/release-notes-generator/) | Generate release notes in 3 formats from git commits |
| [pr-triage/](./examples/skills/pr-triage/) | 4-phase PR backlog management (audit, deep review, validated comments, worktree setup) |
| [issue-triage/](./examples/skills/issue-triage/) | 3-phase issue backlog management (audit, deep analysis, validated actions) |
| [cyber-defense-team/](./examples/skills/cyber-defense-team/) | Multi-agent cyber defense team orchestration |
| [talk-pipeline/](./examples/skills/talk-pipeline/) | 6-stage pipeline: raw material to slides via Kimi |

---

### ⚡ Commands (31)

| File | Trigger | Purpose |
| :--- | :--- | :--- |
| [commit.md](./examples/commands/commit.md) | `/commit` | Conventional commit messages |
| [pr.md](./examples/commands/pr.md) | `/pr` | Create well-structured PRs with scope analysis |
| [review-pr.md](./examples/commands/review-pr.md) | `/review-pr` | PR review workflow |
| [release-notes.md](./examples/commands/release-notes.md) | `/release-notes` | Generate release notes in 3 formats |
| [sonarqube.md](./examples/commands/sonarqube.md) | `/sonarqube` | Analyze SonarCloud quality issues for PRs |
| [generate-tests.md](./examples/commands/generate-tests.md) | `/generate-tests` | Test generation |
| [git-worktree.md](./examples/commands/git-worktree.md) | `/git-worktree` | Isolated git worktree setup |
| [git-worktree-status.md](./examples/commands/git-worktree-status.md) | `/git-worktree-status` | Check worktree background verification tasks |
| [git-worktree-remove.md](./examples/commands/git-worktree-remove.md) | `/git-worktree-remove` | Safe worktree removal with merge checks |
| [git-worktree-clean.md](./examples/commands/git-worktree-clean.md) | `/git-worktree-clean` | Batch cleanup of stale worktrees |
| [diagnose.md](./examples/commands/diagnose.md) | `/diagnose` | Interactive troubleshooting assistant (FR/EN) |
| [validate-changes.md](./examples/commands/validate-changes.md) | `/validate-changes` | LLM-as-a-Judge pre-commit validation |
| [catchup.md](./examples/commands/catchup.md) | `/catchup` | Restore context after /clear |
| [security.md](./examples/commands/security.md) | `/security` | Quick OWASP security audit |
| [security-check.md](./examples/commands/security-check.md) | `/security-check` | Config scan vs known threats (~30s) |
| [security-audit.md](./examples/commands/security-audit.md) | `/security-audit` | Full 6-phase audit with score /100 |
| [update-threat-db.md](./examples/commands/update-threat-db.md) | `/update-threat-db` | Research & update threat intelligence |
| [audit-agents-skills.md](./examples/commands/audit-agents-skills.md) | `/audit-agents-skills` | Quality audit for .claude/ config |
| [sandbox-status.md](./examples/commands/sandbox-status.md) | `/sandbox-status` | Sandbox isolation status check |
| [refactor.md](./examples/commands/refactor.md) | `/refactor` | SOLID-based code improvements |
| [explain.md](./examples/commands/explain.md) | `/explain` | Code explanations (3 depth levels) |
| [optimize.md](./examples/commands/optimize.md) | `/optimize` | Performance analysis and roadmap |
| [ship.md](./examples/commands/ship.md) | `/ship` | Pre-deploy checklist |
| [learn/quiz.md](./examples/commands/learn/quiz.md) | `/learn:quiz` | Self-testing for learning concepts |
| [learn/teach.md](./examples/commands/learn/teach.md) | `/learn:teach` | Step-by-step concept explanations |
| [learn/alternatives.md](./examples/commands/learn/alternatives.md) | `/learn:alternatives` | Compare different approaches |
| [audit-codebase.md](./examples/commands/audit-codebase.md) | `/audit-codebase` | Codebase health audit scoring 7 categories |
| [plan-start.md](./examples/commands/plan-start.md) | `/plan-start` | 5-phase planning: PRD analysis, design review, technical decisions, research team, metrics |
| [plan-execute.md](./examples/commands/plan-execute.md) | `/plan-execute` | Execute validated plan: worktree isolation, TDD scaffolding, parallel agents, PR creation |
| [plan-validate.md](./examples/commands/plan-validate.md) | `/plan-validate` | 2-layer plan validation: structural checks + specialist agents, auto-fix issues |
| [review-plan.md](./examples/commands/review-plan.md) | `/review-plan` | Structured plan review across 4 axes before writing code |

---

### 🛡️ Hooks (34)

#### Security Hooks (13 bash)

| File | Event | Purpose |
| :--- | :--- | :--- |
| [dangerous-actions-blocker.sh](./examples/hooks/bash/dangerous-actions-blocker.sh) | PreToolUse | Block `rm -rf`, force-push, production ops |
| [prompt-injection-detector.sh](./examples/hooks/bash/prompt-injection-detector.sh) | PreToolUse | Detect injection patterns in prompts |
| [unicode-injection-scanner.sh](./examples/hooks/bash/unicode-injection-scanner.sh) | PreToolUse | Detect zero-width, RTL override, ANSI escape |
| [repo-integrity-scanner.sh](./examples/hooks/bash/repo-integrity-scanner.sh) | PreToolUse | Scan README/package.json for hidden injection |
| [security-check.sh](./examples/hooks/bash/security-check.sh) | PreToolUse | Block secrets in commands |
| [sandbox-validation.sh](./examples/hooks/bash/sandbox-validation.sh) | PreToolUse | Validate sandbox isolation |
| [file-guard.sh](./examples/hooks/bash/file-guard.sh) | PreToolUse | Protect sensitive files from modification |
| [permission-request.sh](./examples/hooks/bash/permission-request.sh) | PreToolUse | Explicit permission flow for risky ops |
| [mcp-config-integrity.sh](./examples/hooks/bash/mcp-config-integrity.sh) | SessionStart | Verify MCP config hash (CVE protection) |
| [claudemd-scanner.sh](./examples/hooks/bash/claudemd-scanner.sh) | SessionStart | Detect CLAUDE.md injection attacks |
| [output-secrets-scanner.sh](./examples/hooks/bash/output-secrets-scanner.sh) | PostToolUse | Prevent API keys/tokens in Claude responses |
| [pre-commit-secrets.sh](./examples/hooks/bash/pre-commit-secrets.sh) | Git hook | Block secrets from entering commits |
| [security-gate.sh](./examples/hooks/bash/security-gate.sh) | PreToolUse | Detect vulnerable code patterns before writing to source files |

#### Productivity Hooks (10)

| File | Event | Purpose |
| :--- | :--- | :--- |
| [auto-format.sh](./examples/hooks/bash/auto-format.sh) | PostToolUse | Auto-format after edits (Prettier, Black, go fmt) |
| [auto-checkpoint.sh](./examples/hooks/bash/auto-checkpoint.sh) | PostToolUse | Auto-checkpoint work at intervals |
| [typecheck-on-save.sh](./examples/hooks/bash/typecheck-on-save.sh) | PostToolUse | Run TypeScript checks on save |
| [test-on-change.sh](./examples/hooks/bash/test-on-change.sh) | PostToolUse | Run tests on file changes |
| [rtk-auto-wrapper.sh](./examples/hooks/bash/rtk-auto-wrapper.sh) | PreToolUse | Auto-wrap commands with RTK for token savings |
| [rtk-baseline.sh](./examples/hooks/bash/rtk-baseline.sh) | SessionStart | Save RTK baseline for session savings tracking |
| [setup-init.sh](./examples/hooks/bash/setup-init.sh) | SessionStart | Initialize session environment |
| [subagent-stop.sh](./examples/hooks/bash/subagent-stop.sh) | Stop | Clean up sub-agent resources |
| [auto-rename-session.sh](./examples/hooks/bash/auto-rename-session.sh) | SessionEnd | AI-powered session title generation (Haiku) |
| [velocity-governor.sh](./examples/hooks/bash/velocity-governor.sh) | PreToolUse | Rate-limit tool calls to avoid API throttling |

#### Monitoring Hooks (6)

| File | Event | Purpose |
| :--- | :--- | :--- |
| [output-validator.sh](./examples/hooks/bash/output-validator.sh) | PostToolUse | Heuristic output validation |
| [session-logger.sh](./examples/hooks/bash/session-logger.sh) | PostToolUse | Log operations for monitoring |
| [session-summary.sh](./examples/hooks/bash/session-summary.sh) | SessionEnd | Display session stats (duration, tools, cost, RTK savings) |
| [session-summary-config.sh](./examples/hooks/bash/session-summary-config.sh) | CLI tool | Configure session-summary sections and display |
| [learning-capture.sh](./examples/hooks/bash/learning-capture.sh) | Stop | Prompt for daily learning capture |
| [privacy-warning.sh](./examples/hooks/bash/privacy-warning.sh) | PostToolUse | Warn on potential privacy leaks |

#### Notification & TTS (3)

| File | Event | Purpose |
| :--- | :--- | :--- |
| [notification.sh](./examples/hooks/bash/notification.sh) | Notification | Contextual macOS sound alerts |
| [tts-selective.sh](./examples/hooks/bash/tts-selective.sh) | PostToolUse | Text-to-speech for selected outputs |
| [pre-commit-evaluator.sh](./examples/hooks/bash/pre-commit-evaluator.sh) | Git hook | LLM-as-a-Judge pre-commit |

#### PowerShell (2)

| File | Event | Purpose |
| :--- | :--- | :--- |
| [security-check.ps1](./examples/hooks/powershell/security-check.ps1) | PreToolUse | Block secrets in commands |
| [auto-format.ps1](./examples/hooks/powershell/auto-format.ps1) | PostToolUse | Auto-format after edits |

---

### ⚙️ Config (8)

| File | Purpose |
| :--- | :--- |
| [settings.json](./examples/config/settings.json) | Hooks configuration |
| [mcp.json](./examples/config/mcp.json) | MCP servers setup |
| [.gitignore-claude](./examples/config/.gitignore-claude) | Git ignore patterns |
| [CONTRIBUTING-ai-disclosure.md](./examples/config/CONTRIBUTING-ai-disclosure.md) | AI disclosure template for CONTRIBUTING.md |
| [PULL_REQUEST_TEMPLATE-ai.md](./examples/config/PULL_REQUEST_TEMPLATE-ai.md) | PR template with AI attribution |
| [sandbox-native.json](./examples/config/sandbox-native.json) | Native Claude Code sandbox configuration |
| [settings-personalization.json](./examples/config/settings-personalization.json) | UI personalization: spinner verbs, custom tips carousel |
| [settings.local.json.example](./examples/config/settings.local.json.example) | Local overrides example (gitignored) |

---

### 🧠 Memory (2)

| File | Purpose |
| :--- | :--- |
| [CLAUDE.md.project-template](./examples/memory/CLAUDE.md.project-template) | Team project memory |
| [CLAUDE.md.personal-template](./examples/memory/CLAUDE.md.personal-template) | Personal global memory |

---

### 📝 CLAUDE.md Configurations (7)

| File | Purpose |
| :--- | :--- |
| [learning-mode.md](./examples/claude-md/learning-mode.md) | Learning-focused development configuration |
| [devops-sre.md](./examples/claude-md/devops-sre.md) | DevOps/SRE project configuration |
| [product-designer.md](./examples/claude-md/product-designer.md) | Product designer workflow configuration |
| [tts-enabled.md](./examples/claude-md/tts-enabled.md) | Text-to-speech enabled configuration |
| [rtk-optimized.md](./examples/claude-md/rtk-optimized.md) | RTK token-optimized configuration |
| [session-naming.md](./examples/claude-md/session-naming.md) | Auto-rename sessions with descriptive titles for parallel work |
| [design-reference-file.md](./examples/claude-md/design-reference-file.md) | Brand-book and UI kit context for consistent UI generation |

---

### 🛠️ Scripts (16)

| File | Purpose | Output |
| :--- | :--- | :--- |
| [audit-scan.sh](./examples/scripts/audit-scan.sh) | Fast setup audit scanner | JSON / Human |
| [check-claude.sh](./examples/scripts/check-claude.sh) | Health check diagnostics (macOS/Linux) | Human |
| [check-claude.ps1](./examples/scripts/check-claude.ps1) | Health check diagnostics (Windows) | Human |
| [clean-reinstall-claude.sh](./examples/scripts/clean-reinstall-claude.sh) | Clean reinstall procedure (macOS/Linux) | Human |
| [clean-reinstall-claude.ps1](./examples/scripts/clean-reinstall-claude.ps1) | Clean reinstall procedure (Windows) | Human |
| [session-stats.sh](./examples/scripts/session-stats.sh) | Analyze session logs & costs | JSON / Human |
| [session-search.sh](./examples/scripts/session-search.sh) | Fast session search & resume | Human |
| [cc-sessions.py](./examples/scripts/cc-sessions.py) | Advanced session search with incremental indexing | Human |
| [fresh-context-loop.sh](./examples/scripts/fresh-context-loop.sh) | Auto-restart sessions at context limits | Human |
| [bridge.py](./examples/scripts/bridge.py) | Plan bridging between sessions | JSON |
| [bridge-plan-schema.json](./examples/scripts/bridge-plan-schema.json) | JSON Schema for bridge plan v1 format | — |
| [migrate-arguments-syntax.sh](./examples/scripts/migrate-arguments-syntax.sh) | Migrate v1 → v2 argument syntax (bash) | Human |
| [migrate-arguments-syntax.ps1](./examples/scripts/migrate-arguments-syntax.ps1) | Migrate v1 → v2 argument syntax (PowerShell) | Human |
| [rtk-benchmark.sh](./examples/scripts/rtk-benchmark.sh) | Benchmark RTK token savings | Human |
| [sync-claude-config.sh](./examples/scripts/sync-claude-config.sh) | Sync Claude config across machines | Human |
| [sonnetplan.sh](./examples/scripts/sonnetplan.sh) | Alias to run Claude with Sonnet instead of Opus (cost optimization) | Human |

---

### 📐 Rules (5)

| File | Purpose |
| :--- | :--- |
| [architecture-review.md](./examples/rules/architecture-review.md) | Rules for architecture review sessions |
| [code-quality-review.md](./examples/rules/code-quality-review.md) | Rules for code quality review sessions |
| [first-principles.md](./examples/rules/first-principles.md) | First-principles reasoning rules |
| [performance-review.md](./examples/rules/performance-review.md) | Rules for performance review sessions |
| [test-review.md](./examples/rules/test-review.md) | Rules for test review sessions |

---

### 👥 Team Config (3)

| File | Purpose |
| :--- | :--- |
| [claude-skeleton.md](./examples/team-config/claude-skeleton.md) | Minimal CLAUDE.md skeleton for new team members |
| [profile-template.yaml](./examples/team-config/profile-template.yaml) | Profile assembly template for multi-tool teams |
| [sync-script.ts](./examples/team-config/sync-script.ts) | Sync Claude config across team machines |

---

### 📋 Templates (1)

| File | Purpose |
| :--- | :--- |
| [session-handoff-lorenz.md](./examples/templates/session-handoff-lorenz.md) | Session handoff template for context continuity |

---

### 🚀 GitHub Actions (4)

| File | Trigger | Purpose |
| :--- | :--- | :--- |
| [claude-code-review.yml](./examples/github-actions/claude-code-review.yml) ⭐ | PR open/sync + `/claude-review` comment | Prompt-based review (externalized prompt + anti-hallucination protocol) |
| [claude-pr-auto-review.yml](./examples/github-actions/claude-pr-auto-review.yml) | PR open/update | Auto code review with inline comments |
| [claude-security-review.yml](./examples/github-actions/claude-security-review.yml) | PR open/update | Security-focused scan (OWASP) |
| [claude-issue-triage.yml](./examples/github-actions/claude-issue-triage.yml) | Issue opened | Auto-triage with labels and severity |

---

### 🔄 Workflows (3)

| File | Purpose |
| :--- | :--- |
| [database-branch-setup.md](./examples/workflows/database-branch-setup.md) | Isolated feature dev with database branches (Neon/PlanetScale) |
| [memory-stack-integration.md](./examples/workflows/memory-stack-integration.md) | Multi-day workflow with memory tools (claude-mem + Serena + grepai) |
| [remotion-quickstart.md](./examples/workflows/remotion-quickstart.md) | Video generation workflow with Remotion |

---

### 🔌 Plugins (2)

| File | Purpose |
| :--- | :--- |
| [se-cove.md](./examples/plugins/se-cove.md) | Chain-of-Verification for independent code review (Meta AI, ACL 2024) |
| [claude-mem.md](./examples/plugins/claude-mem.md) | Persistent memory management plugin |

---

### 🔊 Integrations (1)

| Tool | Purpose |
| :--- | :--- |
| [Agent Vibes TTS](./examples/integrations/agent-vibes/) | Text-to-speech narration for Claude Code responses |

---

### 🔌 MCP Configs (1)

| File | Purpose |
| :--- | :--- |
| [figma.json](./examples/mcp-configs/figma.json) | Figma MCP server configuration |

---

### 🎯 Modes (1)

| File | Purpose | Activation |
| :--- | :--- | :--- |
| [MODE_Learning.md](./examples/modes/MODE_Learning.md) | Just-in-time explanations | `--learn` flag |

---

### 🏷️ Semantic Anchors (1)

| File | Purpose |
| :--- | :--- |
| [anchor-catalog.md](./examples/semantic-anchors/anchor-catalog.md) | Comprehensive catalog of precise technical terms for prompting |
