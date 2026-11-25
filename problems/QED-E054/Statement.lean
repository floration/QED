import Mathlib
/-! QED-E054: Is Grundy's game eventually periodic?
In Grundy's game a move splits a heap into two nonempty heaps of different sizes. Is the sequence of Grundy values of single heaps eventually periodic?
Informal statement: Let g(n) = mex{ g(a) ⊕ g(b) : a + b = n, 1 ≤ a < b } (so g(0) = g(1) = g(2) = 0). Are there N and p ≥ 1 with g(n + p) = g(n) for all n ≥ N?
Formalization notes: Instead of defining g by well-founded recursion, `IsGrundy g` states the mex recursion: no option value equals g n, and every smaller value is an option value. A function satisfying it exists and is unique (strong induction on n), so quantifying over all such g is neither vacuous nor ambiguous. ⊕ is `^^^` (bitwise xor on ℕ). For n ≤ 2 there are no options, which forces g n = 0. `Claim` = eventual periodicity (the Berlekamp–Conway–Guy conjecture). `¬Claim` = not eventually periodic.
-/
namespace OpenProblems.QEDE054

/-- `g` satisfies the Grundy-value recursion of Grundy's game. -/
def IsGrundy (g : ℕ → ℕ) : Prop :=
  ∀ n : ℕ,
    (∀ a b : ℕ, 1 ≤ a → a < b → a + b = n → g n ≠ (g a ^^^ g b)) ∧
    (∀ m : ℕ, m < g n → ∃ a b : ℕ, 1 ≤ a ∧ a < b ∧ a + b = n ∧ (g a ^^^ g b) = m)

def Claim : Prop :=
  ∀ g : ℕ → ℕ, IsGrundy g →
    ∃ N p : ℕ, 0 < p ∧ ∀ n : ℕ, N ≤ n → g (n + p) = g n

end OpenProblems.QEDE054
