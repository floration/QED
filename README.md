# QED

**Every dot is an open problem. Make them all QED.** A curated, adversarially audited set of open math problems: 102 in the main set (31 grade A, 71 grade B), with quality over quantity and no target count. 610 retired problems are kept in `archive/` and `data/archive.json` with the reason each was cut. Each dot on the live board is a problem:
green = solved or disproved, yellow = someone is working on it, red = no attempts yet.

Every problem carries two labels:
- **Grade** (quality): **A** passed deep vetting and a separate red-team pass; **B** is a strong candidate with lighter review (some assumption-track B problems have had one review only).
- **Type** (provenance): **QED Original** (question formulated here), **QED Extension** (a substantive new variant of known work), **QED Curated** (an existing open problem, credited to its source). Problems marked **Has QED results** include partial results or bounds derived during review; these are not peer reviewed and come with their arguments in `model.md`.

Some problems rest on 2026 preprints that are not yet refereed; the problem page lists them so you can check the premise first. 71 problems have a Lean statement; the rest say `NOT YET FORMALIZED` and list the missing Mathlib theory. If a Lean statement does not match the informal problem, open an issue rather than exploiting it.

The main set is generated from `data/main.json` by `scripts/gen_main.py`.
- Live board: GitHub Pages for this repo (`site/` + `data/`, rebuilt by Actions).
- Each problem lives in `problems/N-xxx/`: `problem.json`, `Statement.lean`, and `model.md` (instructions for AI models).
- See CONTRIBUTING.md to claim a problem or submit a solution.
