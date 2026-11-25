import Mathlib
/-! QED-E216: A biplane with more than 13 points per block
A biplane is a family of v blocks, each a k-element subset of a v-point set, such that every two blocks share exactly two points (equivalently every two points lie in exactly two blocks). Only sixteen nontrivial biplanes are known, all with k ≤ 13. Is there a biplane with larger blocks? The smallest open case is v = 121, k = 16.
Informal statement: Does there exist a symmetric $2$-$(v,k,2)$ design with $k\ge14$, i.e. $v$ distinct $k$-subsets of a $v$-set with $k(k-1)=2(v-1)$, $k\ge14$, any two of which meet in exactly $2$ points? (Bruck–Ryser–Chowla excludes $k=14,15$; the first open case is $(v,k)=(121,16)$.)
Formalization notes: Points are `Fin v`; the block family is a `Finset (Finset (Fin v))`, so blocks are
automatically distinct, and it has exactly v blocks, each of size k, any two distinct blocks meeting in exactly
2 points. By Ryser's dual theorem (the incidence matrix N satisfies N Nᵀ = (k−2)I + 2J, is invertible for
k > 2, hence Nᵀ N = (k−2)I + 2J too), this is the same as a symmetric 2-(v,k,2) design; the parameter relation
k(k−1) = 2(v−1) is then automatic but is included explicitly. Claim (existence) true means some biplane with
k ≥ 14 exists (e.g. a (121,16,2) biplane); ¬Claim means no biplane has k ≥ 14 at all.
-/
namespace OpenProblems.QEDE216
noncomputable section

/-- `B` is a family of `v` blocks of size `k` in a `v`-point set, any two distinct blocks meeting in
exactly two points: a biplane. -/
def IsBiplane (v k : ℕ) (B : Finset (Finset (Fin v))) : Prop :=
  B.card = v ∧ (∀ b ∈ B, b.card = k) ∧ ∀ b ∈ B, ∀ c ∈ B, b ≠ c → (b ∩ c).card = 2

def Claim : Prop :=
  ∃ v k : ℕ, 14 ≤ k ∧ k * (k - 1) = 2 * (v - 1) ∧
    ∃ B : Finset (Finset (Fin v)), IsBiplane v k B

end
end OpenProblems.QEDE216
