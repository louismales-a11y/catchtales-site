# 🔎 Cloudflare Web Analytics — catchtales.com

Free, privacy-friendly visitor analytics. No cookie banner needed (no personal
data, no ads). Works perfectly on static GitHub Pages.

## Activate (one time, ~3 minutes)

1. Create a free account at **https://dash.cloudflare.com/sign-up** (or log in).
2. In the dashboard: **Analytics → Web Analytics → Add a site**.
   - Domain: `catchtales.com`
   - Choose the **snippet/script** setup (not the automatic DNS option —
     we host on GitHub Pages).
3. Cloudflare gives you a snippet containing a **token** (a ~32-char hex string).
4. Save that token here:

   ```
   echo 'YOUR_TOKEN_HERE' > tools/cf_token.txt
   ```

   (It's already in `.gitignore`-style spirit: don't commit it — see below.)
5. Inject + deploy:

   ```
   python3 tools/cf_analytics.py
   git add -A && git commit -m "Analytics on" && git push
   ```

   GitHub Actions auto-deploys; analytics starts collecting within minutes.

## Everyday use

- View traffic at `dash.cloudflare.com → Analytics → Web Analytics`.
- Want no-token injection? `CF_ANALYTICS_TOKEN=<token> python3 tools/cf_analytics.py`
- Refresh the token everywhere: `python3 tools/cf_analytics.py --force`
- Remove entirely: `python3 tools/cf_analytics.py --remove`

## Notes

- The tool is idempotent: re-running never duplicates the snippet.
- If the token file is missing/empty, the tool changes nothing (safe).
- Keep `cf_token.txt` out of git (add to `.gitignore` or never commit it);
  the token only grants analytics reads, but least-privilege is best.
