import Mathlib
/-! N-572: Is eventual periodicity of square-plus-one decidable?
Is there an algorithm that decides, for any n, whether its square-plus-one sequence eventually loops?
Informal statement: Decide whether $\{n: (Q^k(n))_k \text{ is eventually periodic}\}$ is recursive, where $Q(n)=P(n^2+1)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N572
def Claim : Prop := sorry
end OpenProblems.N572
