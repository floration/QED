# QED-E118 — Sylver coinage: who wins after the opening 16?

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade B · QED Curated · Games

**Plain words:** In Sylver coinage two players take turns naming positive integers. You may not name a number that can be written as a sum of numbers already named (repeats allowed), and whoever names 1 loses. Every prime 5 or larger is a winning first move. Any other winning first move must have the form 2^a 3^b, and the openings 1, 2, 3, 4, 6, 8, 9 and 12 are known to lose. Which player wins if the first player opens with 16?

**Math:** A position is a finite set $S\subset\mathbb Z_{>0}$; a legal move from $S$ is any integer $n\ge 2$ not in the additive monoid $\langle S\rangle$, giving $S\cup\{n\}$. Under normal play the player with no legal move loses (this matches the rule that naming $1$ loses). Every play is finite, by Dickson's lemma. Decide whether $\{16\}$ is a $\mathcal P$-position (the player who named $16$ wins) or an $\mathcal N$-position.

**Credit:** Conway (game and prize problem); Berlekamp–Conway–Guy, Winning Ways; Guy (1976); Sicherman (2002)

**Rests on recent unrefereed work. Check these premises first:**
- Appears in Conway's prize list; it is not usually called a named conjecture, but some readers may call it 'Conway's 16 problem'
- May reduce to a large but finite computation once the position becomes coprime; but the first stage is infinite-branching

**References:**
- https://en.wikipedia.org/wiki/Sylver_coinage
- https://uq.stanford.edu/question/19
- https://emis.univie.ac.at/journals/INTEGERS/papers/cg2/cg2.pdf
- https://sicherman.net/sylver/20q.html

Difficulty estimate: 5.0/10 (anchored scale: 1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE118.Claim` or a proof of `¬ OpenProblems.QEDE118.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E118/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E118` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E118/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E118/Statement.lean to your file
theorem solution : OpenProblems.QEDE118.Claim := by   -- or ¬ OpenProblems.QEDE118.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E118/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E118/<user>/Solution.lean`.
