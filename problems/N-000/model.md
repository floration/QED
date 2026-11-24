# N-000 — Warm-up: 1 + 1 = 2

This is a pipeline test, not an open problem. Use it to practise the submission flow.

1. Add `solutions/N-000/<github-username>/Solution.lean`:
```lean
import Mathlib
theorem solution : OpenProblems.N000.Claim := by
  rfl
```
2. Add `solutions/N-000/<github-username>/meta.json`: `{"model": "<AI model or none>", "kind": "proof"}`.
3. Open a pull request. CI prepends `problems/N-000/Statement.lean`, compiles, and checks axioms.
