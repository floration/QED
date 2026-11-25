import Mathlib
/-! QED-E025: Turán density of K_4^- (the 2/7 conjecture)
Take a collection of triples from n points such that no 4 points carry 3 or more of their 4 triples. How large a fraction of all triples can you take? A recursive construction gets 2/7 and computer-aided proofs show you can't beat about 0.2868. Prove 2/7 is right, or beat it.
Informal statement: Let $K_4^-$ be the $3$-graph on 4 vertices with 3 edges and $\pi(K_4^-)=\lim_n \mathrm{ex}(n,K_4^-)/\binom n3$. Known: $2/7\le \pi(K_4^-)\le 0.2868$. Prove $\pi(K_4^-)=2/7$ (Frankl-Furedi/Mubayi conjecture), or improve the upper bound.
Formalization notes: K_4^- is the 3-graph on 4 vertices with 3 edges. H is K_4^--free iff every 4-set contains at most 2 edges of H (any 3 edges inside a 4-set form a K_4^-). Claim is the upper half of the conjecture: for every ε>0, for all large n, every K_4^--free 3-graph on Fin n has at most (2/7+ε)·C(n,3) edges, i.e. pi(K_4^-) <= 2/7. With the known lower bound, Claim ⟺ pi(K_4^-) = 2/7. ¬Claim means pi(K_4^-) > 2/7.
-/
namespace OpenProblems.QEDE025
def IsK4MinusFree {n : ℕ} (H : Finset (Finset (Fin n))) : Prop :=
  ∀ S : Finset (Fin n), S.card = 4 → (H.filter (fun e : Finset (Fin n) => e ⊆ S)).card ≤ 2

def Claim : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ N : ℕ, ∀ n : ℕ, N ≤ n →
    ∀ H : Finset (Finset (Fin n)), (∀ e ∈ H, e.card = 3) → IsK4MinusFree H →
      (H.card : ℝ) ≤ (2 / 7 + ε) * (n.choose 3 : ℝ)
end OpenProblems.QEDE025
