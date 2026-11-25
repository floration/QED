import Mathlib
/-! QED-E029: Oriented chromatic number of planar graphs (18 vs 80)
Orient every edge of a planar graph. An oriented colouring colours vertices so adjacent vertices differ and all arcs between two colour classes point the same way. Every oriented planar graph can be coloured with 80 colours, and some need 18. The gap has barely moved since 1994: narrow it.
Informal statement: Let $\chi_o(\mathcal P)=\max\chi_o(\vec G)$ over orientations $\vec G$ of simple planar graphs, where $\chi_o(\vec G)$ is the least order of a tournament $T$ admitting a homomorphism $\vec G\to T$. Known: $18\le\chi_o(\mathcal P)\le80$. Improve either bound substantially, or at least exhibit an oriented planar graph with $\chi_o\ge19$ or prove $\chi_o(\mathcal P)\le79$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E029`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE029
def Claim : Prop := sorry
end OpenProblems.QEDE029
