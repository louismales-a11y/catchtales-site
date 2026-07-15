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
| `~/catchtales_cloud` | Flutter web source for cloud dashboard (builds into this site's `/cloud/`) | Not a git repo |

## Last verified correct state

- **Commit:** `4a26c59` — "Rebuild Flutter dashboard with underwater background in-app + transparent screen backgrounds"
- **Date:** July 15, 2026

## What the website includes

| Section | Location | Notes |
|---------|----------|-------|
| Homepage | `/index.html` | Hero removed — starts with stats bar |
| Features | `/features/` | 14 features with phone mockups |
| Blog | `/blog/` | 28 blog posts |
| Pro Login / Dashboard | `/cloud/` | Flutter web app — site nav bar fixed at top, underwater bg in-app |
| About | `/about/` | |
| FAQ | `/faq/` | |
| Contact | `/contact/` | |
| Privacy | `/privacy/` | |
| Terms | `/terms/` | |
| Dev (internal) | `/dev/` | Internal use only — no download link |
| Pro download | `/pro/` | |
| Free download | `/free/` | |

## Cleanup completed (July 15, 2026)

- 🗑️ Deleted stale `gh-pages` branch from `louismales-a11y/CatchTales` (had old website + CNAME claiming catchtales.com)
- 🗑️ Removed stale `CatchTales-Dev/web/` directory (35 files — old website snapshot tracked in Flutter dev repo)
- 🗑️ Removed `CatchTales-v2.14.27-dev.apk` from public downloads (internal use only)
- 🗑️ Removed dev APK download link from `/dev/` page
- 🗑️ Deleted `CNAME` from stale `gh-pages` branch
- ✅ All headers: single `catchtales-logo.png` (no duplicate branding)
- ✅ Cloud dashboard: fixed nav header + underwater background + 56px top padding

---

> ⚠️ **For pi (AI assistant):**
> **This is THE website repo.** When the user says "my website", "GitHub site", "catchtales.com", or anything about the site — **always work in `/home/louis/catchtales-site`**.
> **DO NOT confuse with:**
> - `~/CatchTales/` → Flutter mobile app (Android Pro version)
> - `~/CatchTales-Dev/` → Flutter app dev branch
> - `~/CatchTales-Free/` → Flutter app free version
> - `~/catchtales_cloud/` → Flutter web source for cloud dashboard (builds INTO this site at `/cloud/`)
>
> **Workflow:** Edit → `git add` → `git commit` → `git push` → wait ~2 min for deploy → user hard refreshes
> **Always verify before pushing:** check HTML is valid, check paths exist, check nothing is broken.
> **If unsure, read this file first.**
