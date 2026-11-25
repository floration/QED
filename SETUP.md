# Setup (one time, ~10 minutes)
1. Create a public repo `floration/qed` and push this folder (`git init && git add . && git commit -m init && git remote add origin … && git push -u origin main`).
2. Settings → Pages → Source: **GitHub Actions**.
3. Settings → Actions → General → Workflow permissions: **Read and write**; allow Actions to create issues/comments.
4. Issues → Labels → create label `claim`.
5. Settings → Branches → protect `main`: require the `verify-solution` check and one review before merge (you review statement PRs for faithfulness).
6. Run the `update-site-data` workflow once (Actions tab → Run workflow) to publish the board.
If the repo name differs, change `REPO` in `site/index.html` and `scripts/gen_main.py`, then rerun `python3 scripts/gen_main.py`.
