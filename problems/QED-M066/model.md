# QED-M066 — Graceful labellings of forests

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · Graph theory

**Plain words:** A forest with m edges and c trees has m + c vertices. Label them with 0, 1, ..., m + c - 1, each label used once, so that the m edge differences |label(u) - label(v)| are all different. Show that every forest has such a labelling. The case 'a tree plus one isolated vertex' already says that every tree can be labelled gracefully if one spare label is allowed.

**Math:** Prove that every forest $F$ with $m$ edges and $c\ge1$ components has a bijection $\ell:V(F)\to\{0,1,\dots,m+c-1\}$ such that the values $|\ell(u)-\ell(v)|$, $uv\in E(F)$, are pairwise distinct. (Key special case: $F=T\sqcup K_1$, i.e. every tree with $m$ edges has an injective labelling into $\{0,\dots,m+1\}$ with distinct edge differences.)

**Credit:** Relaxation of the Ringel–Kotzig–Rosa Graceful Tree Conjecture; related: Van Bussel (EJC 2002, range-relaxed graceful labellings), Adamaszek–Allen–Grosu–Hladký arXiv:1608.01577, gracesize arXiv:2511.11331.

**References:**
- https://www.combinatorics.org/ojs/index.php/eljc/article/view/v9i1r4
- https://arxiv.org/abs/1608.01577
- https://arxiv.org/abs/2511.11331
- https://arxiv.org/abs/1402.0196

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM066.Claim` or a proof of `¬ OpenProblems.QEDM066.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M066/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M066` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M066/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M066/Statement.lean to your file
theorem solution : OpenProblems.QEDM066.Claim := by   -- or ¬ OpenProblems.QEDM066.Claim
  ...
```
3. Add `solutions/QED-M066/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M066/<user>/Solution.lean`.
