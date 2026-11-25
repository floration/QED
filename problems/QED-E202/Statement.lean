import Mathlib
/-! QED-E202: A positive proportion of integers are sums of three cubes
An integer a^3+b^3+c^3 (with a, b, c integers, negatives allowed) never leaves remainder 4 or 5 on division by 9,
and every other integer is believed to be such a sum. Nobody can even prove that a fixed positive fraction of
integers are sums of three cubes. Prove that for some c>0, at least cN of the integers 1, ..., N are sums of three
integer cubes for all large N.
Informal statement: Let $\mathcal C=\{a^3+b^3+c^3: a,b,c\in\mathbb Z\}$. Prove
$\liminf_{N\to\infty}\frac1N\#\{1\le n\le N: n\in\mathcal C\}>0$.
Formalization notes: `IsSumThreeCubes n` says n = a³ + b³ + c³ for some integers a, b, c (signs allowed).
liminf_{N} (1/N)·#{1 ≤ n ≤ N : n ∈ 𝒞} > 0 is stated in the equivalent form: there is δ > 0 such that for all
sufficiently large N, δ·N ≤ #{n ∈ [1, N] : n ∈ 𝒞} (counting over the integer interval Icc 1 N, with the
predicate made decidable classically). `Claim` = positive lower density; `¬Claim` = the lower density is 0.
-/
namespace OpenProblems.QEDE202

noncomputable section

open Classical

/-- n is a sum of three integer cubes. -/
def IsSumThreeCubes (n : ℤ) : Prop := ∃ a b c : ℤ, a ^ 3 + b ^ 3 + c ^ 3 = n

def Claim : Prop :=
  ∃ δ : ℝ, 0 < δ ∧ ∀ᶠ N : ℕ in Filter.atTop,
    δ * (N : ℝ) ≤ (((Finset.Icc (1 : ℤ) (N : ℤ)).filter IsSumThreeCubes).card : ℝ)

end

end OpenProblems.QEDE202
