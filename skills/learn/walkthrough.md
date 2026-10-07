# Walkthrough layout

Both skills walk code as steps from trigger to result: `explain` in one answer, `learn` one
step per reply. Lay out every step the same way, so the user always knows where to look.

Give a step only to code that decides something. A line that only connects two steps, such
as a route, an include, or a config entry, goes in the next step's title or the previous
step's handoff: "The login form posts to `SessionsController#create` (`config/routes.rb:6`)."

## A step

````markdown
**2. The concern creates the session row and logs the user in.**

```ruby
    def start_new_session_for(user)
      user.sessions.start!(user_agent: request.user_agent, ip_address: request.remote_ip).tap do |session|
        authenticated_as session
      end
    end
```
`app/controllers/concerns/authentication.rb:44-48`

Why it's written this way:
- The session lives in a database row and the cookie carries only its random token, so the
  server records which device and IP each login came from.
- It doesn't cover logout: logout deletes the cookie (`authentication.rb:66`) but not the
  row, so a copied token keeps working.

Handoff: `authenticated_as` sets `Current.user` and writes the token into a signed cookie.
````

1. **Title.** A bold numbered sentence saying what the step does, in plain words. No
   `path:line` in the title.
2. **Excerpt.** The shortest range that holds the step's deciding lines, verbatim, in a
   fenced block with its language. Narrow the range rather than cut lines out of it. `...`
   may join two places in one file only when fewer than ten lines separate them, and the
   caption gives the whole span. Farther apart, give each place its own block and caption.
   Never join two files in one block. Copy the lines from the file you read, never from
   memory, and never join, reflow, or shorten a line.
3. **Caption.** `path:start-end` on its own line under the block.
4. **Why.** The label `Why it's written this way:`, then one reason per bullet: what the
   code rules out, what would break with the obvious alternative, the framework convention
   it leans on. A restatement of what the line says teaches nothing. A step with one short
   reason can give it as a sentence instead. A reason that says the code blocks, limits, or
   protects something also says what it doesn't cover: the other paths that reach the same
   thing without passing this check (search for them), what a limit counts by (per IP, per
   user), and the environments or config where it is off.
5. **Handoff.** One line starting `Handoff:` that names what this step passes to the next
   and how: a method call, a callback, a queued job, a broadcast. The last step has none.

## Around the steps

- The plain answer or orientation comes first, as a paragraph with no label.
- Sections go under `##` headers (`## The path`, `## Two other ways in`), never bold labels
  such as `**The answer:**`.
- A list of the ways into a behavior names every caller of the function they share, found
  with both the language server's find-references and text search, and says how many there
  are.
- A view from [views.md](views.md) earns its place only when it shows what the steps don't:
  branches, several processes, or the order of many files. Don't add one that repeats the
  steps.
