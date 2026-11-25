import Mathlib
/-! QED-E066: Returning to the identity in SL(3,Z)
You are given finitely many 3x3 integer matrices with determinant 1. Can some nonempty product of them (in any order, with repetition) equal the identity matrix? For 2x2 matrices there is an algorithm, and for 4x4 matrices it is known that none exists. Decide whether an algorithm exists for 3x3.
Informal statement: Let $\mathcal I_3=\{(M_1,\dots,M_k): k\ge1,\ M_i\in SL(3,\mathbb Z),\ \exists\, m\ge1,\ i_1,\dots,i_m\in\{1,\dots,k\}:\ M_{i_1}\cdots M_{i_m}=I_3\}$, with instances given as finite lists of integer matrices. Is $\mathcal I_3$ decidable? Board Claim: $\mathcal I_3$ is decidable.
Formalization notes:
* Instances are `List (Fin 3 → Fin 3 → ℕ)`: a list of 3×3 arrays of natural numbers, each entry
  decoded to an integer by the zig-zag bijection `zz : ℕ → ℤ` (`2n ↦ n`, `2n+1 ↦ -(n+1)`). This is a
  computable bijection, so it is just a `Primcodable` encoding of lists of integer matrices (it
  avoids relying on a `Primcodable ℤ` / `Matrix` instance). `toMat` turns an array into a
  `Matrix (Fin 3) (Fin 3) ℤ`.
* `Ident3 L`: every matrix in `L` has determinant 1 (membership in `SL(3,ℤ)`), and some NONEMPTY
  word `w` in the indices of `L` (repetition allowed, any order) has product `1`. The empty list
  is automatically a no-instance (`Fin 0` admits no nonempty word), matching `k ≥ 1`. Lists
  containing a matrix of determinant `≠ 1` are no-instances; since the determinant test is
  computable this does not change decidability (it is the language $\mathcal I_3$ literally).
* `List.prod` multiplies left to right, `M_{i_1} ⋯ M_{i_m}`; the order convention is irrelevant
  for the identity problem anyway (reverse words).
* Decidability is Mathlib's `ComputablePred`. `Claim` = the identity problem for `SL(3,ℤ)` is
  decidable; `¬Claim` = it is undecidable. The predicate is r.e. (enumerate words), so the content
  is co-r.e.-ness / an algorithm; neither side is trivial.
-/
namespace OpenProblems.QEDE066
noncomputable section

/-- Zig-zag bijection `ℕ → ℤ`: `2n ↦ n`, `2n+1 ↦ -(n+1)`. -/
def zz (n : ℕ) : ℤ :=
  if n % 2 = 0 then ((n / 2 : ℕ) : ℤ) else -((n / 2 : ℕ) : ℤ) - 1

/-- The integer matrix encoded by a 3×3 array of codes. -/
def toMat (A : Fin 3 → Fin 3 → ℕ) : Matrix (Fin 3) (Fin 3) ℤ :=
  Matrix.of (fun i j : Fin 3 => zz (A i j))

/-- `L` is a list of `SL(3,ℤ)` matrices some nonempty product of which is the identity. -/
def Ident3 (L : List (Fin 3 → Fin 3 → ℕ)) : Prop :=
  (∀ A ∈ L, (toMat A).det = 1) ∧
    ∃ w : List (Fin L.length), w ≠ [] ∧
      (w.map (fun i : Fin L.length => toMat (L.get i))).prod = 1

/-- The identity problem for `SL(3,ℤ)` is decidable. -/
def Claim : Prop :=
  ComputablePred Ident3

end
end OpenProblems.QEDE066
