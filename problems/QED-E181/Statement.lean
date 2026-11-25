import Mathlib
/-! QED-E181: Is Out(F_3) linear?
The outer automorphism group of the free group on three letters, Out(F_3), is a basic finitely presented group in geometric group theory. Does it have a faithful representation by complex matrices of some size? For two letters it does (it is GL_2(Z)). For four or more letters it does not, because it then contains Aut(F_3), which Formanek and Procesi showed is not linear. Three letters is the single open case.
Informal statement: Let $F_3$ be the free group of rank $3$ and $\mathrm{Out}(F_3)=\mathrm{Aut}(F_3)/\mathrm{Inn}(F_3)$. Determine whether there exist $m\in\mathbb N$ and an injective group homomorphism $\mathrm{Out}(F_3)\hookrightarrow \mathrm{GL}_m(\mathbb C)$.
Formalization notes:
* `F3 := FreeGroup (Fin 3)`, `Aut(F3) := MulAut F3` (group automorphisms), and
  `Inn(F3)` is the range of `MulAut.conj : F3 →* MulAut F3` (inner automorphisms).
* To avoid building the quotient group (and its normality instance), we use the equivalent
  formulation: an injective homomorphism `Aut/Inn → GL_m(ℂ)` is the same as a homomorphism
  `φ : Aut(F3) →* GL_m(ℂ)` with kernel exactly `Inn(F3)` (first isomorphism theorem: any
  such φ factors injectively through the quotient, and any injective ψ on the quotient
  composed with the projection has kernel Inn).
* `GL_m(ℂ)` is `Matrix.GeneralLinearGroup (Fin m) ℂ`. m = 0 gives the trivial group, whose
  kernel is everything ≠ Inn (Inn is a proper subgroup), so it is not a loophole.
* Proving `Claim` = Out(F_3) is linear over ℂ. Proving `¬Claim` = Out(F_3) is not linear
  over ℂ.
-/
namespace OpenProblems.QEDE181
noncomputable section

/-- The free group of rank 3. -/
abbrev F3 : Type := FreeGroup (Fin 3)

/-- The inner automorphism subgroup of `Aut(F3)`. -/
def Inn : Subgroup (MulAut F3) := (MulAut.conj : F3 →* MulAut F3).range

def Claim : Prop :=
  ∃ (m : ℕ) (φ : MulAut F3 →* Matrix.GeneralLinearGroup (Fin m) ℂ), φ.ker = Inn

end
end OpenProblems.QEDE181
