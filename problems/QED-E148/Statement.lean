import Mathlib
/-! QED-E148: Largest lattice 4-polytope with one interior lattice point
Take a polytope in 4-dimensional space whose corners all have integer coordinates and which contains exactly one integer point in its interior. How large can its volume be? The best known example is the simplex with vertices 0, 2e1, 3e2, 7e3, 84e4, of volume 147, and it is known to be the largest among simplices. Is it the largest among all such polytopes?
Informal statement: Let $P=\operatorname{conv}(V)\subset\mathbb{R}^4$ with $V\subset\mathbb{Z}^4$ finite and $|\operatorname{int}(P)\cap\mathbb{Z}^4|=1$. Prove that $\operatorname{vol}_4(P)\le 147=\tfrac{2(s_4-1)^2}{4!}$, where $s_1=2,s_2=3,s_3=7,s_4=43$ are the Sylvester numbers. Equality holds for $\operatorname{conv}(0,2e_1,3e_2,7e_3,84e_4)$.
Formalization notes: ℝ⁴ is modelled as `Fin 4 → ℝ`. Its product topology equals the
Euclidean topology, so `interior` is the usual interior, and `MeasureTheory.volume` on it is
the product Lebesgue measure, i.e. Euclidean 4-volume. Lattice points are `Fin 4 → ℤ`,
embedded coordinatewise. `P` is the real convex hull of the image of a finite set `V` of
lattice points. The hypothesis counts lattice points `z` whose image lies in `interior P`;
`Set.ncard = 1` means exactly one (the set is finite since `P` is bounded, and if `P` is
lower-dimensional its interior is empty and the hypothesis fails). The bound is stated in
`ENNReal` to avoid any `toReal` junk; 147 = 2·3·7·84/4! is attained by the
Zaks–Perles–Wills simplex. Claim = the conjectured sharp bound in dimension 4;
¬Claim = a lattice 4-polytope with exactly one interior lattice point and volume > 147.
-/
namespace OpenProblems.QEDE148
noncomputable section

/-- Embed an integer point of ℤ⁴ into ℝ⁴. -/
def toR (z : Fin 4 → ℤ) : Fin 4 → ℝ := fun i : Fin 4 => (z i : ℝ)

/-- The lattice polytope with vertex set (contained in) `V`. -/
def poly (V : Finset (Fin 4 → ℤ)) : Set (Fin 4 → ℝ) :=
  convexHull ℝ (toR '' (V : Set (Fin 4 → ℤ)))

def Claim : Prop :=
  ∀ V : Finset (Fin 4 → ℤ),
    Set.ncard {z : Fin 4 → ℤ | toR z ∈ interior (poly V)} = 1 →
      MeasureTheory.volume (poly V) ≤ (147 : ENNReal)

end
end OpenProblems.QEDE148
