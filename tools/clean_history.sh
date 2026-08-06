#!/usr/bin/env bash
# Purge binary blobs (APKs, videos) and unlinked video pages out of
# catchtales-site git history. Downloads are served from GitHub Releases;
# videos were unused on public pages and archived locally.
#
# Rewrites history + force-pushes, so run only from the working clone with a
# clean tree. Uses git-filter-repo (pip3 install --user git-filter-repo).
#
# Usage:  bash tools/clean_history.sh
set -euo pipefail

REMOTE="git@github.com:louismales-a11y/catchtales-site.git"
REPO="$(cd "$(dirname "$0")/.." && pwd)"
WORK="/tmp/site-clean-$$"
export PATH="$HOME/.local/bin:$PATH"

# 0) Preflight
command -v git-filter-repo >/dev/null || { echo "❌ install git-filter-repo (pip3 install --user git-filter-repo)"; exit 1; }
cd "$REPO"
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "❌ Working tree has uncommitted changes. Commit or stash first."; exit 1
fi
echo "Backing up old .git …"
tar czf "/home/louis/catchtales-site-git-history-backup-$(date +%Y%m%d).tgz" .git || true

# 1) fresh clone (filter-repo refuses non-fresh repos)
rm -rf "$WORK" && git clone -q "$REPO" "$WORK"
cd "$WORK"

# 2) strip binary blobs + unlinked video pages from full history
git filter-repo --invert-paths \
  --path-glob '*.apk' \
  --path-glob '*.mp4' \
  --path download \
  --path images/rod-reel-video \
  --path images/solunar-video \
  --path images/fishing-safety-video \
  --path images/how-to-walleye-video \
  --path images/catchtales-logo-video.png \
  --path-glob '*-video.html' \
  --path-glob '*-production.html' \
  --path rod-reel-photos.html \
  --force

# 3) commit + push (nothing to commit if HEAD tree already clean)
git remote add origin "$REMOTE"
git config user.name "$(cd "$REPO" && git config user.name)"
git config user.email "$(cd "$REPO" && git config user.email)"
git add -A
git commit -q -m "Purge APK and video blobs from history" 2>/dev/null || true
git push --force origin HEAD:main

# 4) point the working repo at the rewritten history
cd "$REPO" && git fetch -q origin && git reset -q --hard origin/main
rm -rf "$WORK"
echo "✅ history purged; .git: $(du -sh "$REPO/.git" | cut -f1)"
