#!/usr/bin/env python3
"""One-command Cloudflare Web Analytics injector for catchtales.com.

Reads the analytics token from <repo>/tools/cf_token.txt (or $CF_ANALYTICS_TOKEN).
If no token is present, prints a message and changes nothing.
Injects the Cloudflare beacon snippet into every *.html file before </head>,
guarded by BEGIN/END markers so it never double-inserts.

Usage:
    python3 tools/cf_analytics.py           # inject (skips if no token)
    python3 tools/cf_analytics.py --force   # refresh the token on all pages
    python3 tools/cf_analytics.py --remove  # strip the snippet from all pages
"""
import os
import sys

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TOKEN_FILE = os.path.join(REPO, "tools", "cf_token.txt")
BEG = "<!-- BEGIN CF-ANALYTICS -->"
END = "<!-- END CF-ANALYTICS -->"


def load_token():
    if os.environ.get("CF_ANALYTICS_TOKEN"):
        return os.environ["CF_ANALYTICS_TOKEN"].strip()
    if os.path.isfile(TOKEN_FILE):
        t = open(TOKEN_FILE).read().strip()
        if t:
            return t
    return None


def snippet(token):
    return (
        f'{BEG}\n'
        f'<script defer src="https://static.cloudflareinsights.com/beacon.min.js" '
        f'data-cf-beacon=\'{{"sv":"2026-05-13","c":true,"snippet":"{token}"}}\'></script>\n'
        f'{END}\n'
    )


def collect_html():
    out = []
    for root, dirs, files in os.walk(REPO):
        if any(x in root for x in (".git", "tools", "images", "assets")):
            continue
        for f in files:
            if f.endswith(".html"):
                out.append(os.path.join(root, f))
    return out


def inject(file, block, force):
    s = open(file, encoding="utf-8", errors="ignore").read()
    if BEG in s or END in s:
        if not force:
            return "exists"
        # replace the existing block cleanly
        i = s.find(BEG)
        j = s.find(END)
        if j < 0:
            j = s.find("</head>")
        s = s[:i] + block + s[j + len(END):]
        open(file, "w", encoding="utf-8").write(s)
        return "updated"
    i = s.rfind("</head>")
    if i < 0:
        return "nohead"
    s = s[:i] + block + s[i:]
    open(file, "w", encoding="utf-8").write(s)
    return "injected"


def remove(file):
    s = open(file, encoding="utf-8", errors="ignore").read()
    if BEG not in s and END not in s:
        return False
    i = s.find(BEG)
    if i < 0:
        i = s.find(END)
    j = s.find(END, i)
    if j < 0:
        k = s.find("</script>", i)
        j = (k + len("</script>") if k >= 0 else s.find("</head>", i))
        open(file, "w", encoding="utf-8").write(s[:i] + s[j:])
        return True
    open(file, "w", encoding="utf-8").write(s[:i] + s[j + len(END):])
    return True
    open(file, "w", encoding="utf-8").write(s[:i] + s[j + len(END):])
    return True


def main():
    cmd = sys.argv[1] if len(sys.argv) > 1 else ""
    if cmd == "--remove":
        n = sum(1 for p in collect_html() if remove(p))
        print(f"Removed analytics from {n} pages.")
        return

    token = load_token()
    if not token:
        print("⛔ No Cloudflare analytics token set.")
        print("   Create a site in Cloudflare Web Analytics (free), copy the beacon snippet token,")
        print("   then save it to tools/cf_token.txt  (e.g. 6fc0e67fdc2c5741e91c24086d77daac)")
        print("   or export CF_ANALYTICS_TOKEN=...  and re-run. Nothing was changed.")
        return

    force = "--force" in sys.argv
    out = {"injected": 0, "updated": 0, "nohead": 0}
    for f in collect_html():
        r = inject(f, snippet(token), force)
        if r in out:
            out[r] += 1
        else:
            out[r] = 0
    print(f"Done. injected={out['injected']} updated={out['updated']} no-head={out['nohead']}")
    print("Commit + push to deploy.")


if __name__ == "__main__":
    main()