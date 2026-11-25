import Mathlib
/-! QED-E157: Square-free words from lists of size three
Thue showed in 1906 that there is an infinite word over three letters with no square, that is, no block immediately repeated (like 'abab'). Now suppose each position i has its own list A_i of three allowed symbols, chosen by an adversary from an unbounded alphabet. Is there always an infinite square-free word whose i-th letter lies in A_i? Lists of size 4 are known to suffice, and size 3 suffices when all lists are drawn from only four symbols.
Informal statement: Claim: for every sequence $(A_i)_{i\ge1}$ of sets $A_i\subseteq\mathbb N$ with $|A_i|=3$, there exists $w:\mathbb N_{\ge1}\to\mathbb N$ with $w(i)\in A_i$ for all $i$, such that there are no $i,k\ge1$ with $w(i+j)=w(i+k+j)$ for all $0\le j<k$. (By compactness, this is equivalent to the same statement for every finite length; that is, the Thue choice number of the path is $3$.)
Formalization notes: Positions are indexed from 0 instead of 1 (an inessential shift).
Symbols are natural numbers (any countable alphabet reduces to ℕ, and a single sequence of
lists uses only countably many symbols). `SquareFree w` says no factor of the infinite
word w is a square: for every start i and every length k > 0 the blocks
w(i..i+k−1) and w(i+k..i+2k−1) differ somewhere. Claim = every assignment of
3-element lists admits a square-free choice (Thue choice number of the path ≤ 3, hence = 3);
¬Claim = some sequence of 3-lists admits no infinite square-free choice word (equivalently,
by König's lemma, some finite prefix of lists admits none).
-/
namespace OpenProblems.QEDE157
noncomputable section

def SquareFree (w : ℕ → ℕ) : Prop :=
  ∀ i k : ℕ, 0 < k → ∃ j : ℕ, j < k ∧ w (i + j) ≠ w (i + k + j)

def Claim : Prop :=
  ∀ A : ℕ → Finset ℕ, (∀ i : ℕ, (A i).card = 3) →
    ∃ w : ℕ → ℕ, (∀ i : ℕ, w i ∈ A i) ∧ SquareFree w

end
end OpenProblems.QEDE157
