# QED-E144 — Every non-abelian p-group has a non-inner automorphism of order p

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Algebra

**Plain words:** Every group acts on itself by conjugation, and these 'inner' automorphisms are its obvious symmetries. Does every finite non-abelian group whose order is a power of a prime p have an automorphism that is not inner and that gives the identity when applied p times? Gaschütz proved in 1966 that a non-inner automorphism of p-power order always exists, but getting order exactly p has resisted proof for decades.

**Math:** For every prime $p$ and every finite non-abelian $p$-group $G$, prove that there exists $\varphi\in\mathrm{Aut}(G)\setminus\mathrm{Inn}(G)$ with $\varphi^p=\mathrm{id}$ (such a $\varphi$ has order exactly $p$), or find a counterexample.

**Credit:** Y. Berkovich (Kourovka Notebook Problem 4.13); survey by Sarkar–Joshi

**Rests on recent unrefereed work. Check these premises first:**
- Naming: usually called the 'non-inner automorphism conjecture', but some papers call it 'Berkovich's conjecture'. The owner may treat it as person-named.
- Possible incremental partial results in 2025-26 that I did not find; no resolution claim found

**References:**
- https://arxiv.org/abs/1901.03560
- https://arxiv.org/abs/2505.04125
- https://arxiv.org/abs/2406.10623
- https://arxiv.org/abs/1702.02293
- https://arxiv.org/abs/2503.00954

Difficulty estimate: 6.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE144.Claim` or a proof of `¬ OpenProblems.QEDE144.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E144/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E144` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E144/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E144/Statement.lean to your file
theorem solution : OpenProblems.QEDE144.Claim := by   -- or ¬ OpenProblems.QEDE144.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E144/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E144/<user>/Solution.lean`.
