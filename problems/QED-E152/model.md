# QED-E152 — Does the classical Hénon map have a periodic sink?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Dynamics

**Plain words:** The Hénon map H(x,y) = (1 − 1.4x² + y, 0.3x) is the textbook example of a 'strange attractor': on a computer screen its orbits trace out a fractal set. No one has proved that what we see is not just a stable periodic orbit with a very long period. Decide whether H has an attracting periodic orbit.

**Math:** Let $H(x,y)=(1-\tfrac{7}{5}x^2+y,\ \tfrac{3}{10}x)$ on $\mathbb{R}^2$. Decide whether there exist $n\ge1$ and $p\in\mathbb{R}^2$ with $H^n(p)=p$ such that both eigenvalues of $DH^n(p)$ have modulus $<1$.

**Credit:** Hénon (1976); open question as framed by Galias & Tucker (2015)

**Rests on recent unrefereed work. Check these premises first:**
- A positive answer could come from a pure computer search (a certified long-period sink). That is a legitimate solution, but some reviewers may see it as computational.
- A negative answer is far beyond current techniques, so the problem may sit open for a long time either way.

**References:**
- https://research.monash.edu/en/publications/is-the-h%C3%A9non-attractor-chaotic/
- https://www2.math.uu.se/~watuc425/CAPA/publications/papers/chaossubmitted20140128.pdf
- https://zenodo.org/records/18824095
- https://arxiv.org/abs/math/0304450

Difficulty estimate: 8.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE152.Claim` or a proof of `¬ OpenProblems.QEDE152.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E152/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E152` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E152/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E152/Statement.lean to your file
theorem solution : OpenProblems.QEDE152.Claim := by   -- or ¬ OpenProblems.QEDE152.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E152/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E152/<user>/Solution.lean`.
