import Mathlib
/-! N-704: Interval-sieve extremal bounds behind the Banks-Ford-Tao gap prediction
W_y is the fewest survivors in [0, y] after one residue class is removed for each prime up to
√(y / log y). Banks, Ford and Tao show W_y controls the random-model prediction for the largest
prime gaps. Is W_y of order y / log y?
Informal statement: Let W_y = min over residue choices (a_p) of #{n ∈ [0,y] ∩ ℤ : n ≢ a_p (mod p) for all primes p <= (y/log y)^{1/2}}. Known (Banks-Ford-Tao): (4+o(1)) y log log y/log^2 y <= W_y <= y/log y + O(y log log y/log^2 y). Prove or disprove: there is an absolute c > 0 with W_y >= c·y/log y for all sufficiently large y.
Formalization notes: Integers in [0, y] are the naturals m <= ⌊y⌋. A residue choice is any
function a : ℕ → ℕ, with a p read modulo p (this covers all choices of one class per prime).
Survivors are m with m ≢ a p (mod p) for every prime p with p <= √(y / log y). The lower bound
W_y >= c y / log y is encoded as: for all large real y and all residue choices, the number of
survivors is at least c y / log y (so the minimum need not be defined). Proving Claim gives the
order-of-magnitude lower bound; proving ¬Claim gives, for every c > 0, arbitrarily large y with
W_y < c y / log y (i.e. liminf W_y log y / y = 0), which is slightly weaker than the original
alternative W_y = o(y / log y).
-/
namespace OpenProblems.N704

/-- Survivors in [0, y] of the sieve removing the class `a p mod p` for each prime
`p <= √(y / log y)`. -/
def survivors (y : ℝ) (a : ℕ → ℕ) : Set ℕ :=
  {m : ℕ | m ≤ ⌊y⌋₊ ∧ ∀ p : ℕ, p.Prime → (p : ℝ) ≤ Real.sqrt (y / Real.log y) →
    ¬ (m ≡ a p [MOD p])}

def Claim : Prop :=
  ∃ c : ℝ, 0 < c ∧ ∃ Y : ℝ, ∀ y : ℝ, Y ≤ y → ∀ a : ℕ → ℕ,
    c * y / Real.log y ≤ ((survivors y a).ncard : ℝ)

end OpenProblems.N704
