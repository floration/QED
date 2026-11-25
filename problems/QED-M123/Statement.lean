import Mathlib
/-! QED-M123: Halving planes in 3-space: beat n^{5/2}
Take n points in 3-space, with n odd and no four on a common plane. A halving triangle is a triple of the points whose plane splits the remaining n-3 points evenly, half on each side. The best upper bound on the number of halving triangles, about n^{5/2}, has not been improved since 2001. Show that the exponent 5/2 can be lowered.
Informal statement: For $S\subset\mathbb{R}^3$ with $|S|=n$ odd and no four points coplanar, let $h(S)$ be the number of $3$-subsets $T\subseteq S$ such that each open half-space bounded by $\operatorname{aff}(T)$ contains exactly $(n-3)/2$ points of $S$. Prove that there exist $\varepsilon>0$ and $C$ with $h(S)\le C\,n^{5/2-\varepsilon}$ for all such $S$.
Formalization notes:
* E = `EuclideanSpace ℝ (Fin 3)`. "No four coplanar": every 4-subset T has vector span of
  dimension 3 (`Module.finrank ℝ (vectorSpan ℝ T) = 3`), i.e. is affinely spanning.
  Consequently every 3-subset is affinely independent and spans a unique plane, and no
  fourth point of S lies on it.
* A plane is {x | ⟪a,x⟫ = b} with a ≠ 0. T is halving if some such plane contains T and
  has exactly (n−3)/2 points of S strictly on each side. Since aff(T) is the unique plane
  through T, this is exactly the informal definition. (n−3)/2 is natural division; n is odd
  and n ≥ 3 whenever a 3-subset exists, so it is exact.
* The bound is C·n^{5/2−ε} with real exponent (`Real.rpow`); C and ε are uniform in S.
  For n = 1 the count is 0, so small cases impose no extra constraint.
* `Claim` is the power-saving improvement of Sharir–Smorodinsky–Tardos. `¬Claim` says for every
  ε > 0 the exponent 5/2 − ε fails (the O(n^{5/2}) bound is tight up to n^{o(1)}).
-/
namespace OpenProblems.QEDM123
noncomputable section
open scoped InnerProductSpace RealInnerProductSpace

abbrev E := EuclideanSpace ℝ (Fin 3)

/-- No four points of `S` are coplanar. -/
def NoFourCoplanar (S : Finset E) : Prop :=
  ∀ T : Finset E, T ⊆ S → T.card = 4 → Module.finrank ℝ (vectorSpan ℝ (T : Set E)) = 3

/-- `T` is a halving triangle of `S`. -/
def IsHalving (S T : Finset E) : Prop :=
  ∃ (a : E) (b : ℝ), a ≠ 0 ∧ (∀ x ∈ T, ⟪a, x⟫_ℝ = b) ∧
    (S.filter (fun x : E => b < ⟪a, x⟫_ℝ)).card = (S.card - 3) / 2 ∧
    (S.filter (fun x : E => ⟪a, x⟫_ℝ < b)).card = (S.card - 3) / 2

open Classical in
/-- Number of halving triangles. -/
def h (S : Finset E) : ℕ :=
  ((S.powersetCard 3).filter (fun T : Finset E => IsHalving S T)).card

def Claim : Prop :=
  ∃ ε : ℝ, 0 < ε ∧ ∃ C : ℝ, ∀ S : Finset E, Odd S.card → NoFourCoplanar S →
    (h S : ℝ) ≤ C * (S.card : ℝ) ^ ((5 : ℝ) / 2 - ε)

end
end OpenProblems.QEDM123
