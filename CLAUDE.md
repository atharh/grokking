# CLAUDE.md

Public repo: the Grokking plugin for Claude Code. Every directory under `skills/` is one
skill. `shared/` holds the files both skills follow (answer layout and diagrams), so an edit
there changes both. Keep it free of anything about one person's setup or working style.

Check a change with `claude plugin validate .` from the repo root.

## Versioning

Bump `version` in `.claude-plugin/plugin.json` on every user-visible change: skill
behaviour, README instructions, install steps. Installs are cached at
`~/.claude/plugins/cache/grokking/grokking/<version>/`, and `version` is the only signal
users see in `/plugin`, so an unchanged version makes an update look like nothing shipped.

Semver: patch for wording and fixes, minor for new skills or new behaviour, major for a
change that breaks an existing `TOUR.md`.

## Backlog

This repo's settings for the shared `backlog` skill. Where this section and the skill
disagree, this section wins.

- **Files.** `BACKLOG.md`, `LEDGER.md` and `DECISIONS.md`, all at the root. GitHub issues
  are not used as a queue.
- **Grouping.** By blocker: a decision, a test run in another repo, another item.
- **Line cap.** None.
- **Landed format.** The default one-line entry, with the plugin `version` it shipped in
  when the change bumped it.
- **Verification.** `claude plugin validate .` passes, and for a skill change, one run of
  the changed skill on a real repo, named in the entry.
