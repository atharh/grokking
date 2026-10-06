# Walkthrough layout

Both skills walk code as steps from trigger to result: `explain` in one answer, `learn` one
step per reply. Lay out every step the same way, so the user always knows where to look.

Give a step only to code that decides something. A line that only connects two steps, such
as a route, an include, or a config entry, goes in the next step's title or the previous
step's handoff: "The login form posts to `SessionsController#create` (`config/routes.rb:6`)."

## A step

````markdown
**2. The concern creates the session row and sets the cookie.**

```ruby
def start_new_session_for(user)
  user.sessions.start!(user_agent: request.user_agent, ip_address: request.remote_ip)
end
```
`app/controllers/concerns/authentication.rb:45-49`

Why it's written this way:
- The session lives in the database, not inside the cookie, so the server can log out one
  device by deleting its row.
- `signed` means the user can read the token but can't forge it.

Handoff: it calls `authenticated_as`, which sets `Current.user`.
````

1. **Title.** A bold numbered sentence saying what the step does, in plain words. No
   `path:line` in the title.
2. **Excerpt.** The shortest range that holds the step's deciding lines, verbatim, in a
   fenced block with its language. Narrow the range rather than cut lines out of it. `...`
   may join two places in one file only when fewer than ten lines separate them, and the
   caption gives the whole span. Farther apart, give each place its own block and caption.
   Never join two files in one block.
3. **Caption.** `path:start-end` on its own line under the block.
4. **Why.** The label `Why it's written this way:`, then one reason per bullet: what the
   code rules out, what would break with the obvious alternative, the framework convention
   it leans on. A restatement of what the line says teaches nothing. A step with one short
   reason can give it as a sentence instead.
5. **Handoff.** One line starting `Handoff:` that names what this step passes to the next
   and how: a method call, a callback, a queued job, a broadcast. The last step has none.

## Around the steps

- The plain answer or orientation comes first, as a paragraph with no label.
- Sections go under `##` headers (`## The path`, `## Two other ways in`), never bold labels
  such as `**The answer:**`.
- A view from [views.md](views.md) earns its place only when it shows what the steps don't:
  branches, several processes, or the order of many files. Don't add one that repeats the
  steps.
