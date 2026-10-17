# Views

Pick the smallest view that makes the point, and place it next to the sentence it supports.
Show only the calls, files, and boundaries the current workflow or question needs.

Adapted from HumanLayer's
[`show-me` skill](https://github.com/humanlayer/skills/blob/main/plugins/show-me/skills/show-me/SKILL.md),
MIT License, Copyright (c) 2026 HumanLayer. Full text in [LICENSE-show-me](LICENSE-show-me).

- **Call tree** for runtime control flow, with `path:line` on the entry:

  ```text
  submitForm (src/form.ts:42)
    createSession
      persistPrompt
      launchAgent
    navigateToSession
  ```

- **Mermaid sequence diagram** when the workflow crosses processes, services, or the
  network:

  ```mermaid
  sequenceDiagram
      participant CLI
      participant Server
      participant DB
      CLI->>Server: POST /jobs
      Server->>DB: insert job
      Server-->>CLI: job id
  ```

  The terminal shows Mermaid as source text, so render it: write a self-contained HTML page
  to the scratchpad directory with the diagram in `<pre class="mermaid">` and this script,
  then give the user the command to open it in a browser:

  ```html
  <script type="module">
    import mermaid from "https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs";
    mermaid.initialize({ startOnLoad: true });
  </script>
  ```

  Plain-text views (call tree, file tree, pseudocode) stay inline in the terminal.

- **Shallow file tree** for which directory owns what, one comment per line:

  ```text
  src/
  ├── commands/   # parses user actions
  ├── sessions/   # owns session state
  └── transport/  # sends API requests
  ```

- **Pseudocode** for the logic inside one function, when the real code hides it under
  error handling or plumbing:

  ```text
  on(save)
    if content is unchanged
      return cached result
    write new content
  ```

- **Component tree** for UI code, with the state and module boundaries that matter.

- **Diff of a shape** for the check question "where would you change it": show the call
  tree or file tree with `+` and `-` lines for the change.

- **One HTML page** only when the concept is too dense for Mermaid, such as a state machine
  with many states or a data model with many tables. Write it to the scratchpad directory and
  give the user the command to open it in a browser.
