# 🎯 Canonical Website — CatchTales.com

**This is THE live website repo.** All edits here go live.

| What | Where |
|------|-------|
| **Repo** | `louismales-a11y/catchtales-site` |
| **Live URL** | https://catchtales.com |
| **GitHub Pages** | Auto-deploys from `main` branch via GitHub Actions |
| **Local path** | `/home/louis/catchtales-site` |

## What NOT to confuse this with

| Directory | What it is | Git remote |
|-----------|-----------|------------|
| `~/catchtales-site` | **🌐 THE WEBSITE** (this one) | `louismales-a11y/catchtales-site` |
| `~/CatchTales` | Flutter mobile app (Android) | `louismales-a11y/CatchTales` |
| `~/CatchTales-Dev` | Flutter app — dev branch | `louismales-a11y/CatchTales-Dev` |
| `~/CatchTales-Free` | Flutter app — free variant | `louismales-a11y/CatchTales-Free` |
| `~/catchtales_cloud` | Flutter web build output (deployed **inside** this site at `/cloud/`) | Not a git repo — part of this site |

## Workflow

1. Edit files in `~/catchtales-site`
2. `git add` + `git commit` + `git push`
3. GitHub Actions auto-deploys to catchtales.com
4. Takes ~1-2 minutes to go live

## Last verified correct state

- **Commit:** `a60da5a` — "Fix header branding: single catchtales-logo.png on all pages; add underwater background to cloud dashboard"
- **Date:** July 15, 2026

## Cleanup completed (July 15, 2026)

- 🗑️ Deleted stale `gh-pages` branch from `louismales-a11y/CatchTales` (had old website + CNAME claiming catchtales.com)
- 🗑️ Removed stale `CatchTales-Dev/web/` directory (35 files — old website snapshot tracked in Flutter dev repo)
- 🗑️ Removed `CatchTales-v2.14.27-dev.apk` from public downloads (internal use only)
- 🗑️ Removed dev APK download link from `/dev/` page
- 🗑️ Deleted `CNAME` from stale `gh-pages` branch
- ✅ Added `CANONICAL-SITE.md` to live site repo

---

> ⚠️ **For pi (AI assistant):** This is THE website repo. When the user says "my website", "GitHub site", or "catchtales.com", always work in **`/home/louis/catchtales-site`**. Do not confuse with `~/CatchTales/` (Flutter app), `~/CatchTales-Dev/` (app dev), `~/CatchTales-Free/` (app free), or `~/catchtales_cloud/` (cloud build source — not deployed standalone). If unsure, read this file first.
