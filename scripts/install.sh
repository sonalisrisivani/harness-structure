#!/usr/bin/env bash
# ==============================================================================
# Claude Code Harness Remote One-Line Installer
# ==============================================================================
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/sonalisrisivani/harness-structure/main/scripts/install.sh | bash -s -- <preset-name>
#
# Example:
#   curl -fsSL https://raw.githubusercontent.com/sonalisrisivani/harness-structure/main/scripts/install.sh | bash -s -- fullstack-nextjs
# ==============================================================================

set -euo pipefail

PRESET="${1:-minimal-starter}"
TARGET_DIR="${2:-.}"
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"
TARBALL_URL="https://github.com/sonalisrisivani/harness-structure/archive/refs/heads/main.tar.gz"

echo "🚀 Fetching Claude Code Harness ecosystem..."

TMP_DIR="$(mktemp -d)"
cleanup() {
    rm -rf "$TMP_DIR"
}
trap cleanup EXIT

# Download and extract the repository archive
if command -v curl &>/dev/null; then
    curl -fsSL "$TARBALL_URL" | tar -xz -C "$TMP_DIR"
elif command -v wget &>/dev/null; then
    wget -qO- "$TARBALL_URL" | tar -xz -C "$TMP_DIR"
else
    echo "❌ Error: Neither curl nor wget found in PATH." >&2
    exit 1
fi

EXTRACTED_DIR="${TMP_DIR}/harness-structure-main"

if [ ! -d "$EXTRACTED_DIR" ]; then
    echo "❌ Error: Failed to extract harness repository." >&2
    exit 1
fi

echo "📦 Injecting preset '${PRESET}' into ${TARGET_DIR}..."

# Run the harness manager from the extracted repository
chmod +x "${EXTRACTED_DIR}/scripts/harness.sh"
"${EXTRACTED_DIR}/scripts/harness.sh" apply "$PRESET" "$TARGET_DIR"

# Install harness.sh into target project for ongoing management
mkdir -p "${TARGET_DIR}/scripts"
cp "${EXTRACTED_DIR}/scripts/harness.sh" "${TARGET_DIR}/scripts/harness.sh"
chmod +x "${TARGET_DIR}/scripts/harness.sh"

echo ""
echo "🎉 Setup complete! You can run './scripts/harness.sh doctor' anytime to verify your harness health."

