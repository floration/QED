import Mathlib
/-! QED-M122: The widest hollow body in 3-space
A convex body is hollow if no point with all-integer coordinates lies strictly inside it. Hollow bodies must be thin in some integer direction (the flatness theorem). In the plane the largest guaranteed thinness is known exactly, 1+2/sqrt(3). In 3-space a hollow tetrahedron of lattice width 2+sqrt(2) is known: is that the widest possible?
Informal statement: For a convex body (compact, convex, nonempty interior) $K\subset\mathbb{R}^3$ and $u\in\mathbb{Z}^3\setminus\{0\}$ let $w_u(K)=\max_{x\in K}\langle u,x\rangle-\min_{x\in K}\langle u,x\rangle$ and $w(K)=\min_{u\neq0}w_u(K)$. Call $K$ hollow if $\operatorname{int}K\cap\mathbb{Z}^3=\emptyset$. Prove or disprove: every hollow convex body $K\subset\mathbb{R}^3$ satisfies $w(K)\le 2+\sqrt2$. (Equivalently $\mathrm{Flt}(3)=2+\sqrt2$; known: $2+\sqrt2\le\mathrm{Flt}(3)<3.972$.)
Formalization notes:
* ℝ³ is modelled as Fin 3 → ℝ; its product topology is the Euclidean one, so `interior` is the usual interior.
  A convex body is K convex, compact, with nonempty interior. Hollow: no integer point (fun i => (z i : ℝ)) lies in
  interior K.
* w_u(K) = max_K ⟨u,·⟩ − min_K ⟨u,·⟩ = sup_{x,y∈K} ⟨u, x−y⟩, so w_u(K) ≤ c ⇔ ∀ x y ∈ K, ⟨u,x−y⟩ ≤ c. The lattice width
  w(K) = min over u ∈ ℤ³∖{0} is attained (w_u is a norm of u when K has interior, so only finitely many u give
  w_u below any bound). Hence w(K) ≤ 2+√2 ⇔ ∃ u ≠ 0 with w_u(K) ≤ 2+√2, which is what `Claim` states.
* `Claim`: every hollow convex body in ℝ³ has lattice width ≤ 2+√2, i.e. Flt(3) ≤ 2+√2; with the known hollow
  tetrahedron, Claim ⇔ Flt(3) = 2+√2. ¬Claim = a hollow convex body of lattice width > 2+√2 exists.
-/
namespace OpenProblems.QEDM122
noncomputable section

def Claim : Prop :=
  ∀ K : Set (Fin 3 → ℝ), Convex ℝ K → IsCompact K → (interior K).Nonempty →
    (∀ z : Fin 3 → ℤ, (fun i : Fin 3 => (z i : ℝ)) ∉ interior K) →
    ∃ u : Fin 3 → ℤ, u ≠ 0 ∧
      ∀ x ∈ K, ∀ y ∈ K, ∑ i : Fin 3, (u i : ℝ) * (x i - y i) ≤ 2 + Real.sqrt 2

end
end OpenProblems.QEDM122
