#!/usr/bin/env bash
set -euo pipefail

# Installs Grokking without going through a plugin marketplace, by symlinking this
# repo into your Claude Code skills directory. Claude Code loads any folder there
# that contains .claude-plugin/plugin.json as a plugin — here, `grokking@skills-dir`
# — so a later `git pull` updates it automatically.
#
# The marketplace install (see README) is the recommended path. Use this one if
# you'd rather track the repo directly. Don't use both: two plugins named
# grokking would provide the same /grokking:* skills.
#
# Override the destination with CLAUDE_SKILLS_DIR=/path ./install.sh

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
LINK="$DEST/grokking"

mkdir -p "$DEST"

if [ -L "$LINK" ]; then
  echo "already linked: $LINK -> $(readlink "$LINK")"
elif [ -e "$LINK" ]; then
  echo "skip: $LINK exists and is not a symlink — remove it first to reinstall" >&2
  exit 1
else
  ln -s "$REPO_DIR" "$LINK"
  echo "linked: $LINK -> $REPO_DIR"
fi

cat <<'EOF'

Done. Start a new Claude Code session to pick up the plugin.

  Ask how code works ("how does login work here?")  explain answers on its own
  /grokking:learn                                    a lesson on one workflow
  /grokking:learn <module>                           a lesson on one module
EOF
