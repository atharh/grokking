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

### A language server for the repo's language

The skills run every lookup through both the language server and text search, then check each
result against the code. The language server is the one that opens methods defined in
your dependencies, so the skills read that source instead of explaining it from memory. In
code with static types, its find-references also follows calls through imports, aliases
and interfaces that text search misses. The skills say at the start of a session when no
language server is available.

A language server takes two installs:

1. The language server itself, a program on your `PATH`.
2. The Claude Code plugin that tells Claude Code how to start it, from the official
   marketplace: `/plugin install <plugin>@claude-plugins-official`.

The plugin alone does nothing if the server isn't installed.

| Language | Install the server | Plugin |
|---|---|---|
| Python | `npm install -g pyright` or `pip install pyright` | [`pyright-lsp`](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/pyright-lsp) |
| TypeScript, JavaScript | `npm install -g typescript-language-server typescript` | [`typescript-lsp`](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/typescript-lsp) |
| Go | `go install golang.org/x/tools/gopls@latest`, with `$HOME/go/bin` on your `PATH` | [`gopls-lsp`](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/gopls-lsp) |
| Rust | `rustup component add rust-analyzer` | [`rust-analyzer-lsp`](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/rust-analyzer-lsp) |
| Ruby | `gem install ruby-lsp` | [`ruby-lsp`](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/ruby-lsp) |
| Java | `brew install jdtls` | [`jdtls-lsp`](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/jdtls-lsp) |
| Kotlin | `brew install JetBrains/utils/kotlin-lsp` | [`kotlin-lsp`](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/kotlin-lsp) |

Each plugin's page has install steps for other systems. The same marketplace also has
plugins for C and C++, C#, Lua, PHP and Swift. Restart Claude Code after installing, so
the plugin starts the server.

### Search and size tools

- **`ast-grep`**: searches code by its syntax, so a search for calls to `send` skips
  comments, strings and variables named `send`.
- **`scc`**: counts lines of code per directory, to size the core areas. Without it, the
  survey counts lines with `git ls-files | xargs wc -l`.
- **`rg`** (ripgrep): optional. Inside Claude Code, text search already skips gitignored
  and binary files, through the Grep tool or the `grep` that Claude Code builds into its
  shell. Install `rg` to rerun the searches the skills show you in your own terminal.

```bash
brew install ast-grep scc ripgrep
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
