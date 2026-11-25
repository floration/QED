import Mathlib
/-! QED-M063: Sofa stability
Baek (2024) proved that Gerver's sofa has the largest area among shapes that can be moved around a right-angled corner
in a hallway of width 1. Show that any moving sofa whose area is within ε of the maximum is, after a rigid motion,
within C·ε^α of Gerver's sofa in symmetric-difference area (which in particular gives uniqueness of the maximizer).
Informal statement: A moving sofa is a compact connected S ⊂ ℝ² that can be moved by a continuous rigid motion from
(-∞,0]×[0,1] to [0,1]×(-∞,0] inside L = ((-∞,1]×[0,1]) ∪ ([0,1]×(-∞,1]). Let G be Gerver's sofa, of area A_G ≈ 2.21953.
Prove there are C, α > 0 such that every moving sofa S with |S| ≥ A_G − ε satisfies min_g |gS △ G| ≤ C ε^α, the
minimum over rigid motions g of the plane.
Formalization notes: Gerver's sofa (18 analytic boundary pieces with transcendental parameters) is not written down.
Instead Claim asserts that SOME moving sofa G is stable in this sense with respect to the supremum `maxArea` of sofa
areas. This is equivalent to the problem given Baek's theorem: if Claim holds for G, then applying it to a maximizing
sequence shows area G = maxArea and that every maximizer coincides with G up to a rigid motion and a null set, so
G is (a.e.) Gerver's sofa and the stability holds for Gerver's sofa; conversely Gerver's sofa witnesses Claim if the
stability statement is true. A rigid motion is p ↦ R_θ p + a (rotations and translations; reflections are not needed
since Gerver's sofa is mirror symmetric). The motion of the sofa is a pair of continuous functions θ, a on ℝ, used
on the time interval [0,1]. Area is Lebesgue measure on ℝ × ℝ, converted with `toReal` (finite for compact sets).
The minimum over g is replaced by "there exists g", which is equivalent up to the existential constant C.
Proving Claim = stability (and uniqueness); proving ¬Claim = for every sofa G and every C, α > 0 there are sofas of
area ≥ maxArea − ε that are farther than C ε^α from every rigid copy of G (e.g. non-uniqueness of the maximizer, or a
non-power-law stability rate).
-/
namespace OpenProblems.QEDM063

/-- Rotation of the plane by angle `θ`. -/
noncomputable def rot (θ : ℝ) (p : ℝ × ℝ) : ℝ × ℝ :=
  (Real.cos θ * p.1 - Real.sin θ * p.2, Real.sin θ * p.1 + Real.cos θ * p.2)

/-- The rigid motion `p ↦ R_θ p + a`. -/
noncomputable def motion (θ : ℝ) (a : ℝ × ℝ) (p : ℝ × ℝ) : ℝ × ℝ := rot θ p + a

/-- The L-shaped hallway `((-∞,1] × [0,1]) ∪ ([0,1] × (-∞,1])`. -/
def hallway : Set (ℝ × ℝ) :=
  {p | (p.1 ≤ 1 ∧ 0 ≤ p.2 ∧ p.2 ≤ 1) ∨ (0 ≤ p.1 ∧ p.1 ≤ 1 ∧ p.2 ≤ 1)}

/-- The starting arm `(-∞,0] × [0,1]`. -/
def startArm : Set (ℝ × ℝ) := {p | p.1 ≤ 0 ∧ 0 ≤ p.2 ∧ p.2 ≤ 1}

/-- The final arm `[0,1] × (-∞,0]`. -/
def endArm : Set (ℝ × ℝ) := {p | 0 ≤ p.1 ∧ p.1 ≤ 1 ∧ p.2 ≤ 0}

/-- `S` is a moving sofa: compact, connected, and movable through the hallway by a continuous rigid motion. -/
def IsMovingSofa (S : Set (ℝ × ℝ)) : Prop :=
  IsCompact S ∧ IsConnected S ∧
    ∃ θ : ℝ → ℝ, ∃ a : ℝ → ℝ × ℝ, Continuous θ ∧ Continuous a ∧
      (∀ t ∈ Set.Icc (0 : ℝ) 1, motion (θ t) (a t) '' S ⊆ hallway) ∧
      motion (θ 0) (a 0) '' S ⊆ startArm ∧
      motion (θ 1) (a 1) '' S ⊆ endArm

/-- Lebesgue area as a real number. -/
noncomputable def area (S : Set (ℝ × ℝ)) : ℝ := (MeasureTheory.volume S).toReal

/-- The supremum of the areas of moving sofas (equal to Gerver's constant by Baek's theorem). -/
noncomputable def maxArea : ℝ := sSup {r : ℝ | ∃ S : Set (ℝ × ℝ), IsMovingSofa S ∧ area S = r}

def Claim : Prop :=
  ∃ G : Set (ℝ × ℝ), IsMovingSofa G ∧
    ∃ C α : ℝ, 0 < C ∧ 0 < α ∧
      ∀ S : Set (ℝ × ℝ), IsMovingSofa S → ∀ ε : ℝ, 0 < ε → maxArea - ε ≤ area S →
        ∃ θ : ℝ, ∃ a : ℝ × ℝ,
          area ((motion θ a '' S \ G) ∪ (G \ motion θ a '' S)) ≤ C * ε ^ α

end OpenProblems.QEDM063
