import Mathlib
/-! QED-E173: The Mertens function is unbounded on the square-root scale
The Mertens function M(x) adds up the Möbius function μ(n) for n ≤ x. Mertens guessed |M(x)| < √x, which was disproved in 1985 without an explicit counterexample, and we now know M(x)/√x exceeds about 1.83 in absolute value infinitely often. Prove that M(x)/√x is unbounded.
Informal statement: Let $M(x)=\sum_{n\le x}\mu(n)$. Prove $\limsup_{x\to\infty}|M(x)|/\sqrt{x}=+\infty$; i.e. for every $C>0$ there is $x$ with $|M(x)|>C\sqrt x$.
Formalization notes:
* μ is Mathlib's `ArithmeticFunction.moebius` (an `ArithmeticFunction ℤ`), cast to ℝ.
  `mertens N = ∑_{n=1}^{N} μ(n)`.
* It suffices to take x = N ∈ ℕ: M(x) = M(⌊x⌋) and √⌊x⌋ ≤ √x, so |M(x)| > C√x for real x ≥ 1
  gives |M(⌊x⌋)| > C√⌊x⌋ for C > 0, and integers are reals. For C ≤ 0 the condition is trivial
  (N = 1), as in the informal statement. "For every C there is such an x" is equivalent to
  limsup |M(x)|/√x = +∞ (for large C the witness is necessarily large, since M is bounded on
  any finite range).
* Proving Claim = unboundedness of M(x)/√x; ¬Claim = |M(N)| ≤ C√N for all N, for some C
  (which would imply RH, simplicity of zeros, and failure of linear independence).
-/
namespace OpenProblems.QEDE173
noncomputable section

/-- The Mertens function at a natural number. -/
def mertens (N : ℕ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, ((ArithmeticFunction.moebius n : ℤ) : ℝ)

def Claim : Prop :=
  ∀ C : ℝ, ∃ N : ℕ, C * Real.sqrt (N : ℝ) < |mertens N|

end
end OpenProblems.QEDE173
