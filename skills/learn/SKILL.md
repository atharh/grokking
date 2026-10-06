---
name: learn
description: Teach how an unfamiliar codebase works, one core workflow per session: a commented walkthrough of the code, what-if questions about it, and a small hands-on exercise. Progress carries over between sessions in TOUR.md.
disable-model-invocation: true
---

# Learn a codebase

The user runs `/grokking:learn` in a repo when they want to understand it. The lessons live
in the conversation: every question is asked and answered in the chat, while the user is
paying attention. The only file is the tour state, `TOUR.md` at the repo root, written for
you, the next session's Claude, never for the user to read.

Keep `TOUR.md` out of commits. Before creating it, run `git check-ignore -q TOUR.md`. If git
doesn't already ignore it, ask the user once which they want:

- **Ignore it in every repo** (recommended, since lessons can run in any repo): add `TOUR.md`
  to the global excludes file, the path in `git config --global core.excludesFile`, or
  `~/.config/git/ignore` when that is unset.
- **Ignore it in this repo only:** add `TOUR.md` to `.git/info/exclude`.

Trace code as the explain skill's [Before answering](../explain/SKILL.md#before-answering)
says: the language server first, text search only for what it can't resolve.

Three rules govern every step:

- **Keep the useful struggle.** Explain, then ask. Don't hand over an answer the user can
  reason out from code they have seen.
- **Early wins.** Each session ends with something the user did themselves: an answer they
  got right, a test they ran, an edit that worked.
- **Change the mode when a session drags.** Move to the exercise early rather than adding
  more explanation.

## Start

Read `TOUR.md`, then pick the session's lesson:

- **Missing:** run the survey, then lesson 1.
- **The user named a module** (`/grokking:learn <module>`): the module lesson for it, after
  the survey if `TOUR.md` was missing.
- **A workflow is unticked:** the lesson for the first unticked workflow.
- **Every workflow ticked, a core area unticked:** the module lesson for the first unticked
  core area.
- **Everything ticked:** the capstone.

Open with the warm-up whenever `## Misses` has entries. When the lesson starts, after any
survey, name a stop time as a clock time 45 minutes away, and say so when it passes.

## Survey

1. Ask the user one question: what do they want this codebase for (to change it, review it,
   debug it, or just know it)?
2. Explore the repo yourself: README, entry points, the build or run command, the directory
   layout, the tests. Dispatch an Explore subagent for a large repo. Run the program or its
   tests when they finish in under a minute, so the lessons can show real output.
3. Find the **core areas**: the modules the rest of the code depends on. Rank them by
   evidence, not by reading alone:
   - how many files import or call each module: the language server's find-references when
     one is available, otherwise `ast-grep` or `rg` for its import and call sites
   - how big it is: `scc` per directory, or `git ls-files <dir> | xargs wc -l` when `scc`
     isn't installed
   - how often it changed in the last year:
     `git log --since=1.year --format= --name-only | cut -d/ -f1-2 | sort | uniq -c | sort -rn`
   - what the entry points call, and what the tests exercise most
4. Write `TOUR.md` in this shape:

   ```markdown
   # Tour: <repo>

   Goal: <the user's answer>
   Purpose: <one sentence: what the program does for its user>
   Run: <the command that runs it or its tests>

   ## Core areas
   - [ ] <module path>: <what it owns, one line> (<evidence: importers, changes>)

   ## Workflows
   1. [ ] <name>: <trigger, as the user sees it> → <entry path:line> → <where it ends>
   2. [ ] ...

   ## Exercises

   ## Misses
   ```

   Order the workflows by the user's goal first, then smaller before larger, then by how many
   core areas they pass through. Done when the map lists three to five core areas with their
   evidence, and three to five workflows, each traced to a real entry point you opened.
5. Show the user the purpose line, the core area names, and the workflow names. If no
   language server was available for the repo's main language, add one line saying so and
   what it cost: "No language server for <language>, so the caller counts come from text
   search and can miss indirect calls. The plugin's README, under Recommended tools, says
   how to install one." Show nothing more, and start the lesson Start chose.

## Lesson

One workflow per session. You explain first; the user answers after they have seen the code.

1. **Orient.** Say in one sentence what the workflow does from the user's side. Run it, or
   the tests that cover it, and show the real output.
2. **Picture.** Before any code, show the whole path in one view from [views.md](views.md),
   with `path:line` on each node. It is the map the user follows through the walkthrough.
3. **Walkthrough.** A commentary on the path, in the style of Lions' *Commentary on UNIX*:
   three to six hops from trigger to end. Lay out each hop as a step in
   [walkthrough.md](walkthrough.md): title, excerpt, caption, why, handoff.

   Show exactly one hop per reply, kept to one screen, and show the next hop only when the
   user says so ("next" or the like). Answering a question, or anything else the user does in
   between, leaves the walkthrough on the same hop; after answering, offer to continue that
   hop. End the walkthrough by asking whether anything is unclear before the questions.
4. **What-if.** Four questions, one at a time, waiting for the answer each time:
   - Explain the workflow back in three sentences.
   - A condition flips: a guard fails, a record is missing, the user lacks access.
   - A line moves or goes: a callback runs earlier, a validation is dropped.
   - Two things happen at once or something fails midway: two browsers, a job that raises.

   Settle each answer by running the code: a test, a one-line script, or a temporary edit,
   reverted after. When it can't be run, say so and show the line that decides it. A wrong
   answer gets one second look at that code, then the question again. If it is still wrong,
   give the answer and add a miss.
5. **Exercise.** One hands-on exercise on this workflow, from [exercises.md](exercises.md).
6. **Close.** Tick the workflow in `TOUR.md`, record the exercise under `## Exercises`
   (adding the section if it is missing), then say in one line what the next lesson is.

When the user says "just tell me", give one hint first; give the answer if they ask again.

Never teach a guess about the code as fact; open the code first.

## Module lesson

The lesson above, aimed at one module instead of one workflow:

- **Orient** names what the module owns and who calls it, with the count of its callers.
- **Picture** shows its main types and how they relate, when the module defines the core
  types of the domain; otherwise a call tree of its callers.
- **Walkthrough** covers its public functions and types, three to six of them, most-called
  first, each with its excerpt, its why, and one real caller.
- **What-if** asks what the module is responsible for, then what breaks if one of its
  functions changes, then two condition or failure questions.
- **Exercise** targets one of the functions walked.
- **Close** ticks the module under `## Core areas`, adding it there first if it was missing.

## Misses

Only What-if questions still answered wrong after the second look become misses. Write each
as `- <question as asked> → <answer, path:line>`. Keep at most ten; past ten, drop the
oldest.

## Warm-up

Ask the oldest miss. A correct answer removes it. A wrong one gets a one-line correction
and stays. Then the lesson starts.

## Capstone

Ask the user to explain the whole system in five sentences: what it is for, its core areas,
its main workflows, and how they connect. Correct it once, then show one view of the whole
system from [views.md](views.md). The tour is done; tell the user `TOUR.md` can be deleted.
