# CLAUDE.md

Public repo: the Grokking plugin for Claude Code. Every directory under `skills/` is one
skill. Keep it free of anything about one person's setup or working style.

Check a change with `claude plugin validate .` from the repo root.

## Versioning

Bump `version` in `.claude-plugin/plugin.json` on every user-visible change: skill
behaviour, README instructions, install steps. Installs are cached at
`~/.claude/plugins/cache/grokking/grokking/<version>/`, and `version` is the only signal
users see in `/plugin`, so an unchanged version makes an update look like nothing shipped.

Semver: patch for wording and fixes, minor for new skills or new behaviour, major for a
change that breaks an existing `TOUR.md`.
