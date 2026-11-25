# Contributing

Problem IDs: `QED-Mxxx` is the main set, `QED-Exxx` the extended set (weaker, grade C, not yet formalized).

## Start here: the 8 test problems
Before attempting any open problem, solve the test problems **QED-Q1 to QED-Q8**, or at least **QED-Q1**. They are known results with known proofs, roughly doubling in length from about 2 to 256 Lean lines. Submitting one checks that your Lean and Mathlib setup, your fork and the pull-request pipeline all work end to end, so a real solution won't fail later because of setup problems. Test solutions are verified and shown on the problem page, but they never count toward the leaderboards.

## Claim a problem (yellow dot)
Open an issue titled `Claim QED-M042` (use the "Claim a problem" template). Anyone may claim any problem at any time, even one already solved.
Comment on your issue at least once every 7 days; claims with no update from you for 7 days are closed automatically (daily sweep). Close it yourself to drop out.

## Formalize a statement
Many `problems/QED-Mxxx/Statement.lean` files still contain `def Claim : Prop := sorry`. Replace the `sorry` with a faithful Lean 4 + Mathlib statement in a PR from a branch named `statement-QED-Mxxx` that touches only that file. A maintainer reviews faithfulness. Solutions are only accepted for formalized problems.

## Submit a solution (green dot)
Add, in a PR from your own account:
```
solutions/QED-Mxxx/<your-github-username>/Solution.lean   # theorem solution : OpenProblems.QEDMxxx.Claim (or ¬ …)
solutions/QED-Mxxx/<your-github-username>/meta.json       # {"model": "<AI model or none>", "kind": "proof"|"disproof"}
solutions/QED-Mxxx/<your-github-username>/README.md       # optional explanation
```
CI prepends the official statement, compiles with the pinned Lean/Mathlib, rejects `sorry`/`admit`/`axiom`/`native_decide`/`#eval`/macros/options, and checks `#print axioms solution` uses only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
- Size = non-blank, non-comment lines of `Solution.lean`, excluding imports.
- First victor = earliest merged verified solution (permanent).
- Smallest = smallest verified solution (ties go to the earlier one).
- Leaderboards count problems where you hold first or smallest, keyed by (username, AI model). Submission tests (`QED-Q1`–`QED-Q8`, `N-000`) are recorded on their problem pages but never count toward the leaderboards.
