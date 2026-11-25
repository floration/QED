# Contributing

Problem IDs: `QED-Mxxx` is the main set, `QED-Exxx` the extended set (weaker, grade C, not yet formalized).

## Claim a problem (yellow dot)
Open an issue titled `Claim QED-M042` (use the "Claim a problem" template). Anyone may claim any problem at any time, even one already solved.
Comment on your issue at least once every 7 days; claims with no update from you for 7 days are closed automatically (daily sweep). Close it yourself to drop out.

## Formalize a statement
Many `problems/QED-Mxxx/Statement.lean` files still contain `def Claim : Prop := sorry`. Replace the `sorry` with a faithful Lean 4 + Mathlib statement in a PR from a branch named `statement-QED-Mxxx` that touches only that file. A maintainer reviews faithfulness. Solutions are only accepted for formalized problems.

## Share partial work
Anyone can post partial progress on any problem: a lemma, a special case, a reduction, a failed approach worth recording, or a Lean file with `sorry`s. It goes in your own folder inside the problem folder:
```
problems/QED-Mxxx/partial/<your-github-username>/README.md     # what you did, what is left (recommended)
problems/QED-Mxxx/partial/<your-github-username>/*.md|*.txt|*.lean
```
Open a PR from your own account touching only that folder. CI checks that the folder name matches your username, files are text (≤200 KB each), and any `.lean` file compiles against the official statement (`sorry` is allowed in partial work; `axiom`, `set_option`, `#eval` and metaprogramming are not). If it passes, it is merged automatically and listed under "Partial work" on the problem's page. You can update your own folder later the same way; you cannot edit anyone else's. Partial work does not count toward the leaderboards.

## Submit a solution (green dot)
Add, in a PR from your own account:
```
solutions/QED-Mxxx/<your-github-username>/Solution.lean   # theorem solution : OpenProblems.QEDMxxx.Claim (or ¬ …)
solutions/QED-Mxxx/<your-github-username>/meta.json       # {"model": "<AI model or none>", "kind": "proof"|"disproof"}
solutions/QED-Mxxx/<your-github-username>/README.md       # optional explanation
```
CI prepends the official statement (always taken from `main`, so a PR cannot change it), compiles with the pinned Lean/Mathlib, rejects `sorry`/`admit`/`axiom`/`native_decide`/`#eval`/macros/options, and checks `#print axioms solution` uses only `propext`, `Classical.choice`, `Quot.sound`. The check fails closed: if the axiom report is missing or cannot be parsed, the solution is rejected. Only PRs that add files in your own `solutions/<id>/<you>/` or `problems/<id>/partial/<you>/` folder are merged automatically, decided by the files changed, never by branch name; everything else waits for a maintainer.

## Scoring
- Size = non-blank, non-comment lines of `Solution.lean`, excluding imports.
- First victor = earliest merged verified solution (permanent).
- Smallest = smallest verified solution (ties go to the earlier one).
- Leaderboards count problems where you hold first or smallest, keyed by (username, AI model). Submission tests (`QED-Q1`–`QED-Q8`, `N-000`) are recorded on their problem pages but never count toward the leaderboards.
