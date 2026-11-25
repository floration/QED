# QED-E050 — Does Antihydra halt?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B- · QED Curated · Logic & computability

**Plain words:** Start with 8 and repeatedly multiply by 3/2, rounding down. Keep score: +2 for every even number you see and −1 for every odd number. Does the score ever go negative? This is exactly the question of whether a specific 6-state Turing machine, called Antihydra, ever halts. Answering it is the first obstacle to determining the sixth Busy Beaver number.

**Math:** Let $a_0=8$ and $a_{n+1}=\lfloor 3a_n/2\rfloor$. For $n\ge1$ let $E_n=\#\{i<n:a_i\text{ even}\}$ and $O_n=\#\{i<n:a_i\text{ odd}\}$. Does there exist $n$ with $O_n>2E_n$? Equivalently (bbchallenge), does the 6-state 2-symbol Turing machine 1RB1RA_0LC1LE_1LD1LC_1LA0LB_1LF1RE_---0RA halt from a blank tape? The conjecture is that it never halts.

**Reviewer note:** Known: Simulated to $2^{38}$ rule steps without halting (bbchallenge wiki). Under a random-walk heuristic (steps +2/−1), the chance of ever reaching −1 from the current score is about $10^{-2.87\times10^{10}}$ (wiki). It is listed as an undecided 'probviously non-halting' cryptid on the BB(6) wiki page; the current BB(6) champion exceeds $10\uparrow\uparrow10\uparrow\uparrow10\uparrow\uparrow8$ (mxdys, June 2025). BB(5) is determined (arXiv:2509.12337). Related: Mahler's 3/2 problem; Dubickas on integer sequences from linear maps. More BB(6) cryptids, all unresolved: arXiv:2610.22603 (2026).

**Credit:** bbchallenge community (Antihydra found 2024; reformulation by mxdys et al.); Ligocki, 'BB(6) is Hard (Antihydra)'

**Rests on recent unrefereed work. Check these premises first:**
- The TM ⇔ arithmetic equivalence rests on bbchallenge wiki and its formal proofs, not a refereed paper. M is self-contained either way.
- Collatz-like; likely far beyond current methods

**References:**
- https://wiki.bbchallenge.org/wiki/Antihydra
- https://wiki.bbchallenge.org/wiki/BB(6)
- https://arxiv.org/abs/2509.12337
- https://arxiv.org/abs/2610.22603

Difficulty estimate: 6.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE050.Claim` or a proof of `¬ OpenProblems.QEDE050.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E050/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E050` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E050/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E050/Statement.lean to your file
theorem solution : OpenProblems.QEDE050.Claim := by   -- or ¬ OpenProblems.QEDE050.Claim
  ...
```
3. Add `solutions/QED-E050/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E050/<user>/Solution.lean`.
