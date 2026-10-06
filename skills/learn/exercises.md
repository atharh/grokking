# Exercises

One exercise per lesson, about ten minutes, on the workflow or module just walked. It exists
to make the user touch the code they read, so the smallest change that makes the lesson's
point wins over anything useful to ship.

## The ladder

Pick the rung from `## Exercises` in `TOUR.md`: one rung above the last entry, staying on 3
once reached. Start at 1 when the section is empty. Repeat a rung where the user needed the
answer given.

1. **Probe.** You name one edit to a line from the walkthrough: flip a condition, delete a
   callback, swap a call's order, add a log line. The user predicts what changes for the
   program's user and which tests fail, then makes the edit and runs the tests.
2. **Pin.** The user writes one test that pins a behaviour the walkthrough explained. Point
   them at an existing test of the same code to copy its setup. Done when it passes, and
   fails when they break the line it pins.
3. **Extend.** The user adds a small feature to the flow, with a test: one or two files,
   under about twenty lines. Pick one that serves their goal in `TOUR.md`.

## Designing one

- Every file it touches was shown in the walkthrough.
- It exercises the hop the walkthrough leaned on most, one idea per exercise.
- State the task as three lines: the goal, the `path:line` to start from, and the done
  condition (a named test passes, or a named output appears). Give the expected size too,
  in files and lines, so an answer that sprawls tells the user they are off course.
- Write the solution yourself first, on the branch, run it, then revert it. Set only an
  exercise you have seen pass.

## Running it

1. Check that the working tree is clean, then create the branch `tour/<lesson number>-<slug>`.
2. The user writes the code. Hints climb one step per request: the file and line, then the
   method or call to change, then the answer.
3. You run the tests and show the output.
4. Ask whether to keep the branch. Keep: commit on it. Discard: switch back and delete it.
5. Record it under `## Exercises` in `TOUR.md`:
   `- <workflow or module>: rung <n>, <task in one line>, <kept on tour/... or discarded>`.
