#!/usr/bin/env python3
"""
cc-sessions — Fast CLI to search, browse & resume Claude Code session history

OVERVIEW
--------
Claude Code stores all conversation history locally in ~/.claude/projects/ as JSONL files.
This tool indexes those sessions for fast search and provides a clean CLI interface to:
  - Search by keyword across all conversations
  - Filter by date, branch, or project
  - View recent sessions
  - Resume past sessions with partial ID matching

FEATURES
--------
- ⚡ Incremental indexing: ~200ms search on 1300+ sessions (vs ~5s full scan)
- 📁 Project-scoped by default: auto-detects current project from pwd
- 🔍 Powerful filters: --since 7d, --branch develop, --limit N
- 🎯 Partial ID matching: 'cc-sessions resume 8d472d' finds full session ID
- 🌳 Worktree support: includes git worktree sessions automatically
- 📊 JSON output: pipe to jq/fzf for advanced workflows
- 🐍 Zero dependencies: Python stdlib only (json, argparse, pathlib)

USAGE
-----
# Search in current project
cc-sessions search "notion"

# Search all projects
cc-sessions --all search "stripe"

# Filter by date and branch
cc-sessions search "auth" --since 7d --branch develop --limit 5

# Recent sessions
cc-sessions recent 10

# Session details (partial ID match)
cc-sessions info 8d472d2c

# Resume session (execs: claude --resume <full-id>)
cc-sessions resume 8d472d2c

# Force rebuild index
cc-sessions reindex

# JSON output for composition
cc-sessions --json search "prisma" | jq -r '.[].id'

INSTALLATION
------------
1. Save this script to ~/bin/cc-sessions
2. chmod +x ~/bin/cc-sessions
3. Run: cc-sessions recent 5
   (First run builds index ~10s for 1500 sessions, then <200ms)

INDEX ARCHITECTURE
------------------
- Location: ~/.claude/sessions-index.jsonl (~360KB for 1300 sessions)
- Format: One JSON object per line with session metadata
- Update strategy: Incremental (only re-parses modified files)
- Rebuild: Automatic on search/recent, manual with 'reindex'

Session metadata extracted:
  - id: Full session UUID
  - project: Encoded project path
  - branch: Git branch from JSONL gitBranch field
  - context: First significant user message (60 chars)
  - timestamp: ISO 8601 datetime
  - mtime: File modification time (for incremental updates)

FILTERING RULES
---------------
Significant user message = all 3 conditions:
  1. entry['type'] == 'user'
  2. content is string (not array = tool_result)
  3. content doesn't start with '<' (excludes XML internal tags)

This covers all current and future Claude Code internal messages:
  - <command-name>, <command-message>, <local-command-stdout>
  - <bash-input>, <bash-stdout>, <task-notification>
  - Any future XML-formatted system messages

Subagent sessions (prefix 'agent-') are excluded by default.

PERFORMANCE
-----------
- First run (build index): ~10s for 1500 sessions
- Subsequent searches: ~200ms (reads index)
- Incremental rebuild: <1s if no changes
- Index size: ~280 bytes per session

OUTPUT FORMAT
-------------
2026-02-05 17:15  8d472d2c-128b-4d9b-824d-3944e3409984  develop   "Migration Support Slack → Notion..."
│                 │                                     │         │
Date/Time         Full Session ID (for --resume)      Branch    First user message (60 chars)

ECOSYSTEM
---------
Similar tools:
  - claude-history (Rust): Fuzzy search with fzf
  - cclog (Go): JSONL → HTML/Markdown + TUI
  - claude-code-history-viewer (Tauri): Desktop GUI
  - fast-resume (Rust): Tantivy index + TUI

cc-sessions positioning: Unix-style CLI, fast search, powerful filters, no dependencies.

AUTHOR
------
Created for terminal power users who prefer CLI over GUI.
Gist: https://gist.github.com/FlorianBruniaux/992d4d1107592d9e98ca9d89838871c6
"""

import argparse
import json
import os
import sys
from datetime import datetime, timedelta
from pathlib import Path
from typing import Dict, List, Optional

CLAUDE_DIR = Path.home() / ".claude"
INDEX_PATH = CLAUDE_DIR / "sessions-index.jsonl"


def parse_duration(duration_str: str) -> datetime:
    """Parse duration string like '7d', '30d' or ISO date."""
    if duration_str.endswith('d'):
        days = int(duration_str[:-1])
        return datetime.now() - timedelta(days=days)
    return datetime.fromisoformat(duration_str)


def encode_project_path(path: Path) -> str:
    """Encode project path to match Claude's format."""
    return str(path).replace('/', '-')  # Keep leading - from root /


def detect_project() -> Optional[str]:
    """Detect current project from pwd."""
    pwd = Path.cwd()
    encoded = encode_project_path(pwd)
    project_dir = CLAUDE_DIR / "projects" / encoded

    if not project_dir.exists():
        return None
    return encoded


def get_project_dirs(all_projects: bool = False) -> List[Path]:
    """Get project directories to scan."""
    if all_projects:
        projects_dir = CLAUDE_DIR / "projects"
        if not projects_dir.exists():
            return []
        return [d for d in projects_dir.iterdir() if d.is_dir()]

    current = detect_project()
    if not current:
        return []

    dirs = []
    base = CLAUDE_DIR / "projects" / current
    dirs.append(base)

    # Include worktrees (glob pattern: --worktrees*)
    worktrees = list(base.parent.glob(f"{current}--worktrees*"))
    dirs.extend(worktrees)

    return dirs


def get_first_user_message(filepath: Path) -> Optional[str]:
    """Extract first significant user message from session JSONL."""
    try:
        with open(filepath, 'r') as f:
            for line in f:
                if not line.strip():
                    continue
                try:
                    entry = json.loads(line)

                    # Rule 1: Must be user message
                    if entry.get('type') != 'user':
                        continue

                    content = entry.get('message', {}).get('content', '')

                    # Rule 2: Must be string (not array = tool_result)
                    if not isinstance(content, str):
                        continue

                    # Rule 3: Not internal XML message
                    if content.startswith('<'):
                        continue

                    # Found significant user message
                    return content[:60].replace('\n', ' ')
                except json.JSONDecodeError:
                    continue
    except Exception:
        pass
    return None


def parse_session(filepath: Path) -> Optional[Dict]:
    """Extract session metadata."""
    session_id = filepath.stem

    # Skip subagent sessions
    if session_id.startswith('agent-'):
        return None

    mtime = filepath.stat().st_mtime
    context = get_first_user_message(filepath)

    if not context:
        return None

    # Extract branch from gitBranch field in JSONL
    branch = "unknown"
    try:
        with open(filepath, 'r') as f:
            for line in f:
                if not line.strip():
                    continue
                try:
                    entry = json.loads(line)
                    git_branch = entry.get('gitBranch')
                    if git_branch:
                        branch = git_branch
                        break
                except json.JSONDecodeError:
                    continue
    except Exception:
        pass

    project = filepath.parent.name

    return {
        "id": session_id,
        "project": project,
        "mtime": mtime,
        "branch": branch,
        "context": context,
        "timestamp": datetime.fromtimestamp(mtime).isoformat()
    }


def build_index(project_dirs: List[Path], existing_index: Dict[str, Dict]) -> Dict[str, Dict]:
    """Build or update index incrementally."""
    index = existing_index.copy()

    for project_dir in project_dirs:
        jsonl_files = list(project_dir.glob("*.jsonl"))

        for filepath in jsonl_files:
            session_id = filepath.stem
            file_mtime = filepath.stat().st_mtime

            # Skip if already indexed and not modified
            if session_id in index and index[session_id]['mtime'] >= file_mtime:
                continue

            # Parse session
            session = parse_session(filepath)
            if session:
                index[session_id] = session

    return index


def load_index() -> Dict[str, Dict]:
    """Load existing index."""
    if not INDEX_PATH.exists():
        return {}

    index = {}
    try:
        with open(INDEX_PATH, 'r') as f:
            for line in f:
                if not line.strip():
                    continue
                entry = json.loads(line)
                index[entry['id']] = entry
    except Exception as e:
        print(f"Warning: Failed to load index: {e}", file=sys.stderr)
        return {}

    return index


def save_index(index: Dict[str, Dict]):
    """Save index to disk."""
    CLAUDE_DIR.mkdir(exist_ok=True)

    with open(INDEX_PATH, 'w') as f:
        for entry in index.values():
            f.write(json.dumps(entry) + '\n')


def cmd_search(keyword: str, project_dirs: List[Path], limit: int = 10,
               since: Optional[str] = None, branch: Optional[str] = None,
               json_output: bool = False):
    """Search sessions by keyword."""
    # Build/update index
    existing = load_index()
    index = build_index(project_dirs, existing)
    save_index(index)

    # Filter
    matches = []
    since_dt = parse_duration(since) if since else None

    for entry in index.values():
        # Filter by project
        if not any(entry['project'] == d.name for d in project_dirs):
            continue

        # Filter by keyword (case-insensitive in context)
        if keyword.lower() not in entry['context'].lower():
            continue

        # Filter by date
        if since_dt:
            entry_dt = datetime.fromisoformat(entry['timestamp'])
            if entry_dt < since_dt:
                continue

        # Filter by branch
        if branch and entry['branch'] != branch:
            continue

        matches.append(entry)

    # Sort by timestamp desc
    matches.sort(key=lambda x: x['timestamp'], reverse=True)
    matches = matches[:limit]

    # Output
    if json_output:
        print(json.dumps(matches, indent=2))
    else:
        for m in matches:
            dt = datetime.fromisoformat(m['timestamp'])
            print(f"{dt.strftime('%Y-%m-%d %H:%M')}  {m['id']}  {m['branch']:12}  \"{m['context']}\"")


def cmd_recent(project_dirs: List[Path], limit: int = 10, json_output: bool = False):
    """Show recent sessions."""
    # Build/update index
    existing = load_index()
    index = build_index(project_dirs, existing)
    save_index(index)

    # Filter by project
    sessions = [e for e in index.values()
                if any(e['project'] == d.name for d in project_dirs)]

    # Sort by timestamp desc
    sessions.sort(key=lambda x: x['timestamp'], reverse=True)
    sessions = sessions[:limit]

    # Output
    if json_output:
        print(json.dumps(sessions, indent=2))
    else:
        for s in sessions:
            dt = datetime.fromisoformat(s['timestamp'])
            print(f"{dt.strftime('%Y-%m-%d %H:%M')}  {s['id']}  {s['branch']:12}  \"{s['context']}\"")


def cmd_info(session_id: str):
    """Show session details."""
    # Match partial ID
    index = load_index()

    matches = [s for s in index.values() if s['id'].startswith(session_id)]

    if not matches:
        print(f"Error: Session not found: {session_id}", file=sys.stderr)
        sys.exit(1)

    if len(matches) > 1:
        print(f"Error: Ambiguous ID, multiple matches:", file=sys.stderr)
        for m in matches:
            print(f"  {m['id']}", file=sys.stderr)
        sys.exit(1)

    session = matches[0]
    dt = datetime.fromisoformat(session['timestamp'])

    print(f"Session: {session['id']}")
    print(f"Date:    {dt.strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"Project: {session['project']}")
    print(f"Branch:  {session['branch']}")
    print(f"Context: {session['context']}")


def cmd_resume(session_id: str):
    """Resume a session."""
    # Match partial ID
    index = load_index()

    matches = [s for s in index.values() if s['id'].startswith(session_id)]

    if not matches:
        print(f"Error: Session not found: {session_id}", file=sys.stderr)
        sys.exit(1)

    if len(matches) > 1:
        print(f"Error: Ambiguous ID, multiple matches:", file=sys.stderr)
        for m in matches:
            print(f"  {m['id']}", file=sys.stderr)
        sys.exit(1)

    full_id = matches[0]['id']

    # exec claude --resume
    os.execvp('claude', ['claude', '--resume', full_id])


def cmd_reindex():
    """Force rebuild of entire index."""
    print("Rebuilding index...", file=sys.stderr)

    projects_dir = CLAUDE_DIR / "projects"
    if not projects_dir.exists():
        print("Error: No projects directory found", file=sys.stderr)
        sys.exit(1)

    all_dirs = [d for d in projects_dir.iterdir() if d.is_dir()]

    index = build_index(all_dirs, {})
    save_index(index)

    print(f"Indexed {len(index)} sessions", file=sys.stderr)


def main():
    parser = argparse.ArgumentParser(description="Search Claude Code session history")
    parser.add_argument('--all', action='store_true', help="Search all projects")
    parser.add_argument('--json', action='store_true', help="JSON output")

    subparsers = parser.add_subparsers(dest='command', required=True)

    # search
    search_parser = subparsers.add_parser('search', help="Search sessions by keyword")
    search_parser.add_argument('keyword', help="Search keyword")
    search_parser.add_argument('--limit', type=int, default=10, help="Max results")
    search_parser.add_argument('--since', help="Filter by date (7d, 30d, or ISO date)")
    search_parser.add_argument('--branch', help="Filter by git branch")

    # recent
    recent_parser = subparsers.add_parser('recent', help="Show recent sessions")
    recent_parser.add_argument('limit', nargs='?', type=int, default=10, help="Number of sessions")

    # info
    info_parser = subparsers.add_parser('info', help="Show session details")
    info_parser.add_argument('session_id', help="Session ID (partial match)")

    # resume
    resume_parser = subparsers.add_parser('resume', help="Resume a session")
    resume_parser.add_argument('session_id', help="Session ID (partial match)")

    # reindex
    subparsers.add_parser('reindex', help="Force rebuild index")

    args = parser.parse_args()

    # Get project dirs
    if args.command in ['search', 'recent']:
        project_dirs = get_project_dirs(args.all)

        if not project_dirs:
            if args.all:
                print("Error: No projects found", file=sys.stderr)
            else:
                print("Error: Not in a Claude project directory", file=sys.stderr)
                print("Hint: Use --all to search all projects", file=sys.stderr)
            sys.exit(1)

    # Execute command
    if args.command == 'search':
        cmd_search(args.keyword, project_dirs, args.limit, args.since, args.branch, args.json)
    elif args.command == 'recent':
        cmd_recent(project_dirs, args.limit, args.json)
    elif args.command == 'info':
        cmd_info(args.session_id)
    elif args.command == 'resume':
        cmd_resume(args.session_id)
    elif args.command == 'reindex':
        cmd_reindex()


if __name__ == '__main__':
    main()
