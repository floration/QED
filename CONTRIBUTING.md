# Contributing

Problem IDs: `QED-Mxxx` is the main set, `QED-Exxx` the extended set (weaker, grade C, not yet formalized).

## Start here: the 8 test problems
Before attempting any open problem, solve the test problems **QED-Q1 to QED-Q8**, or at least **QED-Q1**. They are known results with known proofs, roughly doubling in length from about 2 to 256 Lean lines. Submitting one checks that your Lean and Mathlib setup, your fork and the pull-request pipeline all work end to end, so a real solution won't fail later because of setup problems. Test solutions are verified and shown on the problem page, but they never count toward the leaderboards.

## Claim a problem (yellow dot)
Open an issue titled `Claim QED-M042` (use the "Claim a problem" template). Anyone may claim any problem at any time, even one already solved.
Comment on your issue at least once every 7 days; claims with no update from you for 7 days are closed automatically (daily sweep). Close it yourself to drop out.

## Formalize a statement
Many `problems/QED-Mxxx/Statement.lean` files still contain `def Claim : Prop := sorry`. Replace the `sorry` with a faithful Lean 4 + Mathlib statement in a PR from a branch named `statement-QED-Mxxx` that touches only that file. A maintainer reviews faithfulness. Solutions are only accepted for formalized problems.

## Share partial work
Anyone can post partial progress on any problem: a lemma, a special case, a reduction, a failed approach worth recording, or a Lean file with lemmas proved so far (unfinished steps belong in the README, not as `sorry`). It goes in your own folder inside the problem folder:
```
problems/QED-Mxxx/partial/<your-github-username>/README.md     # what you did, what is left (recommended)
problems/QED-Mxxx/partial/<your-github-username>/*.md|*.txt|*.lean
```
Open a PR from your own account touching only that folder. CI checks that the folder name matches your username, files are text (≤5 MB each), and any `.lean` file compiles against the official statement and passes the same independent kernel check as solutions: no `sorry`, no `axiom`, no `opaque`/`partial`/`unsafe` definitions, no redefinition of statement names in another namespace, and no `set_option`, `#eval` or metaprogramming. If it passes, it is merged automatically and listed under "Partial work" on the problem's page. You can update your own folder later the same way; you cannot edit anyone else's. Partial work does not count toward the leaderboards.

## Submit a solution (green dot)
Add, in a PR from your own account:
```
solutions/QED-Mxxx/<your-github-username>/Solution.lean   # theorem solution : OpenProblems.QEDMxxx.Claim (or ¬ …)
solutions/QED-Mxxx/<your-github-username>/meta.json       # {"model": "<AI model or none>", "kind": "proof"|"disproof"}
solutions/QED-Mxxx/<your-github-username>/README.md       # optional explanation
```
Big proofs can be split: add any number of extra `.lean` files (subfolders allowed, e.g. `Lemmas/Parity.lean`) next to `Solution.lean`. CI concatenates them in alphabetical path order, then `Solution.lean` last, after the official statement, so do not `import` your own files and keep each file's namespaces closed. Every file is held to the same rules, and the word `sorry` is rejected anywhere, even in comments. There is no size limit on solutions beyond GitHub's 100 MB per file; very slow proofs can hit the 60-minute compile limit. Size for the "smallest solution" board counts the lines of all your `.lean` files together.
CI prepends the official statement (always taken from `main`, so a PR cannot change it) and compiles with the pinned Lean/Mathlib, with a wall-clock limit. It rejects `sorry`/`admit`/`axiom`/`native_decide`/`opaque`/`#eval`/`#print`/`#guard_msgs`, options, and all metaprogramming (`macro`, `macro_rules`, `elab`, `elab_rules`, `syntax`, `simproc`, `open Lean`, `Lean.…`, `«…»` names, invisible or bidi Unicode characters), even in comments. The compiled result is exported as text (lean4export). A separate trusted job never loads anything compiled from your code: it compiles the official statement itself, requires every Mathlib/core/statement declaration in the export to be identical to the official one, rejects new axioms and `opaque`/`partial`/`unsafe` constants, checks everything with an independent kernel (nanoda), and requires a **root-level** `solution` (not inside any namespace) whose type is literally `OpenProblems.<ID>.Claim` (or `¬ OpenProblems.<ID>.Claim` for `"kind": "disproof"`), depending only on `propext`, `Classical.choice`, `Quot.sound`. The check fails closed. The folder name must be your GitHub username with exactly the same letter case. Only PRs that add files in your own `solutions/<id>/<you>/` or `problems/<id>/partial/<you>/` folder are merged automatically, decided by the files changed, never by branch name; everything else waits for a maintainer.

## Scoring
- Size = non-blank, non-comment lines of `Solution.lean`, excluding imports.
- First victor = earliest merged verified solution (permanent).
- Smallest = smallest verified solution (ties go to the earlier one).
- Leaderboards count problems where you hold first or smallest, keyed by (username, AI model). Submission tests (`QED-Q1`–`QED-Q8`, `N-000`) are recorded on their problem pages but never count toward the leaderboards.
