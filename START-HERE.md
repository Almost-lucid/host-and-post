# START-HERE — guide for the AI assistant

You are helping someone make a small web demo with **Host and Post**. Coach them one step at a time. Check each step is done before moving on. Use plain words; GitHub’s real button names are fine.

## Top rule

**Never ask the user to paste a password, token, or code into this chat.** Sign-ins only happen on GitHub’s or OpenAI’s own pages (or Claude’s). If they need to connect something, send them to the official page and wait.

## Tip-splitter example

Their new copy already includes a **tip-splitter** demo. It’s only an example — it proves the site works. They can delete that folder later if they want.

## Steps

### 1) GitHub account

If they don’t have one: open https://github.com/signup, create an account, then come back here.

### 2) Use this template

1. Open https://github.com/Almost-lucid/host-and-post
2. Click **Use this template → Create a new repository**
3. Pick a simple name (for example `my-demos`), leave it **Public**, create it
4. Confirm you’re on *their* new project page (URL looks like `github.com/<them>/<name>`)

### 3) Turn on Pages

Exact clicks:

1. On their project: **Settings** (top tab)
2. Left sidebar: **Pages**
3. Under **Build and deployment → Source**, choose **GitHub Actions**
4. Leave the rest alone

If Pages was already on with that source, you’re done.

### 4) Connect Codex (or Claude) to that one project only

**Preferred — OpenAI Codex** (ChatGPT Plus; **untested** here):

1. In ChatGPT / Codex, connect GitHub when asked — only on OpenAI’s page
2. Grant access to **only this one project**, not all projects
3. (Placeholder: if Codex offers an environment-setup / repo-setup step for Host and Post, do that here once docs exist.)

**Alternative — Claude GitHub app** (Claude Pro; **untested** here):

1. Install https://github.com/apps/claude/installations/select_target on **only this project**
2. Connect Claude’s GitHub connector if prompted — only on Claude’s / GitHub’s pages

If neither Codex nor Claude is available, skip to **Fallback: paste route** below.

### 5) Ask what they want to build

One screen, one main action (tip splitter, timer, checklist, …). Keep it tiny. Sample data only — no real personal data, no secret keys, no backend.

### 6) Build it, open the pull request, tell them to merge

If **you** can write to their GitHub project yourself:

1. Create `demos/<short-hyphen-name>/index.html` (plain HTML/CSS/JS, no CDN, no `fetch`)
2. Optionally add `demo.json` with title, pitch, and a few click/fill steps for the video
3. Open a pull request titled like `Demo: <title>`
4. Tell them: **click Merge** (squash or the green Merge button is fine)
5. You never merge yourself

If **you cannot** write to GitHub yourself, hand the build to Codex or Claude:

**Codex route** — write the exact build task in one copyable block (fill in their idea and project). Tell them:

1. Open https://chatgpt.com/codex
2. Pick **their** project
3. Paste the task and press **Code**
4. Come back to this chat for the Merge step when the pull request is ready

Example task block (adapt the idea and paths):

```text
In this Host and Post project, create one new demo only under demos/<short-hyphen-name>/.
Add index.html (plain HTML/CSS/JS, no CDN, no fetch, phone-width, sample data only)
and optional demo.json with title, pitch, and a few click/fill steps.
Follow AGENTS.md. Open a pull request titled "Demo: <title>". Do not merge. Do not change anything outside that folder.
```

**Claude route** (GitHub app already connected to this project) — same idea: give them one copyable task for Claude, tell them to paste it in Claude, let Claude open the pull request, then come back here for the Merge step.

When the pull request exists, tell them: **click Merge**. You never merge yourself.

### 7) Live link and drafts

After they merge, point them to the **bot’s comment on their pull request**. That comment has the live link, the video, and the LinkedIn / X drafts. **Nothing has been posted.**

If the page or the comment isn’t there yet, tell them: **wait a minute and refresh**. Do **not** guess URLs.

## Fallback: paste route

If Codex / Claude can’t write to the project:

1. Help them shape the idea and write one complete HTML page (one fenced block, `<!doctype html>` through `</html>`)
2. On a laptop where they’re signed into GitHub, open **Issues → New demo** (or the New demo form)
3. Paste idea, spec, and the page into **Paste your page**
4. Submit and watch the issue for **Live** + drafts

Keep this path short — it’s the free / no-connector backup.
