import Mathlib
/-! QED-E197: Trifferent codes: an exponential improvement over (3/2)^n
A set of words of length n over the alphabet {0,1,2} is trifferent if any three distinct words have a position where they show all three letters 0, 1, 2. Let T(n) be the largest size of such a set. A simple counting argument from 1988 gives T(n) ≤ 2(3/2)^n, and every later improvement has been only by a polynomial factor. Show that T(n) ≤ c^n for some constant c < 3/2 and all large n.
Informal statement: Call $C\subseteq\{0,1,2\}^n$ trifferent if for all pairwise distinct $x,y,z\in C$ there is $i$ with $\{x_i,y_i,z_i\}=\{0,1,2\}$, and let $T(n)$ be the maximum size of a trifferent code. Prove that $\limsup_{n\to\infty}\frac1n\log T(n)<\log\frac32$.
Formalization notes: Words of length n over {0,1,2} are functions `Fin n → Fin 3`; a code is a
`Finset` of words. Since three elements of `Fin 3` form the set {0,1,2} iff they are pairwise
distinct, trifference of C means: for all pairwise distinct x, y, z ∈ C there is a coordinate i
with x i, y i, z i pairwise distinct. Instead of defining T(n) as a maximum we quantify over all
trifferent codes, which avoids junk values. The limsup statement is equivalent to
"∃ c with 0 < c < 3/2 and N such that every trifferent code of length n ≥ N has at most c^n words":
if limsup (1/n) log T(n) = L < log(3/2), take c = exp((L + log(3/2))/2); conversely T(n) ≤ c^n
eventually gives limsup ≤ log c < log(3/2) (T(n) ≥ 1, so the logs are defined).
Proving Claim settles the problem; proving ¬Claim shows log(3/2) is the exact exponential rate's
upper limit (limsup = log(3/2)).
-/
namespace OpenProblems.QEDE197
noncomputable section

/-- `C` is a trifferent code: any three distinct codewords are separated in some coordinate
by all three symbols. -/
def Trifferent (n : ℕ) (C : Finset (Fin n → Fin 3)) : Prop :=
  ∀ x ∈ C, ∀ y ∈ C, ∀ z ∈ C, x ≠ y → y ≠ z → x ≠ z →
    ∃ i : Fin n, x i ≠ y i ∧ y i ≠ z i ∧ x i ≠ z i

def Claim : Prop :=
  ∃ c : ℝ, 0 < c ∧ c < 3 / 2 ∧ ∃ N : ℕ, ∀ n : ℕ, N ≤ n →
    ∀ C : Finset (Fin n → Fin 3), Trifferent n C → (C.card : ℝ) ≤ c ^ n

end
end OpenProblems.QEDE197
