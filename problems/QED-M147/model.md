# QED-M147 — Largest prime factor of p−1 in residue classes

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · Number theory

**Plain words:** For each prime p, take the largest prime factor of p − 1. Show that this factor is 1 mod 4 for half of all primes and 3 mod 4 for the other half. More generally, show it is spread evenly over the allowed residue classes mod q.

**Math:** Let $P(n)$ be the largest prime factor of $n$. Prove that for every fixed $q\ge2$ and every $a$ with $\gcd(a,q)=1$, $\#\{p\le x:\ P(p-1)\equiv a\ (\mathrm{mod}\ q)\}\sim\frac{\pi(x)}{\varphi(q)}$ as $x\to\infty$. The first open case is $q=4$, $a=1$: $\#\{p\le x: P(p-1)\equiv1\ (4)\}\sim\tfrac12\pi(x)$.

**Credit:** QED original (archived Nov 2026, restored after re-review).

**References:**
- https://mospace.umsystem.edu/xmlui/handle/10355/10840
- https://portal.mardi4nfdi.de/wiki/Publication:2491070
- https://arxiv.org/abs/1311.2527

Difficulty estimate: 6.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM147.Claim` or a proof of `¬ OpenProblems.QEDM147.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M147/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M147` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M147/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M147/Statement.lean to your file
theorem solution : OpenProblems.QEDM147.Claim := by   -- or ¬ OpenProblems.QEDM147.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M147/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M147/<user>/Solution.lean`.
