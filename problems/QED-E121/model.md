# QED-E121 — Linear arboricity of graphs with maximum degree 7

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Graph theory

**Plain words:** A linear forest is a graph whose components are paths. The linear arboricity conjecture says the edges of any graph with maximum degree D can be split into ceil((D+1)/2) linear forests. It was proved for D = 3, 4, 5, 6, 8 and 10 by 1988, but D = 7 is the smallest open case. Can the edges of every graph with maximum degree 7 be split into 4 linear forests?

**Math:** Prove or disprove: every finite simple graph $G$ with $\Delta(G)\le 7$ admits a map $c:E(G)\to\{1,2,3,4\}$ such that every colour class is a linear forest (acyclic, with maximum degree at most $2$). Equivalently, $\mathrm{la}(G)\le 4$ whenever $\Delta(G)\le 7$.

**Credit:** Akiyama–Exoo–Harary (conjecture); small-case history in Christoph et al. (2025)

**Rests on recent unrefereed work. Check these premises first:**
- Could not verify the content of a c.2023 Georgia State preprint 'A decomposition method on solving the linear arboricity conjecture'; it might treat D=7
- The full conjecture is sometimes attributed by name (Akiyama–Exoo–Harary); the D=7 case is an unnamed sub-question
- Unchecked: G. Chen (GSU, 2023 preprint) 'A decomposition method on solving the linear arboricity conjecture' may cover degree 7; a 2025 survey (arXiv:2507.20500) still lists degree 7 as open.

**References:**
- https://arxiv.org/abs/2507.20500
- https://arxiv.org/abs/2512.11240
- https://par.nsf.gov/servlets/purl/10325836
- https://arxiv.org/abs/2207.07169

Difficulty estimate: 3.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE121.Claim` or a proof of `¬ OpenProblems.QEDE121.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E121/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E121` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E121/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E121/Statement.lean to your file
theorem solution : OpenProblems.QEDE121.Claim := by   -- or ¬ OpenProblems.QEDE121.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E121/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E121/<user>/Solution.lean`.
