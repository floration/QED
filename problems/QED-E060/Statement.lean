import Mathlib
/-! QED-E060: Is a random 5-regular graph 3-colourable?
Choose a graph uniformly at random among all 5-regular graphs on n labelled vertices (n even). Such a graph is known to be 4-colourable with probability tending to 1, and it is known to be 3-colourable with probability tending to 1 provided an explicit four-variable function attains its global maximum at one specific point, which numerics strongly support but nobody has proved. Prove unconditionally that the probability of 3-colourability tends to 1. Degree 5 is exactly where the answer switches: random 4-regular graphs are almost surely 3-colourable, random 6-regular ones almost surely are not.
Informal statement: Let $\mathcal G_{n,5}$ be the set of simple 5-regular graphs on $[n]$ ($n$ even), with the uniform measure. Prove $\lim_{n\to\infty,\ n\text{ even}}|\{G\in\mathcal G_{n,5}:\chi(G)\le 3\}|/|\mathcal G_{n,5}|=1$.
Formalization notes: Labelled simple graphs on `[n]` are `SimpleGraph (Fin n)` (loopless,
undirected, no multi-edges — the standard uniform model `G_{n,d}`, not the configuration
model). `G` is 5-regular iff every neighbour set has exactly 5 elements (`Set.ncard`; the
neighbour sets are finite since `Fin n` is). The sets of 5-regular graphs and of
3-colourable 5-regular graphs are subsets of the finite type `SimpleGraph (Fin n)`, so
`Set.ncard` gives their true cardinalities and the ratio is exactly the uniform
probability. χ(G) ≤ 3 is Mathlib's `SimpleGraph.Colorable 3` (a proper colouring
`Fin n → Fin 3`). Restricting to n = 2m handles parity (no 5-regular graph on an odd
number of vertices); for m ≥ 3 the denominator is positive, and finitely many small m
do not affect the limit. Proving Claim is exactly the unconditional a.a.s.
3-colourability of random 5-regular graphs; ¬Claim says the probability does not tend to 1.
-/
namespace OpenProblems.QEDE060
noncomputable section
open Filter Topology

/-- `G` is 5-regular. -/
def IsFiveRegular {n : ℕ} (G : SimpleGraph (Fin n)) : Prop :=
  ∀ v : Fin n, (G.neighborSet v).ncard = 5

/-- Proportion of 3-colourable graphs among 5-regular graphs on `n` labelled vertices. -/
def col3Prob (n : ℕ) : ℝ :=
  ({G : SimpleGraph (Fin n) | IsFiveRegular G ∧ G.Colorable 3}.ncard : ℝ) /
    ({G : SimpleGraph (Fin n) | IsFiveRegular G}.ncard : ℝ)

def Claim : Prop :=
  Tendsto (fun m : ℕ => col3Prob (2 * m)) atTop (𝓝 1)

end
end OpenProblems.QEDE060
