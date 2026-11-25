# QED-M077 — Does Elliott–Halberstam refute the Alternative Hypothesis, now that RH and GRH are theorems?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Extension · Number theory

**Plain words:** The Alternative Hypothesis (AH) says that every gap between consecutive zeta zeros, in normalized units, is close to a multiple of one half. It contradicts GUE. RH and GRH for Dirichlet L-functions are now theorems (Alpöge, Nov 2026), and they alone are not known to rule AH out. Decide whether adding the Elliott–Halberstam conjecture (a strong statement about primes, not zeros) makes AH impossible. Further questions (not part of the formal claim): the same for the version of AH that allows an exceptional set of zeros, or with GEH in place of EH.

**Math:** Let $0<\gamma_1<\gamma_2<\dots$ be the distinct positive ordinates of zeros of $\zeta$ and $\tilde\gamma=\frac{\gamma}{2\pi}\log\gamma$. AH (arXiv:2508.10857, §1, after Baluyot 2016): there is a positive function $\psi$ with $\psi(\gamma)\to\infty$ and $\psi(\gamma)=o(\log\gamma)$ such that for every $n\ge1$ there is an integer $k_n\ge0$ with $\tilde\gamma_{n+1}-\tilde\gamma_n=\tfrac12k_n+O(|\gamma_{n+1}-\gamma_n|\,\psi(\gamma_n))$, with one implied constant for all $n$ (an every-gap statement, as in the paper). Claim: RH + GRH for all Dirichlet $L$-functions + the Elliott–Halberstam conjecture EH (level $1-\varepsilon$ for every $\varepsilon>0$, for $\Lambda$, uniformly over coprime residues) imply that AH fails. (RH and GRH-Dirichlet are now theorems, Alpöge 2026, so this asks whether EH alone implies ¬AH; they are kept as hypotheses to match the Lean statement.) Further questions (not part of the formal claim): the same with AH weakened to allow an exceptional set of zeros (the paper's Remark 2 notes its results survive this), and the variant with GEH in place of EH (a weaker statement).

**Credit:** Baluyot, Goldston, Suriajaya, Turnage-Butterbaugh, The Alternative Hypothesis for zeros of the Riemann zeta-function, arXiv:2508.10857 (2025); Goldston et al., arXiv:2507.06823; Lagarias–Rodgers arXiv:1905.12123.

**Rests on recent unrefereed work. Check these premises first:**
- arXiv:2508.10857 (2025 preprint, unrefereed as far as known): the problem takes its precise definition of AH, and the claimed explicit limit of F(α) under RH + AH, from this paper.
- arXiv:2507.06823 (2025 preprint): background on F(α) under AH.
- RH is a theorem (Alpöge, Lean library released 20 Nov 2026, certified 21 Nov 2026 by the Lean FRO/Mathlib Initiative against Mathlib's RiemannHypothesis). GRH for Dirichlet L-functions is treated as proved on the strength of Alpöge's announcement (alpo.ge/remark.pdf) and his Lean archive; the public certification names only RH, so the Dirichlet part has not yet been certified independently. Hecke, Dedekind and other L-functions remain open.

**References:**
- https://arxiv.org/abs/1905.12123
- https://arxiv.org/abs/2508.10857
- https://arxiv.org/abs/2507.06823

Difficulty estimate: 6.5/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM077.Claim` or a proof of `¬ OpenProblems.QEDM077.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M077/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M077` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M077/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M077/Statement.lean to your file
theorem solution : OpenProblems.QEDM077.Claim := by   -- or ¬ OpenProblems.QEDM077.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M077/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M077/<user>/Solution.lean`.
