#!/usr/bin/env bash
# Clean old APK blobs out of catchtales-site git history. Keeps the repo
# small after each release ("always clean" rule). Run it at every release.
#
# Rewrites history + force-pushes, so run only from the working clone with a
# clean tree. Uses git-filter-repo (pip3 install --user git-filter-repo).
#
# Usage:  bash tools/clean_apk_history.sh
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

# 2) strip all *.apk from full history
git filter-repo --invert-paths --path-glob '*.apk' --force

# 3) re-add the CURRENT apk set (needed to serve /download/ on GitHub Pages)
mkdir -p download
for v in dev free pro; do
  cp "$REPO/download/CatchTales-v2.19."*"-$v.apk" download/ 2>/dev/null || true
done

# 4) commit + push
git remote add origin "$REMOTE"
git config user.name "$(cd "$REPO" && git config user.name)"
git config user.email "$(cd "$REPO" && git config user.email)"
git add -A
git commit -q -m "Re-add current APK set (history-purged)" 2>/dev/null || true
git push --force origin HEAD:main

# 5) point the working repo at the rewritten history
cd "$REPO" && git fetch -q origin && git reset -q --hard origin/main
rm -rf "$WORK"
echo "✅ history purged; .git: $(du -sh "$REPO/.git" | cut -f1)"