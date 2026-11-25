import Mathlib
/-! QED-E041: No three in line: beat 3n/2
Find, for all large n, at least cn points of the n×n grid with no three collinear, for some c > 3/2.
Informal statement: Let $f(n)$ be the largest size of $S\subseteq\{1,\dots,n\}^2$ with no three collinear points. Prove there is $c>3/2$ with $f(n)\ge cn$ for all sufficiently large $n$.
Formalization notes: Points are in ℤ × ℤ with coordinates in [1, n]. Three distinct points p, q, r are collinear iff the cross product (q-p)×(r-p) vanishes. Claim = ∃ c > 3/2, eventually f(n) ≥ c·n (i.e. liminf f(n)/n > 3/2); ¬Claim = liminf f(n)/n ≤ 3/2.
-/
namespace OpenProblems.QEDE041

def NoThreeCollinear (S : Finset (ℤ × ℤ)) : Prop :=
  ∀ p ∈ S, ∀ q ∈ S, ∀ r ∈ S, p ≠ q → p ≠ r → q ≠ r →
    (q.1 - p.1) * (r.2 - p.2) ≠ (q.2 - p.2) * (r.1 - p.1)

def Claim : Prop :=
  ∃ c : ℝ, 3 / 2 < c ∧ ∃ N : ℕ, ∀ n : ℕ, N ≤ n →
    ∃ S : Finset (ℤ × ℤ),
      (∀ p ∈ S, 1 ≤ p.1 ∧ p.1 ≤ (n : ℤ) ∧ 1 ≤ p.2 ∧ p.2 ≤ (n : ℤ)) ∧
      NoThreeCollinear S ∧ c * (n : ℝ) ≤ (S.card : ℝ)

end OpenProblems.QEDE041
