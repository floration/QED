import Mathlib
/-! QED-E165: Inducibility of the 4-vertex path
Pick 4 vertices at random from a large graph; how likely is it that they induce exactly a path a-b-c-d (with no other edges among them)? The inducibility of P4 is the largest this probability can be in the limit. For every other graph on 4 vertices the answer is known, but for P4 it is only known to lie between about 0.2014 and 0.2033. Determine it.
Informal statement: For a graph $G$ on $n\ge4$ vertices let $d(G)$ be the fraction of 4-subsets of $V(G)$ that induce a copy of $P_4$, and let $\lambda_{P_4}=\lim_{n\to\infty}\max_{|G|=n} d(G)$ (the maxima are non-increasing in $n$, so the limit exists). Known: $1173/5824=0.20140\ldots\le\lambda_{P_4}\le 0.20332375$. Determine $\lambda_{P_4}$; in particular decide whether $\lambda_{P_4}=1173/5824$.
Formalization notes:
* Graphs on n vertices: `SimpleGraph (Fin n)` (all notions are isomorphism invariant).
* A 4-set `S` induces P₄ iff there is an injective `f : Fin 4 → Fin n` with image `S` such that
  `G.Adj (f a) (f b) ↔ |a - b| = 1` for all `a b : Fin 4` (an isomorphism from the path
  0-1-2-3 onto `G[S]`). `indP4 G` counts such 4-sets.
* `M n` = max over graphs on `Fin n` of `indP4 G / C(n,4)`, written as a real `iSup` over the
  finite type of graphs; the values lie in [0,1], so this is a genuine maximum. For n < 4 it is
  the junk value 0, irrelevant to the limit.
* `M n` is non-increasing for n ≥ 4 (averaging over (n-1)-vertex subgraphs), so
  λ = lim M n exists. The formalized target is the binary decision in the informal statement:
  Claim := `M n → 1173/5824`, i.e. λ_{P4} = 1173/5824 (the Even-Zohar–Linial construction is
  optimal). ¬Claim = λ_{P4} > 1173/5824 (by the known lower bound), i.e. a better construction
  exists. Determining the exact value in the ¬Claim case is not part of the formal statement.
-/
namespace OpenProblems.QEDE165
noncomputable section
open scoped Classical

/-- `S` induces a copy of the path 0-1-2-3 in `G`. -/
def InducesP4 {n : ℕ} (G : SimpleGraph (Fin n)) (S : Finset (Fin n)) : Prop :=
  ∃ f : Fin 4 → Fin n, Function.Injective f ∧ Finset.univ.image f = S ∧
    ∀ a b : Fin 4, (G.Adj (f a) (f b) ↔ (a.val + 1 = b.val ∨ b.val + 1 = a.val))

/-- Number of induced copies of P₄ (as 4-vertex sets). -/
def indP4 {n : ℕ} (G : SimpleGraph (Fin n)) : ℕ :=
  ((Finset.univ : Finset (Finset (Fin n))).filter
    (fun S : Finset (Fin n) => S.card = 4 ∧ InducesP4 G S)).card

/-- Maximum induced P₄-density over graphs on `n` vertices. -/
def M (n : ℕ) : ℝ :=
  ⨆ G : SimpleGraph (Fin n), (indP4 G : ℝ) / (Nat.choose n 4 : ℝ)

def Claim : Prop :=
  Filter.Tendsto M Filter.atTop (nhds ((1173 : ℝ) / 5824))

end
end OpenProblems.QEDE165
