import Mathlib
/-! QED-E039: Cover any 3D convex body with 13 smaller copies
Every convex body in 3-space can be covered by 13 smaller positive homothetic copies of itself.
Informal statement: For a convex body $K\subset\mathbb R^3$ let $H(K)$ be the least $m$ with $K\subseteq\bigcup_{i=1}^m(\lambda K+t_i)$ for some $0<\lambda<1$. Prove $\sup_K H(K)\le 13$.
Formalization notes: A convex body is a compact convex set with nonempty interior in `EuclideanSpace ℝ (Fin 3)`. One common ratio r is used for all copies; this is equivalent to allowing ratios r_i < 1 (take r = max r_i, and note that for convex K, k₀ ∈ K and r_i ≤ r one has r_i K ⊆ r K + (r_i - r) k₀). Claim = H_3 ≤ 13; ¬Claim = some convex body needs at least 14 copies.
-/
namespace OpenProblems.QEDE039

abbrev E3 := EuclideanSpace ℝ (Fin 3)

def Claim : Prop :=
  ∀ K : Set E3, Convex ℝ K → IsCompact K → (interior K).Nonempty →
    ∃ (r : ℝ) (t : Fin 13 → E3), 0 < r ∧ r < 1 ∧
      K ⊆ ⋃ i : Fin 13, (fun x : E3 => r • x + t i) '' K

end OpenProblems.QEDE039
