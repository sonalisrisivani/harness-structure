#!/usr/bin/env bash
# Claude Code Harness Installer
# Usage: curl -fsSL https://raw.githubusercontent.com/sonalisrisivani/harness-structure/main/scripts/install.sh | bash -s -- <preset-name>

set -euo pipefail

PRESET="${1:-minimal-starter}"
REPO_URL="https://raw.githubusercontent.com/sonalisrisivani/harness-structure/main"

echo "🚀 Injecting Claude Code harness (${PRESET}) into current directory..."

# Setup basics
mkdir -p .claude

# Download harness.sh manager if not present
if [ ! -f "scripts/harness.sh" ]; then
    mkdir -p scripts
    curl -sS "${REPO_URL}/scripts/harness.sh" > scripts/harness.sh
    chmod +x scripts/harness.sh
fi

# Apply the preset
./scripts/harness.sh apply "$PRESET"

echo "✅ Harness successfully injected. Launch 'claude' to start!"
