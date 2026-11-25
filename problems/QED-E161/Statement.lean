import Mathlib
/-! QED-E161: Super-exponential anticoncentration of the random ±1 permanent at zero
Fill an n by n matrix with independent random signs ±1 and compute its permanent. In 2025 the
probability that the permanent is 0 was shown to be exponentially small. Is it super-exponentially
small, i.e. smaller than e^(-Cn) for every fixed C once n is large?
Informal statement: Let p_n = 2^{-n²} · #{M ∈ {±1}^{n×n} : per M = 0}, where
per M = ∑_{π ∈ S_n} ∏_i M_{i,π(i)}. Prove or disprove: for every C > 0 there is N such that
p_n ≤ e^{-Cn} for all n ≥ N (equivalently (1/n) log p_n → -∞, with log 0 = -∞).
Known: p_n ≤ e^{-cn} for some absolute c > 0 (Hunter–Kwan–Sauermann 2025).
Formalization notes: A sign matrix is encoded as `s : Fin n → Fin n → Bool` with entry
`+1` for `true` and `-1` for `false` (a bijection {±1}^{n×n} ≃ Bool^{n×n}). The permanent is
defined by hand as ∑_{σ ∈ Perm (Fin n)} ∏_i M i (σ i) over ℤ (the same as Mathlib's
`Matrix.permanent` up to transposition, which does not change the value). `zeroProb n` is the
exact counting probability p_n as a real number (uniform measure on the 2^{n²} sign matrices).
p_n = 0 is allowed (it happens for n = 3, 7) and trivially satisfies the bound. `Claim` is the
super-exponential decay statement (Vu's Conjecture 6.12); `¬Claim` means there is C > 0 with
p_n > e^{-Cn} for infinitely many n.
-/
namespace OpenProblems.QEDE161
noncomputable section

/-- The ±1 matrix attached to a Boolean matrix. -/
def signMat {n : ℕ} (s : Fin n → Fin n → Bool) : Fin n → Fin n → ℤ :=
  fun i j => if s i j then 1 else -1

/-- The permanent of an integer matrix. -/
def perm {n : ℕ} (M : Fin n → Fin n → ℤ) : ℤ :=
  ∑ σ : Equiv.Perm (Fin n), ∏ i : Fin n, M i (σ i)

/-- `p_n`: the probability that a uniformly random n×n ±1 matrix has permanent zero. -/
def zeroProb (n : ℕ) : ℝ :=
  ((Finset.univ.filter (fun s : Fin n → Fin n → Bool => perm (signMat s) = 0)).card : ℝ) /
    (2 : ℝ) ^ (n ^ 2)

def Claim : Prop :=
  ∀ C : ℝ, 0 < C → ∃ N : ℕ, ∀ n : ℕ, N ≤ n → zeroProb n ≤ Real.exp (-C * (n : ℝ))

end
end OpenProblems.QEDE161
