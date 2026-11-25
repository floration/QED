import Mathlib
/-! QED-E058: Does the variance of the LCS of two random binary strings tend to infinity?
Pick two independent uniformly random binary strings of length n and let L_n be the length of their longest common subsequence. Its mean is about 0.81n and its variance is at most n/4. Show that the variance tends to infinity, i.e. that L_n is not concentrated within a bounded window around its mean. (Linear order of the variance is believed, but even unboundedness is open.)
Informal statement: For independent uniform $X,Y\in\{0,1\}^n$ let $L_n=\mathrm{LCS}(X,Y)$. Prove that $\lim_{n\to\infty}\mathrm{Var}(L_n)=\infty$. (Known: $\mathrm{Var}(L_n)\le n/4$; the stronger $\mathrm{Var}(L_n)\ge cn$ is the uniform case of Waterman's conjecture.)
Formalization notes:
* `lcs x y` = maximum length of a list l that is a sublist (subsequence, `List.Sublist`, not
  necessarily contiguous) of both x and y; computed as the sup of `List.length` over the
  sublists of x that are sublists of y (the empty list always qualifies, so this is a genuine
  maximum). This is the standard LCS length.
* Strings are `Fin n → Bool`, turned into lists by `List.ofFn`. The uniform product measure on
  pairs is counting over the 4^n pairs: `mean n` = Σ L / 4^n, `second n` = Σ L² / 4^n,
  `var n = second n − mean n²` (exact variance, a finite sum; no probability library needed).
* `Claim` : `var n → ∞` (`Filter.Tendsto var atTop atTop`), i.e. for every M, var n ≥ M for all
  large n. This is the liminf = ∞ reading; the limit is not known to exist a priori, and
  Tendsto to `atTop` is exactly "lim = ∞". Proving `¬Claim`: Var(L_n) stays bounded along some
  subsequence. (The candidate's sketch stated the stronger Var ≥ c n; we follow the vetted
  informal statement, which asks only for unboundedness.)
-/
namespace OpenProblems.QEDE058
noncomputable section
open scoped Classical

/-- Length of a longest common subsequence of two lists. -/
def lcs (x y : List Bool) : ℕ :=
  (x.sublists.toFinset.filter (fun l : List Bool => List.Sublist l y)).sup List.length

/-- `L_n(X,Y)`. -/
def L {n : ℕ} (X Y : Fin n → Bool) : ℕ := lcs (List.ofFn X) (List.ofFn Y)

/-- `E[L_n]` for independent uniform `X, Y`. -/
def mean (n : ℕ) : ℝ :=
  (∑ X : Fin n → Bool, ∑ Y : Fin n → Bool, (L X Y : ℝ)) / (4 : ℝ) ^ n

/-- `E[L_n^2]`. -/
def second (n : ℕ) : ℝ :=
  (∑ X : Fin n → Bool, ∑ Y : Fin n → Bool, (L X Y : ℝ) ^ 2) / (4 : ℝ) ^ n

/-- `Var(L_n)`. -/
def var (n : ℕ) : ℝ := second n - mean n ^ 2

def Claim : Prop := Filter.Tendsto var Filter.atTop Filter.atTop

end
end OpenProblems.QEDE058
