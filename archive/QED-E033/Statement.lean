import Mathlib
/-! QED-E033: Ideal Prouhet–Tarry–Escott solution of size 11
Find two different lists of 11 integers whose sums of j-th powers agree for every j = 1, ..., 10.
Informal statement: Do there exist multisets $\{a_1,\dots,a_{11}\}\neq\{b_1,\dots,b_{11}\}$ of integers with $\sum_i a_i^j=\sum_i b_i^j$ for $j=1,\dots,10$?
Formalization notes: Lists are functions `Fin 11 → ℤ`; "different multisets" is inequality of the image multisets of `Finset.univ`. Claim = an ideal size-11 (degree-10) PTE solution exists; ¬Claim = no such solution exists.
-/
namespace OpenProblems.QEDE033

def Claim : Prop :=
  ∃ a b : Fin 11 → ℤ,
    Finset.univ.val.map a ≠ Finset.univ.val.map b ∧
    ∀ j : ℕ, 1 ≤ j → j ≤ 10 → (∑ i : Fin 11, a i ^ j) = ∑ i : Fin 11, b i ^ j

end OpenProblems.QEDE033
