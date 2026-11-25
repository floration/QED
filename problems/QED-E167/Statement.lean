import Mathlib
/-! QED-E167: Hamilton decompositions of 6-regular abelian Cayley graphs of even order
Take a finite abelian group of even order and a set S of 6 nonzero elements, closed under negation, that generates the group; join x to x+s for each s in S. The resulting connected 6-regular Cayley graph is predicted to split into 3 edge-disjoint Hamilton cycles. This is proved for all 4-regular such graphs and for 6-regular ones on groups of odd order, but only special even-order cases are known. Prove it for every abelian group of even order.
Informal statement: Let $A$ be a finite abelian group with $|A|$ even, and $S\subseteq A\setminus\{0\}$ with $S=-S$, $|S|=6$, $\langle S\rangle=A$. Let $\Gamma=\mathrm{Cay}(A,S)$ be the simple graph with edges $\{x,x+s\}$, $s\in S$ (an involution $s\in S$ gives one edge at each vertex, so $\Gamma$ is $6$-regular). Prove that $E(\Gamma)$ can be partitioned into three Hamilton cycles.
Formalization notes:
* Groups: `A : Type` with `[AddCommGroup A] [Fintype A]` (every finite abelian group is
  isomorphic to one in `Type`). Hypotheses: `Even (Fintype.card A)`, `0 ∉ S`, `S` closed under
  negation, `S.card = 6`, and `AddSubgroup.closure S = ⊤` (S generates A).
* Cayley graph: `cay S` has `x ~ y` iff `x ≠ y ∧ y - x ∈ S ∧ x - y ∈ S` (written symmetrically
  so that symmetry needs no hypothesis); under `S = -S` this is just `x ≠ y ∧ y - x ∈ S`.
  Its edge set is exactly {{x, x+s} : s ∈ S}. (Since |A| ≥ 7 here, Hamilton cycles have length
  ≥ 8, so no degeneracies.)
* Hamilton cycle, as an edge set: `C` is a Hamilton cycle of `A` iff there is a bijection
  `σ : ZMod N → A` (N = |A|, a cyclic ordering of all vertices) with
  `C = {s(σ i, σ (i+1)) | i}`. For N ≥ 3 this is exactly the edge set of a cycle through all
  vertices. (We do not require C ⊆ E(Γ) separately; it is implied by the partition below.)
* Decomposition: a colouring `col : Sym2 A → Fin 3` such that for each colour `i`, the set of
  edges of Γ with colour `i` is a Hamilton cycle. Since every edge gets exactly one colour,
  this is exactly a partition of E(Γ) into three Hamilton cycles.
* Proving `Claim` = the even-order valency-6 case of Alspach's conjecture for abelian groups.
  Proving `¬Claim` = an even-order connected 6-valent abelian Cayley graph with no Hamilton
  decomposition.
-/
namespace OpenProblems.QEDE167
noncomputable section

/-- The Cayley graph `Cay(A, S)` (undirected; symmetric when `S = -S`). -/
def cay {A : Type} [AddCommGroup A] (S : Finset A) : SimpleGraph A :=
  SimpleGraph.fromRel (fun x y => y - x ∈ S ∧ x - y ∈ S)

/-- `C` is the edge set of a Hamilton cycle on the vertex set `A`. -/
def IsHamCycleEdges {A : Type} [Fintype A] (C : Set (Sym2 A)) : Prop :=
  ∃ σ : ZMod (Fintype.card A) → A, Function.Bijective σ ∧
    C = {e : Sym2 A | ∃ i : ZMod (Fintype.card A), e = s(σ i, σ (i + 1))}

def Claim : Prop :=
  ∀ (A : Type) [AddCommGroup A] [Fintype A] (S : Finset A),
    Even (Fintype.card A) → (0 : A) ∉ S → (∀ s ∈ S, -s ∈ S) → S.card = 6 →
    AddSubgroup.closure (S : Set A) = ⊤ →
    ∃ col : Sym2 A → Fin 3, ∀ i : Fin 3,
      IsHamCycleEdges {e : Sym2 A | e ∈ (cay S).edgeSet ∧ col e = i}

end
end OpenProblems.QEDE167
