import Mathlib
/-! QED-E156: Can additive squares be avoided over the integers?
An additive square in a sequence of integers is a block of 2k consecutive terms whose first half and second half have the same sum (for example 1 3 | 2 2). Is there a finite set of integers S and an infinite sequence with all terms in S that contains no additive square? Such sequences exist over a finite subset of the plane lattice Z², and over Z one can avoid additive cubes (three adjacent blocks of equal length and equal sum), but no one knows whether squares can be avoided over Z.
Informal statement: Decide whether there exist a finite set $S\subset\mathbb{Z}$ and $w:\mathbb{N}\to S$ such that for all $i\ge0$ and $k\ge1$, $\sum_{j=i}^{i+k-1}w(j)\neq\sum_{j=i+k}^{i+2k-1}w(j)$. Equivalently, by compactness: is there a finite $S\subset\mathbb Z$ for which arbitrarily long finite words over $S$ avoid additive squares?
Formalization notes:
* An infinite word is w : ℕ → ℤ with all values in a finite set S : Finset ℤ. An additive square at position i of
  half-length k ≥ 1 is w(i) + … + w(i+k−1) = w(i+k) + … + w(i+2k−1). `AddSqFree w` forbids all of them.
* `Claim`: some finite S ⊂ ℤ admits an infinite additive-square-free word over S. Decision problem: proving
  `Claim` = additive squares are avoidable over ℤ; ¬Claim = every infinite word over any finite S ⊂ ℤ has an
  additive square (by compactness equivalent to the finite-word version).
-/
namespace OpenProblems.QEDE156

def AddSqFree (w : ℕ → ℤ) : Prop :=
  ∀ i k : ℕ, 0 < k →
    ∑ j ∈ Finset.range k, w (i + j) ≠ ∑ j ∈ Finset.range k, w (i + k + j)

def Claim : Prop :=
  ∃ S : Finset ℤ, ∃ w : ℕ → ℤ, (∀ n : ℕ, w n ∈ S) ∧ AddSqFree w

end OpenProblems.QEDE156
