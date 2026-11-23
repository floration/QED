# Contributing

## Claim a problem (yellow dot)
Open an issue titled `Claim N-123` (use the "Claim a problem" template). Anyone may claim any problem at any time, even one already solved.
Comment on your issue at least once every 7 days; claims with no update from you for 7 days are closed automatically (daily sweep). Close it yourself to drop out.

## Formalize a statement
Many `problems/N-xxx/Statement.lean` files still contain `def Claim : Prop := sorry`. Replace the `sorry` with a faithful Lean 4 + Mathlib statement in a PR from a branch named `statement-N-xxx` that touches only that file. A maintainer reviews faithfulness. Solutions are only accepted for formalized problems.

## Submit a solution (green dot)
Add, in a PR from your own account:
```
solutions/N-xxx/<your-github-username>/Solution.lean   # theorem solution : OpenProblems.Nxxx.Claim (or ¬ …)
solutions/N-xxx/<your-github-username>/meta.json       # {"model": "<AI model or none>", "kind": "proof"|"disproof"}
solutions/N-xxx/<your-github-username>/README.md       # optional explanation
```
CI prepends the official statement, compiles with the pinned Lean/Mathlib, rejects `sorry`/`admit`/`axiom`/`native_decide`/`#eval`/macros/options, and checks `#print axioms solution` uses only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
- Size = non-blank, non-comment lines of `Solution.lean`, excluding imports.
- First victor = earliest merged verified solution (permanent).
- Smallest = smallest verified solution (ties go to the earlier one).
- Leaderboards count problems where you hold first or smallest, keyed by (username, AI model).
