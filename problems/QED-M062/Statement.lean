import Mathlib
/-! QED-M062: How nearly can tetrahedra close up: the exponent
Glue regular tetrahedra face to face in a chain of length n; it never closes exactly. Let g(n) be the best gap after n
steps and κ the exponential rate of the running minimum, in base 3. Short arguments give 1/12 ≤ κ ≤ 1/2; counting
heuristics suggest κ = 1/6. The task is to narrow the range; Claim is the strict improvement of the lower bound.
Informal statement (corrected): Let g(k) be the minimal distance between T_k and T_0 over non-backtracking face-reflection
chains of length k, and κ := liminf_n −(1/n) log₃ min_{1≤k≤n} g(k). Known: 1/12 ≤ κ ≤ 1/2. Prove κ > 1/12.
Formalization notes: The tetrahedron is stored as a labelled vertex tuple P : Fin 4 → ℝ³, starting from the regular
tetrahedron P0 with vertices (1,1,1), (1,−1,−1), (−1,1,−1), (−1,−1,1). Reflecting across the face opposite vertex i
replaces Pᵢ by (2/3)·Σ_{j≠i} Pⱼ − Pᵢ (twice the face centroid minus Pᵢ; exact for regular tetrahedra, and every Tₖ
is regular). The new vertex keeps label i, so crossing the same face twice in a row undoes the step: chains are
lists of labels with no two consecutive equal (`NonBacktracking`), applied left to right. Distance between Tₖ and T₀
is `matchDist`: the minimum over relabellings σ of max_i ‖Pᵢ − P0_{σ(i)}‖_∞ (sup norm on Fin 3 → ℝ). For congruent
regular tetrahedra this is comparable, up to absolute constants, to the Hausdorff distance between the solids used
in the problem, and the edge length is fixed (2√2 instead of 1); neither affects κ. The liminf condition κ > 1/12 is
encoded with explicit δ, N: for all large n some chain of length between 1 and n has distance ≤ 3^{−(1/12+δ)n}.
Proving Claim = κ > 1/12; proving ¬Claim = κ = 1/12 exactly (by the known lower bound), i.e. for every δ > 0 there are
infinitely many n where every chain of length ≤ n stays at distance > 3^{−(1/12+δ)n}.
-/
namespace OpenProblems.QEDM062

/-- The initial regular tetrahedron `T₀` (edge length `2√2`). -/
noncomputable def P0 : Fin 4 → (Fin 3 → ℝ) :=
  ![![1, 1, 1], ![1, -1, -1], ![-1, 1, -1], ![-1, -1, 1]]

/-- Reflect the (regular) tetrahedron `P` across the face opposite vertex `i`. -/
noncomputable def reflectStep (P : Fin 4 → (Fin 3 → ℝ)) (i : Fin 4) : Fin 4 → (Fin 3 → ℝ) :=
  Function.update P i ((2 / 3 : ℝ) • (∑ j ∈ Finset.univ.erase i, P j) - P i)

/-- The last tetrahedron of the chain with face labels `l`, starting from `T₀`. -/
noncomputable def chainEnd (l : List (Fin 4)) : Fin 4 → (Fin 3 → ℝ) := l.foldl reflectStep P0

/-- No two consecutive face labels are equal. -/
def NonBacktracking : List (Fin 4) → Prop
  | [] => True
  | [_] => True
  | a :: b :: l => a ≠ b ∧ NonBacktracking (b :: l)

/-- Distance between two labelled tetrahedra as unlabelled vertex sets (best matching, sup norm). -/
noncomputable def matchDist (P Q : Fin 4 → (Fin 3 → ℝ)) : ℝ :=
  ⨅ σ : Equiv.Perm (Fin 4), ⨆ i : Fin 4, dist (P i) (Q (σ i))

def Claim : Prop :=
  ∃ δ : ℝ, 0 < δ ∧ ∃ N : ℕ, ∀ n : ℕ, N ≤ n →
    ∃ l : List (Fin 4), NonBacktracking l ∧ 1 ≤ l.length ∧ l.length ≤ n ∧
      matchDist (chainEnd l) P0 ≤ (3 : ℝ) ^ (-(1 / 12 + δ) * (n : ℝ))

end OpenProblems.QEDM062
