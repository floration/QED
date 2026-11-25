# QED-E060 — Is a random 5-regular graph 3-colourable?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Probability

**Plain words:** Choose a graph uniformly at random among all 5-regular graphs on n labelled vertices (n even). Such a graph is known to be 4-colourable with probability tending to 1, and it is known to be 3-colourable with probability tending to 1 provided an explicit four-variable function attains its global maximum at one specific point, which numerics strongly support but nobody has proved. Prove unconditionally that the probability of 3-colourability tends to 1. Degree 5 is exactly where the answer switches: random 4-regular graphs are almost surely 3-colourable, random 6-regular ones almost surely are not.

**Math:** Let $\mathcal G_{n,5}$ be the set of simple 5-regular graphs on $[n]$ ($n$ even), with the uniform measure. Prove $\lim_{n\to\infty,\ n\text{ even}}|\{G\in\mathcal G_{n,5}:\chi(G)\le 3\}|/|\mathcal G_{n,5}|=1$.

**Reviewer note:** Known: Random 5-regular graphs are a.a.s. 4-colourable (Shi-Wormald, CPC 2007). They are 3-colourable with probability bounded away from 0 if a certain explicit function has a unique maximum at a given point, and a.a.s. 3-colourable under the same hypothesis; extensive numerics support it (Diaz-Kaporis-Kemkes-Kirousis-Perez-Wormald, J. Graph Theory 2009; ESA 2005 version '5-regular graphs are 3-colorable with positive probability'). For general d, chi(G_{n,d}) is a.a.s. k-1 or k (Kemkes-Perez-Gimenez-Wormald, 2010), who note 'we were unable to verify the maximum hypothesis'. Large-k exact results (Coja-Oghlan-Efthymiou-Hetterich, JCTB 2016) do not cover k=3.

**Credit:** Diaz, Kaporis, Kemkes, Kirousis, Perez, Wormald (2005/2009); Kemkes, Perez-Gimenez, Wormald

**Rests on recent unrefereed work. Check these premises first:**
- Literature check could not open the 2009 JGT abstract directly; status rests on the 2010 Kemkes-Perez-Gimenez-Wormald statement and absence of later claims. A 2015-2026 result on small-q regular colouring may exist and should be ruled out by the vetter.
- Risk that the remaining step is 'just' a rigorous numerical maximisation (lesson 5); but it has been open for 20 years and is a recognised problem.

**References:**
- https://users.monash.edu.au/~nwormald/papers/3col.pdf
- https://www.math.unl.edu/~xperezgimenez2/papers/dregular.pdf
- https://www.cambridge.org/core/journals/combinatorics-probability-and-computing/article/colouring-random-regular-graphs/96E0E9B3D8FD5312BA4EA95B07E1DC58
- https://cgi.di.uoa.gr/~optas/papers/kreg.pdf

Difficulty estimate: 5.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE060.Claim` or a proof of `¬ OpenProblems.QEDE060.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E060/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E060` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E060/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E060/Statement.lean to your file
theorem solution : OpenProblems.QEDE060.Claim := by   -- or ¬ OpenProblems.QEDE060.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E060/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E060/<user>/Solution.lean`.
