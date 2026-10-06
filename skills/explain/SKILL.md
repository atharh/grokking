---
name: explain
description: Answer questions about how a codebase works from the code itself, with quoted excerpts, the reason behind each piece, and the search that found it, so the user also learns to navigate code. Use when the user asks how something works in this repo, where something lives or is handled, what happens when an action runs, why code is written a certain way, what would happen if something changed, or where to start in an unfamiliar repo. Not for a structured course through the repo, which is /grokking:learn.
---

# Explain code

The user asks about code in plain words, often without knowing which file or term to ask
about. Answer from the code, show where the answer came from, and show how you found it, so
each answer also teaches them one way to navigate a codebase.

This skill writes no files and keeps no state. Each question is answered on its own.

## Before answering

Open the code that decides the answer. Never answer from a file name, a function name, or
how the framework usually works. When a part of the answer could not be checked (code
outside the repo, behavior that depends on config or data you can't see), label that part
as a guess and name what would settle it.

Read for intent: "the save thing" or "where it sends the mail" names a behavior, not a
symbol. Find the code by what the user sees first: a route, a button label, a CLI flag, an
error message, a log line. Then follow calls inward.

Follow calls with the language server whenever one is available: go-to-definition to open
what a name refers to, and find-references for its callers. In Claude Code that is the
`LSP` tool; load it with ToolSearch when it is deferred. It resolves names the way the
compiler does, so it finds calls through imports, aliases and interfaces that text search
misses, and it opens methods defined in dependencies. Use `rg` or `ast-grep` only for text
the language server can't resolve: route strings, config keys, error messages, names built
at runtime. A method from a dependency is read from its source, through go-to-definition or
in the installed package, never explained from memory.

## Answer shape

Lay the answer out as the learn skill's [walkthrough.md](../learn/walkthrough.md) says:
the step format, `##` headers, and when a view earns its place.

1. **The answer**, in one or two plain sentences, before any code, with no label.
2. **The path**, under `## The path`, when the answer spans more than one place: the steps
   from trigger to result, at most one screen per reply. When the path doesn't fit one
   screen, show the first steps and offer the rest. Stop at what the user asked; don't
   widen into the surrounding system.
3. **A view**, only when walkthrough.md says it earns its place: one view from the learn
   skill's [views.md](../learn/views.md), with `path:line` on each node.
4. **How I found it**, one line naming the search, in a form the user could repeat: "I
   searched for the route `/messages`, opened its controller, then followed
   `broadcast_create`." Name the tool when it matters: the language server's
   go-to-definition or find-references, `rg`, `git log -S`.

For "where is X", the answer is the location plus its main callers.

## What-if questions

Settle "what happens if" by running something: a test, a one-line script, or a temporary
edit reverted after. Show the output. When it can't be run, say so and show the line that
decides it.

## Where to start

When the user doesn't know where to start, give a map in one reply, without writing files:

- what the program does for its user, in one sentence
- the command that runs it or its tests
- three to five core modules, ranked by evidence (importers, size, changes in the last
  year), gathered as in the learn skill's [Survey](../learn/SKILL.md#survey) step 3, each
  with one line on what it owns
- the entry points, as `path:line`

Then ask which behavior the user wants to follow first.

## Suggesting the lessons

When the user's questions keep returning to the same workflow or module, suggest
`/grokking:learn` once in the session: it teaches one workflow at a time and checks
understanding with questions and an exercise. Don't suggest it again after the user
declines or ignores it.
