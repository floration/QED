# QED-M110 — Logarithmically many conjugacy classes

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Curated · Algebra

**Plain words:** Every finite group of order n splits into conjugacy classes. Is there one fixed constant c>0 such that every finite group of order n has at least c*log n conjugacy classes? The best known lower bounds lose a power of log log n, and the question is whether that loss is real.

**Math:** Let $k(G)$ denote the number of conjugacy classes of a finite group $G$. Is $\inf\{k(G)/\log|G| : G \text{ finite}, |G|\ge 2\}>0$? Equivalently, either prove $k(G)\ge c\log|G|$ for an absolute $c>0$ and all finite $G$, or exhibit finite groups $G_i$ with $k(G_i)/\log|G_i|\to0$.

**Reviewer note:** Known: Pyber 1992: $k(G)\ge\varepsilon\log|G|/(\log\log|G|)^8$. Keller 2011 (Bull. Aust. Math. Soc.): exponent 7. Baumeister, Maróti, Tong-Viet, 'Finite groups have more conjugacy classes', Forum Math. 29 (2017): $k(G)\ge\delta\log_2|G|/(\log_2\log_2|G|)^{3+\varepsilon}$ for $|G|\ge3$. They also answer Bertram's $\log_3$ question for groups with trivial solvable radical. Cartwright proved $(3/5)\log|G|<k(G)$ for supersolvable groups. Jaikin-Zapirain proved a better-than-logarithmic bound for nilpotent groups. Bertram notes $k(G)=\lceil\log_3|G|\rceil$ for $PSL_3(4)$ and $M_{22}$.

**Credit:** Unnamed open question (the c·log|G| conjecture as stated in Baumeister–Maróti–Tong-Viet 2017, following Pyber 1992). A sharper log_3 variant is attributed to Bertram, but it is background only and not the posed question.

**Rests on recent unrefereed work. Check these premises first:**
- The 'best known' exponent 3+ε is from a 2017 refereed paper. A sharper solvable-group bound may exist that I did not find.
- Naming: the posed question is the unnamed c·log form. The sharper log_3 form is 'Bertram's question' and has been deliberately left out.

**References:**
- https://arxiv.org/abs/1503.04046
- https://arxiv.org/abs/0812.2590
- https://cambridge.org/core/services/aop-cambridge-core/content/view/B0E6C4E6382D5F7D17DDA3D057720393/S0004972712000536a.pdf/new-reductions-and-logarithmic-lower-bounds-for-the-number-of-conjugacy-classes-in-finite-groups.pdf
- https://msp.org/pjm/2025/336-1/pjm-v336-n1-p06-p.pdf
- https://arxiv.org/abs/2411.18863

Difficulty estimate: 6.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM110.Claim` or a proof of `¬ OpenProblems.QEDM110.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M110/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M110` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M110/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M110/Statement.lean to your file
theorem solution : OpenProblems.QEDM110.Claim := by   -- or ¬ OpenProblems.QEDM110.Claim
  ...
```
3. Add `solutions/QED-M110/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M110/<user>/Solution.lean`.
