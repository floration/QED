import Mathlib
/-! QED-E028: Strong edge colouring with maximum degree 4: 20 or 21 colours?
A strong edge colouring gives edges colours so that any two edges that touch, or are joined by a third edge, get different colours. Erdős and Nešetřil conjectured that graphs with maximum degree 4 need at most 20 colours; it is proved that 21 suffice. Close the one-colour gap.
Informal statement: Prove that every graph $G$ with $\Delta(G)\le4$ has strong chromatic index $\chi'_s(G)\le20$ (Erdos-Nesetril bound $\tfrac54\Delta^2$), or find a graph with $\Delta\le4$ and $\chi'_s=21$.
Formalization notes: Conflict G e f: e ≠ f and some endpoint of e equals or is adjacent to some endpoint of f (edges at distance <= 1 in the line graph sense used for strong colouring). Claim: every finite simple graph (on Fin n) with all degrees <= 4 has a colouring of its edges with Fin 20 in which conflicting edges differ, i.e. chi'_s <= 20. ¬Claim means some graph with Delta <= 4 has chi'_s = 21 (since 21 always suffices). The colour function is defined on all of Sym2 but only constrained on edges, so there is no junk loophole.
-/
namespace OpenProblems.QEDE028
def Conflict {V : Type} (G : SimpleGraph V) (e f : Sym2 V) : Prop :=
  e ≠ f ∧ ∃ a ∈ e, ∃ b ∈ f, a = b ∨ G.Adj a b

def Claim : Prop :=
  ∀ (n : ℕ) (G : SimpleGraph (Fin n)), (∀ v : Fin n, (G.neighborSet v).ncard ≤ 4) →
    ∃ c : Sym2 (Fin n) → Fin 20,
      ∀ e ∈ G.edgeSet, ∀ f ∈ G.edgeSet, Conflict G e f → c e ≠ c f
end OpenProblems.QEDE028
