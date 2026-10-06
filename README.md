# grokking

Claude Code skills for understanding an unfamiliar codebase.

| Skill | How it starts | What it does |
|---|---|---|
| `explain` | On its own, when you ask how code works | Answers from the code: a short answer first, then quoted excerpts with `path:line`, why each piece is written that way, and one line on the search that found it, so you learn to navigate the code yourself |
| `learn` | You run `/grokking:learn` | One lesson per session on one core workflow: a commented walkthrough, what-if questions settled by running the code, and a small hands-on exercise. Progress carries over in `TOUR.md` |

Ask `explain` things like "how does login work?", "where are emails sent?", "what happens if
the user isn't signed in?", or "where do I start in this repo?".

Run `/grokking:learn` to start lessons, or `/grokking:learn <module>` for a lesson on one
module. The first run surveys the repo and writes `TOUR.md` at its root, after asking whether git should ignore it in every repo or
only this one.

## Install

Add the marketplace, then install the plugin from it, from inside a Claude Code session or
from your shell.

**In Claude Code:**

```
/plugin marketplace add atharh/grokking
/plugin install grokking@grokking
```

**From the shell:**

```bash
claude plugin marketplace add atharh/grokking
claude plugin install grokking@grokking
```

If the install summary says `Run /reload-plugins to activate.`, run that.

<details>
<summary>Or: install from a clone, without the marketplace</summary>

```bash
git clone https://github.com/atharh/grokking ~/grokking
cd ~/grokking
./install.sh
```

`install.sh` symlinks the repo into `~/.claude/skills/grokking`, where Claude Code picks it
up as a plugin. Updating is `git pull` in the clone, then `/reload-plugins` or a restart.
Don't use both paths at once: two plugins named `grokking` would provide the same skills.

</details>

## Recommended tools

The skills work without these, but they find better evidence with them.

- **A language server plugin** for the repo's language, installed from `/plugin`. The
  skills use its find-references to rank core areas and to trace callers. Without one, they
  fall back to `ast-grep` or `rg`, which match text and miss indirect calls.
- **`rg`** (ripgrep): fast text search for import and call sites.
- **`ast-grep`**: syntax-aware search for call sites.
- **`scc`**: lines of code per directory, used to size core areas. Without it, the survey
  counts lines with `git ls-files | xargs wc -l`.

```bash
brew install ripgrep ast-grep scc
```

On other systems, follow each tool's own install instructions.

## Updating later

The marketplace is a git clone of this repo: refreshing it pulls new commits, and updating
the plugin then installs from the refreshed clone. Both steps are needed.

**In Claude Code:**

```
/plugin marketplace update grokking
```

Then open `/plugin`, select `grokking`, and choose **Update now**.

**From the shell:**

```bash
claude plugin marketplace update grokking
claude plugin update grokking@grokking
```

Restart Claude Code, or run `/reload-plugins`, to load the new version. `claude plugin list`
shows what you're on.

## License

MIT. `skills/learn/views.md` is adapted from HumanLayer's
[`show-me` skill](https://github.com/humanlayer/skills) under the MIT License; see
`skills/learn/LICENSE-show-me`.
