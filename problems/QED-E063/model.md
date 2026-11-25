# QED-E063 — Word problem for one-relation monoids

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Logic & computability

**Plain words:** Take a monoid with a single defining relation u = v between two words. Is its word problem always decidable: for each such monoid, is there an algorithm that, given two words, decides whether they are equal in it? This is open even though the corresponding question for one-relator groups was settled long ago.

**Math:** For a finite alphabet $A$ and $u,v\in A^*$, let $\equiv_{u,v}$ be the smallest congruence on $A^*$ containing $(u,v)$. Problem: does every one-relation monoid $\mathrm{Mon}\langle A\mid u=v\rangle$ have decidable word problem, i.e. is $\{(w_1,w_2): w_1\equiv_{u,v}w_2\}$ decidable for every fixed $A,u,v$? Board Claim: yes. (Uniform variant: the set of all $(A,u,v,w_1,w_2)$ with $w_1\equiv_{u,v}w_2$ is decidable. By Adian--Oganesyan (1978; two-generator form 1987) it suffices to treat $\mathrm{Mon}\langle a,b\mid bUa=aVa\rangle$ and $\mathrm{Mon}\langle a,b\mid bUa=a\rangle$, $U,V\in\{a,b\}^*$; both cases remain open. Undecidability for one fixed such monoid settles the problem negatively.)

**Reviewer note:** Known: Decidable for special monoids <A|r=1> (Adian 1960; Makanin's reduction to the group of units), for Adian's left- or right-cycle-free presentations (u and v differ in first letter, or in last letter), and many subcases (Adian-Oganesyan 1987, Lallement 1974, Kobayashi, and Nyberg-Brodda's monadic results). Adian-Oganesyan reduced the general problem to <a,b | bUa = a>. Surveys: Nyberg-Brodda, 'The word problem for one-relation monoids: a survey', Semigroup Forum 103 (2021), arXiv:2105.02853. Related undecidability: one-relator inverse monoids (R. D. Gray, Invent. Math. 2020). Status reconfirmed open in Gray-Steinberg arXiv:2507.04819 (v2 March 2026) and Foniqi-Gray-Nyberg-Brodda (Canad. J. Math. 2024, arXiv:2305.15672), where the related prefix-membership problem is shown undecidable for some positive one-relator groups.

**Credit:** S. I. Adian (posed c. 1960); reduction by Adian and G. U. Oganesyan

**Rests on recent unrefereed work. Check these premises first:**
- the precise form of the Adian-Oganesyan reduction (bUa=a) was taken from secondary knowledge of the survey, not verified from the full text in this check
- famous within combinatorial semigroup theory; vetter should judge 'famous problem in disguise' (it is stated directly, not disguised)

**References:**
- https://arxiv.org/abs/2105.02853
- https://arxiv.org/html/2507.04819v2
- https://www.cambridge.org/core/product/E2D6486D62B9833E797A2D4E9814707D

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE063.Claim` or a proof of `¬ OpenProblems.QEDE063.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E063/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E063` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E063/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E063/Statement.lean to your file
theorem solution : OpenProblems.QEDE063.Claim := by   -- or ¬ OpenProblems.QEDE063.Claim
  ...
```
3. Add `solutions/QED-E063/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E063/<user>/Solution.lean`.
