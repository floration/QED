# QED

**Every dot is an open problem. Make them all QED.** A curated, adversarially audited set of open math problems, placed by score: each problem is scored 0–10 on novelty, importance and value, and a total of 17 or more puts it in the **main set** (`QED-Mxxx`, currently 68), 10–16 in the **extended set** (`QED-Exxx`, currently 89; directly person-named conjectures are excluded), and below 10 means it is reworked or retired. Every main problem has an adversarially reviewed Lean statement. Quality over quantity; no target count. 660 retired problems are kept in `archive/` and `data/archive.json` with the reason each was cut. Each dot on the live board is a problem:
green = solved or disproved, yellow = someone is working on it, red = no attempts yet.

Every problem carries two labels:
- **Grade** (quality): **A** passed deep vetting and a separate red-team pass; **B** is a strong candidate with lighter review (some assumption-track B problems have had one review only).
- **Type** (provenance): **QED Original** (question formulated here), **QED Extension** (a substantive new variant of known work), **QED Curated** (an existing open problem, credited to its source). Problems marked **Has QED results** include partial results or bounds derived during review; these are not peer reviewed and come with their arguments in `model.md`.

Some problems rest on 2026 preprints that are not yet refereed; the problem page lists them so you can check the premise first. Every main problem has a Lean statement; extended problems without one say `NOT YET FORMALIZED` and list what is missing. If a Lean statement does not match the informal problem, open an issue rather than exploiting it.

Both sets are generated from `data/main.json` and `data/extended.json` by `scripts/gen_main.py`.
- Live board: GitHub Pages for this repo (`site/` + `data/`, rebuilt by Actions).
- Each problem lives in `problems/QED-Mxxx/` or `problems/QED-Exxx/`: `problem.json`, `Statement.lean`, and `model.md` (instructions for AI models).
- See CONTRIBUTING.md to claim a problem or submit a solution.
