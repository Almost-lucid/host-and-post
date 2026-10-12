For people building in public with AI who want to turn ideas into live demos on their own GitHub and share them fast.

# Host and Post

Turn an idea into a working demo on your own GitHub, checked and recorded, with a draft post ready to share. You need **ChatGPT Plus** or **Claude Pro**, and a free GitHub account.

1. **Make your own copy.** Open this ready-made link (name and Public are filled in), then click **Create repository**. If the name is taken, add a number, like `my-demos-2`.
   https://github.com/new?template_owner=Almost-lucid&template_name=host-and-post&name=my-demos&visibility=public
2. **Turn on Pages.** Open `https://github.com/<your-username>/my-demos/settings/pages` and set **Source** to **GitHub Actions**.
3. **Build and share.** Connect Codex or Claude to that one project, describe your idea, then click **Merge** on the pull request it opens. Your live link, a short video and draft posts appear as a comment on that pull request. Nothing is posted for you.

Paste this sentence into ChatGPT or Claude and it will guide you through all three steps:

```text
Read https://raw.githubusercontent.com/Almost-lucid/host-and-post/main/START-HERE.md and guide me step by step to put a small demo live on my own GitHub. Never ask me to paste passwords or codes into chat.
```

The tip-splitter demo in your copy is only an example. Delete `demos/tip-splitter/` whenever you like.

---

## For developers

- **No Codex or Claude?** Paste a full page from free ChatGPT into **Issues → New demo** on your copy; it builds and comments the live link and drafts on the issue.
- **Pull requests** (`smoke-and-record.yml`, `slug-guard.yml`): the AI opens a PR under `demos/<slug>/`. `smoke-and-record` loads the page at 375px, fails on console errors or horizontal scroll, and records a video. `slug-guard` fails if a demo folder name isn't lowercase-hyphenated ASCII. You merge.
- **Deploy** (`deploy.yml`): on pushes to `main`, rebuilds the site, records missing videos, publishes to Pages, then comments **Live** + video + LinkedIn / X drafts on the merged PR (or on the commit if there's no PR).
- **Issue build** (`build.yml`): runs on **New demo** issues opened by the repo owner; guards the pasted HTML, smoke-tests, commits to `main`, publishes, and comments on the issue. Shares the `pages` concurrency group with deploy.
- **Connect an AI** (both **untested**): Codex: connect GitHub on OpenAI's page and grant only this repo. Claude: install the [Claude GitHub app](https://github.com/apps/claude/installations/select_target) on only this repo.
- **What fits:** small public static pages with sample data. No accounts, personal data, secret keys or backends. Everything on Pages is public.
- **`site.json`:** `{ "base_url": "" }`. Leave empty unless you use a custom domain.
- **Local:** `npm install && npx playwright install --with-deps chromium`, then `node tools/smoke_record.mjs <slug>` (needs `ffmpeg`). `python3 tools/test_guard_html.py` and `bash tools/test_check_slugs.sh` run the tests.
- `START-HERE.md` is the guide for AIs, also served as `/start.txt` on your Pages site.

```
START-HERE.md                 step-by-step guide for ChatGPT / Claude
AGENTS.md                     rules for coding agents
demos/<slug>/index.html       one static demo per folder
demos/<slug>/demo.json        optional title, pitch, video steps
tools/smoke_record.mjs        Playwright smoke test + recorder
tools/build_index.mjs         demos index page at deploy time
tools/guard_html.py           blocks external resources in pasted pages
tools/check_slugs.sh          demo-name check used by slug-guard
.github/workflows/            build, smoke-and-record, slug-guard, deploy
.github/ISSUE_TEMPLATE/       New demo form
```
