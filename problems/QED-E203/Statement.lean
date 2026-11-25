import Mathlib
/-! QED-E203: Does a triangle with integer sides, medians and area exist?
Is there a triangle whose three sides, three medians (segments from a vertex to the midpoint of the opposite side) and area are all integers? Triangles with integer sides and area (Heron triangles) are plentiful, triangles with integer sides and integer medians exist, and there are infinitely many Heron triangles with two integer medians, but no triangle with all seven quantities integral has ever been found.
Informal statement: Decide whether there exist positive integers $a,b,c,m_a,m_b,m_c,A$ with $a<b+c,\ b<a+c,\ c<a+b$, $4m_a^2=2b^2+2c^2-a^2$, $4m_b^2=2a^2+2c^2-b^2$, $4m_c^2=2a^2+2b^2-c^2$ and $16A^2=(a+b+c)(-a+b+c)(a-b+c)(a+b-c)$. (Equivalently, by scaling: a non-degenerate triangle with rational sides, medians and area.)
Formalization notes: Pure Diophantine formulation over ℤ. For a non-degenerate triangle with
sides a, b, c, the median to side a has length m_a with 4m_a² = 2b² + 2c² - a² (Apollonius), and
Heron's formula gives 16A² = (a+b+c)(-a+b+c)(a-b+c)(a+b-c); strict triangle inequalities encode
non-degeneracy. Lengths and area are positive, so requiring positive integer values for all seven
quantities is exactly "all seven are integers". The rational version is equivalent by scaling
by a common denominator (all equations are homogeneous of degree 2 in the lengths and degree 2 in
A against degree 4 in sides, so scaling sides and medians by d scales A by d²).
Claim is the conjectured answer (no perfect triangle exists). Proving ¬Claim amounts to exhibiting
an explicit 7-tuple, checkable by `decide`/`norm_num`.
-/
namespace OpenProblems.QEDE203
noncomputable section

/-- A "perfect triangle": integer sides, medians and area. -/
def PerfectTriangle (a b c ma mb mc A : ℤ) : Prop :=
  0 < a ∧ 0 < b ∧ 0 < c ∧ 0 < ma ∧ 0 < mb ∧ 0 < mc ∧ 0 < A ∧
    a < b + c ∧ b < a + c ∧ c < a + b ∧
    4 * ma ^ 2 = 2 * b ^ 2 + 2 * c ^ 2 - a ^ 2 ∧
    4 * mb ^ 2 = 2 * a ^ 2 + 2 * c ^ 2 - b ^ 2 ∧
    4 * mc ^ 2 = 2 * a ^ 2 + 2 * b ^ 2 - c ^ 2 ∧
    16 * A ^ 2 = (a + b + c) * (-a + b + c) * (a - b + c) * (a + b - c)

def Claim : Prop :=
  ¬ ∃ a b c ma mb mc A : ℤ, PerfectTriangle a b c ma mb mc A

end
end OpenProblems.QEDE203
