AI assistant: if someone shared this link with you, read START-HERE.md and guide them step by step.

# Host and Post

Make a small web demo and share it in minutes.

1. **Copy this link.**
2. **Paste it into ChatGPT** and say “help me make a demo”.
3. **Follow its steps.**

You need **ChatGPT Plus** or **Claude Pro**, and a free GitHub account.

### Backup prompt

If ChatGPT doesn’t fetch the guide on its own, paste this together with the link:

```text
Read https://raw.githubusercontent.com/Almost-lucid/host-and-post/main/START-HERE.md
(or https://almost-lucid.github.io/host-and-post/start.txt) and guide me step by step.
Help me make a small web demo. Never ask me to paste passwords or secret codes into chat.
```

---

## For developers

Technical detail for people wiring this up themselves (or for AIs that need the mechanics).

### How it works

- **Issue build** (`.github/workflows/build.yml`): owner opens a **New demo** issue with a pasted page → guard HTML → smoke + record → commit to `main` → Pages → Live comment + drafts. Soft smoke: publish even if the check fails.
- **PR path** (`.github/workflows/smoke-and-record.yml` + `slug-guard.yml`): AI or human opens a PR under `demos/<slug>/` only. Checks must pass; a human merges. Template edits need an admin-applied `protocol` label.
- **Deploy** (`.github/workflows/deploy.yml`): on `main` pushes that touch demos/tools (not `github-actions[bot]`), rebuilds the site, records missing videos, publishes Pages, leaves drafts on the commit.
- Both `build.yml` and `deploy.yml` share `concurrency: { group: pages, cancel-in-progress: false }` so Pages deploys never race.
- At deploy time, `START-HERE.md` is copied to `/start.txt` (plain text) on Pages.

### Paste route (fallback for free users)

No Codex / Claude connector needed. On a laptop signed into GitHub:

1. Use the free ChatGPT prompt below to get idea + full HTML + a prefilled New demo URL (page is pasted into the form, not the URL).
2. Or **Issues → New demo**, fill idea/spec, paste the page into **Paste your page**, submit.
3. Watch the issue for `Building…`, then **Live** + video + LinkedIn / X drafts. **Nothing has been posted.**

```text
I want to open a GitHub "New demo" issue for my Host and Post repo.

Ask me once for my GitHub username and repository name, then help me shape one small demo idea (one screen, one main action).

Then write the full page in ONE fenced code block. Rules:
- Complete file from <!doctype html> through </html> — never abbreviate, never say "rest unchanged"
- Under 300 lines; plain HTML/CSS/JS only
- No frameworks, CDN, <script src>, fetch/XHR/WebSocket, backend, accounts, API keys, or personal data
- Works at phone width; sample/placeholder data only; include <title> and <meta name="description">
- If it would need a server, fake it with sample data

Then output:
1) A short plain-text idea and a 3–5 line spec.
2) The ONE code block with the full HTML.
3) ONE URL (URL-encoded) with only title, idea, and spec (the page is too long for a URL), params in this order:
https://github.com/<username>/<repo>/issues/new?template=new-demo.yml&title=<urlencode("New demo: " + idea)>&idea=<urlencode(idea)>&spec=<urlencode(spec)>

Tell me to: tap the link, paste the code block into the form field "Paste your page", then click Submit.
If the link breaks: Issues → New demo, paste idea/spec/page myself.
```

### File paste fallback

1. Ask an AI for one complete `demos/<slug>/index.html`.
2. **Add file → Create new file**, paste, commit to `main` (or open a PR).
3. Actions smoke-tests, records, publishes, leaves drafts. **Nothing has been posted.**

### Use this template

**Use this template → Create a new repository**, then **Settings → Pages → Source: GitHub Actions**.

### Connect an AI (**untested** unless noted)

- **OpenAI Codex** (Plus+): **untested**. Connect GitHub on OpenAI’s page; grant **only this repo**. Placeholder: if Codex adds an environment-setup / repo-setup step for Host and Post, document it here when known.
- **Claude GitHub app** (Pro): **untested**. Install [Claude](https://github.com/apps/claude/installations/select_target) on **only this repo**; connect Claude’s GitHub connector if prompted.
- **Any other AI with a token:** [fine-grained PAT](https://github.com/settings/personal-access-tokens/new) — this repo only; Contents R/W, Pull requests R/W, Metadata R; no Workflows / Administration / Secrets; 90-day expiry.
- **Copilot coding agent:** no token; assign an idea issue to Copilot; on its PRs click **Approve and run workflows** only after you read the diff.

### What we won’t host

No accounts, no real personal data, no secret API keys, no backends. Small public static pages with sample data only.

### Lock it down

Needs admin. Without a ruleset, nothing technically stops a write-access account pushing to `main`.
**Note:** the one-click issue build commits to `main` as `github-actions[bot]`. If your ruleset requires a pull request, add a bypass for GitHub Actions — or skip Lock it down and use the paste route. Create labels `build`, `replace`, and `protocol`, then a branch ruleset on `main` requiring checks `smoke-and-record` and `slug-guard` (and `build` if you want).

```sh
gh label create build -R <you>/<repo> -d "Build a demo from a New demo issue"
gh label create replace -R <you>/<repo> -d "Allow changing an existing demo"
gh label create protocol -R <you>/<repo> -d "Change the template itself"
gh api -X POST repos/<you>/<repo>/pages -f build_type=workflow
gh api -X POST repos/<you>/<repo>/rulesets --input - <<'JSON'
{"name": "gate 1", "target": "branch", "enforcement": "active",
 "conditions": {"ref_name": {"include": ["~DEFAULT_BRANCH"], "exclude": []}},
 "rules": [{"type": "required_status_checks", "parameters": {"strict_required_status_checks_policy": false,
   "required_status_checks": [{"context": "smoke-and-record"}, {"context": "slug-guard"}]}}]}
JSON
```

**Teams:** optionally require 1 approving review (`required_approving_review_count: 1`, with `dismiss_stale_reviews_on_push` and `require_last_push_approval` true).

### Gallery / `site.json`

Pages root lists `demos/`. `site.json`: `{ "base_url": "" }` — leave empty unless you use a custom domain.

### Good to know

- Everything on Pages is public. Placeholder data only.
- Empty **Paste your page** → comment “Paste your page from ChatGPT into the form.” and stop.
- Template edits need the `protocol` label to pass `slug-guard`.
- Local: `npm install && npx playwright install --with-deps chromium`, then `node tools/smoke_record.mjs <slug>` (needs `ffmpeg`).
- Guide for AIs: `START-HERE.md` (also served as `/start.txt` on Pages).

### Layout

```
START-HERE.md                 step-by-step guide for ChatGPT / Claude
AGENTS.md                     rules for coding agents / paste AIs
demos/<slug>/index.html       one static demo per folder
demos/<slug>/demo.json        optional title, pitch, video steps
tools/smoke_record.mjs        Playwright smoke test + recorder
tools/build_index.mjs         demos index at deploy time
tools/guard_html.py           block external resources in pasted pages
.github/workflows/            build, smoke-and-record, slug-guard, deploy, drafts
.github/ISSUE_TEMPLATE/       New demo form
```
