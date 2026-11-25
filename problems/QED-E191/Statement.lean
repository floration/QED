import Mathlib
/-! QED-E191: Do two triangular 2×2 matrices generate a free semigroup? Decide it
For rationals λ, μ consider D_λ = [[λ,0],[0,1]] and T_μ = [[μ,1],[0,1]]. Is there an algorithm
that decides, given (λ, μ), whether every two distinct words in D_λ, T_μ give distinct matrix
products?
Informal statement: For λ, μ ∈ ℚ let φ_{λ,μ} : {0,1}* → M₂(ℚ) be the monoid morphism with
0 ↦ D_λ and 1 ↦ T_μ. Let Φ = {(λ,μ) ∈ ℚ² : φ_{λ,μ} injective}. Determine whether Φ is a
decidable (recursive) subset of ℚ². A proof of either answer settles the problem.
Formalization notes: Words over {0,1} are `List Bool` (`false` ↦ D_λ, `true` ↦ T_μ), and
φ_{λ,μ}(w) is the ordered product of the corresponding matrices (`List.prod`, empty word ↦ 1);
this is exactly the free-monoid morphism. Rationals are input through the computable encoding
(a, b) ↦ a/(b+1) with a ∈ ℤ, b ∈ ℕ, which is surjective onto ℚ and whose inverse direction
(rational ↦ such a code) is computable, so decidability of Φ in this encoding is the same as
decidability of Φ ⊆ ℚ² in the usual sense (and avoids relying on a `Primcodable ℚ` instance).
Decidability is Mathlib's `ComputablePred` (computable by a partial recursive function).
`Claim` = Φ is decidable; `¬Claim` = Φ is undecidable. Both directions are open.
-/
namespace OpenProblems.QEDE191
noncomputable section

/-- The rational a/(b+1). -/
def decodeQ (c : ℤ × ℕ) : ℚ := (c.1 : ℚ) / ((c.2 : ℚ) + 1)

/-- The generator matrix for a letter: `false ↦ D_λ`, `true ↦ T_μ`. -/
def gen (l m : ℚ) (b : Bool) : Matrix (Fin 2) (Fin 2) ℚ :=
  if b then !![m, 1; 0, 1] else !![l, 0; 0, 1]

/-- The image φ_{λ,μ}(w) of a word. -/
def phi (l m : ℚ) (w : List Bool) : Matrix (Fin 2) (Fin 2) ℚ :=
  (w.map (gen l m)).prod

/-- (λ, μ) ∈ Φ: the morphism φ_{λ,μ} is injective (the semigroup ⟨D_λ, T_μ⟩ is free on them). -/
def InPhi (l m : ℚ) : Prop := Function.Injective (phi l m)

def Claim : Prop :=
  ComputablePred (fun c : (ℤ × ℕ) × (ℤ × ℕ) => InPhi (decodeQ c.1) (decodeQ c.2))

end
end OpenProblems.QEDE191
