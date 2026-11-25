import Mathlib
/-! QED-E045: Dirac–Motzkin below the Green–Tao threshold
Every set of n points in the plane, not all on one line, with n ≠ 7, 13, determines at least n/2 ordinary lines (lines through exactly two of the points).
Informal statement: For finite non-collinear P ⊂ ℝ² with |P| = n ∉ {7, 13}, t₂(P) ≥ n/2. Green–Tao (2013) prove this for n ≥ n₀; the open content is the finite range n < n₀.
Formalization notes: Points are elements of ℝ × ℝ. Collinearity is the vanishing of the 2×2 determinant. Each ordinary line {p, q} is counted by the two ordered pairs (p, q), (q, p) in `ordinaryPairs`, so `P.card ≤ (ordinaryPairs P).card` is exactly 2·t₂(P) ≥ n, i.e. t₂(P) ≥ n/2. `Claim` is the Dirac–Motzkin conjecture for all n ∉ {7, 13}; `¬Claim` is a counterexample (necessarily with n < n₀ by Green–Tao). Degenerate pairs cannot occur: `offDiag` forces p ≠ q, and `NonCollinear` forces at least three distinct points. The weaker target (t₂ ≥ c·n with c > 6/13) is not formalized here.
-/
namespace OpenProblems.QEDE045

open Classical

/-- `p`, `q`, `r` lie on a common line in ℝ². -/
def Col (p q r : ℝ × ℝ) : Prop :=
  (q.1 - p.1) * (r.2 - p.2) - (q.2 - p.2) * (r.1 - p.1) = 0

/-- `P` is not contained in a single line. -/
def NonCollinear (P : Finset (ℝ × ℝ)) : Prop :=
  ∃ p ∈ P, ∃ q ∈ P, ∃ r ∈ P, ¬ Col p q r

/-- Ordered pairs of distinct points of `P` whose line contains no third point of `P`;
its cardinality is twice the number of ordinary lines. -/
noncomputable def ordinaryPairs (P : Finset (ℝ × ℝ)) : Finset ((ℝ × ℝ) × (ℝ × ℝ)) :=
  P.offDiag.filter (fun x : (ℝ × ℝ) × (ℝ × ℝ) =>
    ∀ r ∈ P, r ≠ x.1 → r ≠ x.2 → ¬ Col x.1 x.2 r)

def Claim : Prop :=
  ∀ P : Finset (ℝ × ℝ), NonCollinear P → P.card ≠ 7 → P.card ≠ 13 →
    P.card ≤ (ordinaryPairs P).card

end OpenProblems.QEDE045
