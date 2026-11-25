import Mathlib
/-! QED-E172: Six cubes suffice for all large integers
Linnik proved in 1943 that every sufficiently large integer is a sum of at most seven cubes of
non-negative integers, and it is believed that four cubes suffice from some point on. Nobody has
proved even that six cubes suffice. Prove that every sufficiently large integer is a sum of six
cubes of non-negative integers.
Informal statement: There exists N₀ such that every integer n ≥ N₀ can be written as
n = x₁³ + ⋯ + x₆³ with x₁, …, x₆ ∈ ℤ_{≥0}; equivalently G(3) ≤ 6.
Formalization notes: Non-negative integers are `ℕ`; a representation is `x : Fin 6 → ℕ` with
`n = ∑ i, x i ^ 3`. Zero summands are allowed, so "at most six cubes" and "exactly six
non-negative cubes" coincide. Proving `Claim` = G(3) ≤ 6; `¬Claim` = infinitely many integers are
not sums of six non-negative cubes.
-/
namespace OpenProblems.QEDE172
noncomputable section

def Claim : Prop :=
  ∃ N₀ : ℕ, ∀ n : ℕ, N₀ ≤ n → ∃ x : Fin 6 → ℕ, n = ∑ i : Fin 6, x i ^ 3

end
end OpenProblems.QEDE172
