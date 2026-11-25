import Mathlib
/-! N-680: Finding Huang's vertex
STATUS: NOT YET FORMALIZED
Huang's theorem: any set of more than half the vertices of the n-cube contains a vertex with at least √n neighbours in
the set. Given such a set listed by a small circuit, how hard is it to find such a vertex or a flaw in the listing?
The search problem is PPP-hard; is it in PPP (hence PPP-complete)?
Informal statement: HUANG: given a Boolean circuit f : {0,1}ⁿ → {0,1}ⁿ, whose inputs are read as elements of
[2^{n-1}+1] (inputs encoding larger numbers are ignored), output either i ≠ j in [2^{n-1}+1] with f(i) = f(j), or
i, j₁, …, j_m in [2^{n-1}+1] with m = ⌈√n⌉ such that f(j₁), …, f(j_m) are distinct and each is at Hamming distance 1
from f(i). The problem is total by Huang's theorem and PPP-hard. Is HUANG ∈ PPP? If not, which standard TFNP class
contains it, and is it complete for that class?
Formalization notes: Needs pieces Mathlib lacks: Boolean circuits as input objects with size, polynomial-time
many-one reductions between total search problems, and the class PPP (defined via PIGEON). Proving Claim would mean
constructing a polynomial-time reduction from HUANG to PIGEON; ¬Claim (in the white-box model) would separate it from
PPP, which is currently out of reach unconditionally (it would imply P ≠ NP-type separations), so a black-box/query
separation is the realistic negative form and would need an oracle formalization as well.
-/
namespace OpenProblems.N680

def Claim : Prop := sorry

end OpenProblems.N680
