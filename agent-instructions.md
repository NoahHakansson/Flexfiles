I'm Noah, Im a software enginner and you're my agent. We will be working together a lot, so I thought it would be worth introducing myself.

I love to build. I focus on building complex things as simple as possible. I love to find ways to reduce complexity when solving problems.

I wanted to share some of my preferences here so we can be more aligned as we work together.

## Coding preferences - general

- Keep things simple. Channel "yagni" energy unless told otherwise.
- Keep to the style and coding standards of the project you are working in.
- Typesafety is useful, take advantage of it.
- Write self describing code that need minimal comments
- Don't be scared to propose bold ideas if they can meaningfully benefit our work.
- Be careful with destructive actions that are not explicitly requested by the user.
- Tests are good! Endless smoke tests, "regression tests" for feature deletions, etc, much less good. Tests should be focused, not slop.
- Comments are a great way to clarify functionality and how code is used. Don't comment every line, but feel free to describe (concisely) how functions are used above function definitions, classes, etc.
- Keep comments up to date! When making changes, it's important to keep things in sync.
- Keep docs to up to date but don't add unnecessary bloat and slop, be precise and keep changes surgical and minimal as much as possible unless major changes are needed.

## Coding preferences (GO focused)
- Write idiomatic GO.
- Prefer using the standard library instead of pulling in unnecessary dependencies.

## Coding preferences (Typescript focused)

- `any` is the enemy. Inferred types are our friend. Our systems should adapt to changes, instead of requiring changes everywhere.
- If your TS code looks like a Python dev wrote it, it is bad TS code.
- Avoid one-line functions that are just casting wrappers.
- Write TypeScript in ways that Matt Pocock would be proud of.

## Questions are read-only

- A question is a request for an answer, not for changes. If the message opens with "how hard would it be", "what are your thoughts", "why does", "should we", "is it possible", "can X do Y", or otherwise asks rather than instructs: answer it, and do not edit files.
- If the answer is obvious and the change is trivial, still answer first and offer the change. Ask before making it.

## Match ceremony to the task

- Do not spawn subagents or a multi-agent panel for work a single agent finishes in one pass. Delegation is for breadth or adversarial review, not for ordinary tasks.
- When several agents do work in parallel, state file ownership up front so they do not collide.

## Visual and design work

- Do not edit real components first. For any non-trivial UI, layout, or copy change, build several distinct static mocks, create a HTML file for this and report the path to it and stop. Wait for a pick before implementing.
- Standing constraints: dark mode, true black (`#000`) background, white primary text. Information-dense, no decorative card/pill chrome, no light-gray subtitle lines above sections. Minimal copy. No em dashes.
- Avoid continuously repainting CSS animations (pulse, shimmer, blur, spinners); they peg the GPU on high-refresh displays.

## Blast radius

- Never touch production, live databases, or daily-driver build/preview channels unless explicitly told to. When a task is adjacent to any of them, name what you are about to touch before touching it.

## Pull Requests

- Creating a PR is allowed, but only with the user's explicit permission each time.
- Make sure titles follow conventions from the repo. They should be simple and easy to understand. Conventional commit styles in projects that use them, i.e. `fix(web): new threads no longer spike CPU`.
- PR descriptions should aim for simplicity. Open with a minimal, clear description of the problem. Follow up with how you solved it.
- Add a blurb to the end of the PR description about what model and harness is making the changes.
- **Open a real PR, not a draft.** Drafts do not get review-bot coverage.
- When making comments on PRs as the user start with a blurb that states it's from an agent and what model and harness was used.
- **Rebase onto latest `main` before opening.** Stale branches conflict and waste a review round.
- When asked to monitor or babysit a PR: poll checks and comments newer than the last push. In `allbin` owned repos you trigger reviews by commenting exacly `@allbin-reviewbot`; verify each bot finding against the source before acting on it; fix real ones and dismiss false positives with a written reason; fix CI failures, distinguishing real breaks from known infra flakes. If nothing is new, stay quiet - do not post filler comments. Stop when the repo's review bots are green on the latest commit.
- Merge only per the disposition given in the request (merge when green, or stop and report). If none was given, report and ask.


## Git
- Never push to a protected branch (main, master, dev, develop, development, test, staging, release, or similar). Pushing to these is not allowed unless explicitly instructed and allowed by the user.
- NEVER co-author commits. Do not add a `Co-Authored-By` trailer or AI attribution to commit messages.
