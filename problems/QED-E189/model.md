# QED-E189 — Reachability for two-interval piecewise affine maps

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Logic & computability

**Plain words:** Fix a rational cut point c in (0,1) and two affine maps with rational coefficients, and let f use the first map on [0,c) and the second on [c,1), with f mapping [0,1) into itself. Given rational x and y in [0,1), does iterating f from x ever hit y exactly? Is there an algorithm that decides this for every such f, x, y? It is open even for two pieces, while in dimension two the analogous problem is undecidable.

**Math:** For $\theta=(a_1,b_1,a_2,b_2,c)\in\mathbb Q^5$ with $0<c<1$ let $f_\theta:[0,1)\to\mathbb R$, $f_\theta(t)=a_1t+b_1$ for $t<c$ and $f_\theta(t)=a_2t+b_2$ for $t\ge c$, and let $\Theta=\{\theta: f_\theta([0,1))\subseteq[0,1)\}$ (a decidable set). Let $\mathrm{Reach}_2=\{(\theta,x,y):\theta\in\Theta,\ x,y\in\mathbb Q\cap[0,1),\ \exists n\ge0\ f_\theta^{\,n}(x)=y\}$. Decide whether $\mathrm{Reach}_2$ is decidable (either answer, with proof, resolves the problem).

**Credit:** Open problem as stated by Ghahremani, Kelmendi, Ouaknine (LICS 2023); the 2-D undecidability baseline is Koiran–Cosnard–Garzon (1994).

**Rests on recent unrefereed work. Check these premises first:**
- My restriction of the domain to Q (instead of R or [0,1]) is harmless for reachability between rational points but should be stated in the board text.
- Some sources state the problem for self-maps of [0,1]. That class is a decidable subset of instances of Reach_2, so undecidability there implies undecidability here and decidability here implies decidability there; but a decidability proof only for self-maps of [0,1] would not settle this statement. Choose one version before posting.

**References:**
- https://arxiv.org/abs/2301.09752
- https://people.mpi-sws.org/~joel/publications/pam23.pdf
- https://livrepository.liverpool.ac.uk/3023232/
- https://arxiv.org/abs/2502.19923
- https://arxiv.org/abs/1510.04121

Difficulty estimate: 5.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE189.Claim` or a proof of `¬ OpenProblems.QEDE189.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E189/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E189` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E189/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E189/Statement.lean to your file
theorem solution : OpenProblems.QEDE189.Claim := by   -- or ¬ OpenProblems.QEDE189.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E189/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E189/<user>/Solution.lean`.
