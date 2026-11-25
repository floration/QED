import Mathlib
/-! QED-E175: Two equal sums of two fifth powers
1729 = 1^3+12^3 = 9^3+10^3 and 635318657 = 59^4+158^4 = 133^4+134^4 show that sums of two cubes or two fourth powers can coincide in a nontrivial way. For fifth powers no example is known, and none exists with sum below about 10^26. Find positive integers with a^5+b^5 = c^5+d^5 other than the trivial rearrangements, or prove that none exist.
Informal statement: Decide whether there exist $a,b,c,d\in\mathbb{Z}_{>0}$ with $a^5+b^5=c^5+d^5$ and $\{a,b\}\ne\{c,d\}$.
Formalization notes: Variables range over ℕ with explicit positivity (allowing 0 or negative integers makes the question trivial, e.g. a⁵ + (−a)⁵ = 0). The multiset condition {a,b} ≠ {c,d} is written as ¬((a = c ∧ b = d) ∨ (a = d ∧ b = c)). `Claim` = a nontrivial solution exists (provable by exhibiting one and checking it with `norm_num`/`decide`). `¬Claim` = no nontrivial solution exists. Either settles the problem. No solution has sum below about 1.02·10²⁶.
-/
namespace OpenProblems.QEDE175

/-- There is a nontrivial equal sum of two positive fifth powers. -/
def Claim : Prop :=
  ∃ a b c d : ℕ, 0 < a ∧ 0 < b ∧ 0 < c ∧ 0 < d ∧
    a ^ 5 + b ^ 5 = c ^ 5 + d ^ 5 ∧ ¬((a = c ∧ b = d) ∨ (a = d ∧ b = c))

end OpenProblems.QEDE175
