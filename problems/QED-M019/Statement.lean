import Mathlib
/-! QED-M019: Codes avoiding square distances
Let A(n) be the largest size of a set of binary strings of length n in which no two distinct
strings differ in a perfect-square number of positions (1, 4, 9, 16, ...). This is a
Hamming-cube analogue of the Sarkozy-Furstenberg theorem on sets without square differences.
Known: exp(c n^{1/3}) <= A(n) <= (2 - delta)^n. The core open question is whether A(n) grows
exponentially or is 2^{o(n)}.
Informal statement: Let A(n) = max{|C| : C ⊆ {0,1}^n, d_H(x,y) ∉ {1,4,9,16,...} for all x ≠ y in C}.
Decide whether A(n) = 2^{o(n)}, i.e. whether limsup (1/n) log_2 A(n) = 0.
Formalization notes: Binary strings are `Fin n → Bool`; `hamming x y` counts coordinates where
they differ. `SquareAvoiding C` says every pair of distinct elements of the finite set `C` has a
Hamming distance that is not a perfect square (`IsSquare` on ℕ; distance 0 never occurs for
distinct strings). To avoid junk values of `sSup`, the claim quantifies over all square-avoiding
codes directly: `Claim` says that for every ε > 0, for all sufficiently large n, every
square-avoiding code in {0,1}^n has at most 2^{εn} elements, i.e. A(n) = 2^{o(n)}
(subexponential). Proving `Claim` shows subexponential growth; proving `¬Claim` shows there are
ε > 0 and infinitely many n with a square-avoiding code of size > 2^{εn}, i.e.
limsup (1/n) log_2 A(n) > 0. The finer question of whether liminf = limsup is not formalized here.
Known bounds (not part of the claim): A(n) ≥ exp(c n^{1/3}) via constant-weight codes with all
distances strictly between consecutive squares; A(n) ≤ (2 - δ)^n via Frankl-Rödl.
-/
namespace OpenProblems.QEDM019

/-- Hamming distance between two binary strings of length `n`. -/
def hamming {n : ℕ} (x y : Fin n → Bool) : ℕ :=
  (Finset.univ.filter (fun i : Fin n => x i ≠ y i)).card

/-- A code is square-avoiding if no two distinct codewords are at perfect-square Hamming distance. -/
def SquareAvoiding {n : ℕ} (C : Finset (Fin n → Bool)) : Prop :=
  ∀ x ∈ C, ∀ y ∈ C, x ≠ y → ¬ IsSquare (hamming x y)

def Claim : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ N : ℕ, ∀ n : ℕ, N ≤ n →
    ∀ C : Finset (Fin n → Bool), SquareAvoiding C →
      (C.card : ℝ) ≤ (2 : ℝ) ^ (ε * (n : ℝ))

end OpenProblems.QEDM019
