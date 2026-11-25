import Mathlib
/-! QED-E026: Total colouring of planar graphs with maximum degree 6
A total colouring colours both vertices and edges so that touching objects (adjacent vertices, edges sharing an end, an edge and its endpoint) get different colours. It is conjectured that Δ+2 colours always suffice, where Δ is the maximum degree. For planar graphs this is proved for every Δ except Δ=6: show every planar graph with maximum degree 6 has a total colouring with 8 colours.
Informal statement: Prove that every simple planar graph $G$ with $\Delta(G)=6$ satisfies $\chi''(G)\le 8$ (or find a counterexample).
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E026`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE026
def Claim : Prop := sorry
end OpenProblems.QEDE026
