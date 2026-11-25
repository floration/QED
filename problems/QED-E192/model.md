# QED-E192 — Hard squares at activity -1: free-strip transfer-matrix eigenvalues are roots of unity

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Mathematical physics

**Plain words:** Take a row of K sites. A row state is a set of sites with no two neighbours occupied (there are Fibonacci-many). Let O_K be the matrix with entry (-1)^{|t|} from state s to state t when s and t share no occupied site, and 0 otherwise: the transfer matrix of the hard-square lattice gas at activity -1 on a strip with free side boundaries. Show that every eigenvalue of O_K is a root of unity for every K, i.e. its characteristic polynomial is a product of cyclotomic polynomials.

**Math:** For $K\ge1$ let $\mathcal S_K=\{s\subseteq\{1,\dots,K\}: s\text{ has no two consecutive elements}\}$ and $O_K\in\mathbb Z^{\mathcal S_K\times\mathcal S_K}$, $(O_K)_{s,t}=(-1)^{|t|}[s\cap t=\emptyset]$. Prove that for every $K\ge1$ every root of $\det(xI-O_K)$ is a root of unity (equivalently, by Kronecker, all eigenvalues have modulus $1$). Note: $O_K$ itself need not have finite order (Jordan blocks occur, e.g. $K=4$), so the claim is about the spectrum only.

**Credit:** Fendley, Schoutens, van Eerten (2005); restated as open by Bousquet-Mélou, Linusson, Nevo (2008)

**Rests on recent unrefereed work. Check these premises first:**
- Naming: the source is often cited as 'the conjecture of Fendley, Schoutens and van Eerten'. It is not a standard eponymous name, but the scorer may treat it as person-named. Mitigation: title it by content.
- An unpublished resolution may exist in a thesis (M. Assis 2014 thesis not checked) or in the omega-institute auto-proof effort (open, unreviewed, preregistration only)
- Direction convention: (O_K)_{s,t} with sign on t vs on s gives similar matrices (conjugate by diag signs and transpose), so the claim is robust

**References:**
- https://arxiv.org/abs/cond-mat/0408497
- https://arxiv.org/abs/math/0701890
- https://arxiv.org/abs/0709.4324
- https://arxiv.org/abs/0812.1165
- https://www.combinatorics.org/ojs/index.php/eljc/article/view/v13i1r67

Difficulty estimate: 4.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE192.Claim` or a proof of `¬ OpenProblems.QEDE192.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E192/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E192` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E192/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E192/Statement.lean to your file
theorem solution : OpenProblems.QEDE192.Claim := by   -- or ¬ OpenProblems.QEDE192.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E192/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E192/<user>/Solution.lean`.
