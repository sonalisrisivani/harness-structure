# Interactive Project Scaffolder & Workspace Customizer (/start)

You are setting up a custom, lightweight, high-productivity Claude Code workspace tailored to the user's exact daily coding needs.

Follow this step-by-step interactive workflow:

---

### Step 1: Detect Project Context (Silent Inspection)
1. Check the current working directory for existing project markers:
   - `package.json` (Node/Next.js/React/Vue/Svelte)
   - `pyproject.toml`, `requirements.txt`, `Pipfile` (Python)
   - `Cargo.toml` (Rust)
   - `go.mod` (Go)
   - `pubspec.yaml` (Flutter/Dart)
   - `Makefile`, `docker-compose.yml`, `.git`
2. Summarize what you detect (stack, package manager, existing scripts, test frameworks). If the directory is completely empty, note that it's a fresh project.

---

### Step 2: Ask 3 Quick Questions (Interactive Config)
Present your detected findings in a clean format, and ask the user to confirm or customize:

1. **Stack & Key Tools**:
   - Confirm detected stack (or ask if empty).
   - What UI/database/testing libraries are preferred? (e.g. Tailwind, Prisma, Pytest, Jest, Vitest).
2. **Coding Preferences & Workflows**:
   - What is the primary focus? (e.g., Fast MVP / High Test Coverage / Production-ready & strictly typed / Learning & exploration).
   - Do you want dedicated slash commands created for this project?
     - `/task` — Interactive step-by-step feature/bug checklist planner.
     - `/test` — One-click test runner with automated error diagnostics and fixes.
     - `/review` — Pre-commit code quality, security, and edge-case review.
     - `/log` — Save gotchas and resolved bugs into `LEARNINGS.md` for persistent session memory.
3. **Safety & Protected Files**:
   - Confirm which files Claude should **never edit or expose** (default: `.env*`, `*.pem`, `credentials.json`, `dist/`, `.git/`).

*(Wait for the user's response, or if the user ran `/start --quick` or provided answers upfront, proceed immediately using sensible defaults).*

---

### Step 3: Scaffold Clean, Tailored Files
Based on the user's choices, write the following minimal, high-value files:

#### 1. `CLAUDE.md` (Context Compression Anchor)
Write a clean, easy-to-read `CLAUDE.md` in the project root containing:
- **Project Overview & Tech Stack**: Languages, framework, styling, database.
- **Commands to Run**: Exact dev, test, lint, and build commands.
- **Code Standards**: Naming conventions, error handling expectations, type strictness.
- **Never-Break Invariants**: Hard rules (e.g. "Never commit secrets", "Never edit `.env`", "Always run tests before committing").

#### 2. `.claude/settings.json`
Configure workspace settings:
```json
{
  "permissions": {
    "deny": [
      "Edit:.env*",
      "Edit:*.pem",
      "Edit:credentials.json"
    ]
  }
}
```

#### 3. Custom Project Slash Commands in `.claude/commands/`:
- **`.claude/commands/task.md`**:
  ```markdown
  # /task - Interactive Task & Progress Tracker
  When the user invokes \`/task [description]\`:
  1. Break the task down into 3-6 clear, numbered, verifiable steps.
  2. Save this plan to \`.claude/tasks/current-task.md\`.
  3. Execute one step at a time, testing and verifying as you proceed.
  4. Check off completed items (\`[x]\`) after verifying each step.
  5. Summarize progress at each checkpoint.
  ```

- **`.claude/commands/test.md`**:
  ```markdown
  # /test - Smart Test Runner & Auto-Fixer
  When the user invokes \`/test\`:
  1. Run the project's test suite: \`<insert-detected-test-command>\`.
  2. If all tests pass, print a clean summary with green checkmarks.
  3. If any test fails:
     - Diagnose the root cause with the exact file and line number.
     - Explain the minimal fix clearly.
     - Apply the fix and re-run tests until passing.
  ```

- **`.claude/commands/review.md`**:
  ```markdown
  # /review - Pre-Commit Code Quality & Security Review
  When the user invokes \`/review\`:
  1. Run \`git diff\` to inspect all unstaged and staged changes.
  2. Review for:
     - Edge cases and missing error handling.
     - Accidental secret leaks or sensitive environment values.
     - Unused imports, dead code, or unintended console logs.
     - Adherence to \`CLAUDE.md\` standards.
  3. Output findings categorized as: 🔴 Critical (must fix), 🟡 Warning (consider fixing), 🟢 Good.
  ```

- **`.claude/commands/log.md`**:
  ```markdown
  # /log - Session Learning & Gotchas Logger
  When the user invokes \`/log [note/gotcha]\`:
  1. Append the learning to \`LEARNINGS.md\` with today's date.
  2. Keep it concise (1-2 sentences: Problem -> Solution/Gotcha).
  3. Confirm the note was saved to memory.
  ```

#### 4. `LEARNINGS.md` & `.claude/tasks/`
- Create an initial `LEARNINGS.md` with:
  ```markdown
  # Project Learnings & Gotchas
  This file tracks project quirks, architecture decisions, and resolved bugs so Claude remembers them in future sessions.

  ## Session History
  - **Initialized**: Workspace configured with Claude Code.
  ```
- Ensure directory `.claude/tasks/` exists.

---

### Step 4: Summary & Ready-to-Code Confirmation
Print a concise, encouraging message:
```text
✨ Claude Code workspace configured!

Created:
  ├── CLAUDE.md              # Project instructions & invariants
  ├── LEARNINGS.md           # Session memory & bug tracker
  └── .claude/
      ├── settings.json      # Security & protected files
      └── commands/          # Custom slash commands (/task, /test, /review, /log)

You are ready to code! Try running:
  - /task "Build my first feature"
  - /test
  - /review
```
