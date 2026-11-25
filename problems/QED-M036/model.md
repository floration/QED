# QED-M036 — Finding Huang's vertex

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Original · Complexity

**Plain words:** Huang's theorem says that any set of more than half the corners of the n-cube contains a corner with at least √n neighbours in the set. When the set is listed by a small circuit, how hard is it to find such a corner, or a flaw in the listing? The problem is easily shown to be at least as hard as the pigeonhole class PPP. Is it in PPP, so that it is PPP-complete, or does Huang's linear-algebra proof make it harder?

**Math:** HUANG: given a Boolean circuit f : {0,1}^n → {0,1}^n with inputs read as elements of [2^{n-1}+1] (others ignored), output either i ≠ j in [2^{n-1}+1] with f(i) = f(j), or i, j_1, …, j_m in [2^{n-1}+1] with m = ⌈√n⌉ such that f(j_1),…,f(j_m) are distinct and each is at Hamming distance 1 from f(i). Is HUANG ∈ PPP (under polynomial-time reductions; or, in the black-box model, is it reducible to PIGEON)? If not, which standard TFNP class contains it, and is it complete for it?

**QED results so far (reviewer-derived; check before relying on them):** The PPP-hardness reduction is correct. Take n=m+2. Pad 2^m real pigeons with 2^m+1 dummies, mapped injectively to the 2^m+1 dummy holes. Send the pigeon with C(x)=0 to dummy hole #1, so a collision with dummy #1 decodes to a zero-solution. Embed holes as h -> (h, parity h), which gives even weight. No two even-weight strings are adjacent, so every solution is a collision that decodes to a PIGEON solution.

**References:**
- https://arxiv.org/pdf/1907.00847
- https://api.crossref.org/works/10.1145%2F3777401
- https://arxiv.org/html/2401.12604v2
- https://arxiv.org/pdf/2209.07625
- https://arxiv.org/abs/2401.12604
- https://doi.org/10.1145/3777401
- https://arxiv.org/abs/1907.00847

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM036.Claim` or a proof of `¬ OpenProblems.QEDM036.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M036/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution. What is missing: Not formalized: requires circuits, polytime reductions and TFNP classes (PPP), none in Mathlib. Note that 'HUANG ∉ PPP' in the white-box sense implies P ≠ NP-type consequences, so only the positive direction or a black-box separation is realistic.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M036` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M036/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M036/Statement.lean to your file
theorem solution : OpenProblems.QEDM036.Claim := by   -- or ¬ OpenProblems.QEDM036.Claim
  ...
```
3. Add `solutions/QED-M036/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M036/<user>/Solution.lean`.
