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

```sh
claude plugin marketplace add atharh/grokking
claude plugin install grokking@grokking
```

Then start a new Claude Code session. Update later with `claude plugin update grokking`.

## License

MIT. `skills/learn/views.md` is adapted from HumanLayer's
[`show-me` skill](https://github.com/humanlayer/skills) under the MIT License; see
`skills/learn/LICENSE-show-me`.
