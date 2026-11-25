import Mathlib
/-! QED-E077: Critical linear firefighter rate on Z^3
On Z^3 a finite fire spreads each step to all unprotected neighbours, and at step t one may protect about ct new vertices. Linear rate is the right order; the question is the critical constant c*. This file asks to improve the stated lower bound.
Informal statement: Let c* = inf{c : for every finite initial fire B_0 ⊂ Z^3 there is a protection schedule with at most ⌊c t⌋ newly protected vertices at step t that keeps the total burnt set finite}. Known (QED-derived, elementary): 8/243 ≤ c* ≤ 8 (bound field and W); M additionally records 64/243 ≤ c* ≤ 48/7 (not independently checked here; numerics suggest a static ℓ^4-ball wall gives ≈ 6.4). Target: prove c* > 32/27, i.e. some rate c > 32/27 fails to contain some finite outbreak.
Note: c* ≥ 32/27 already follows from the growth recursion |B_{t+1}| ≥ |B_t| + |∂B_t| − c(t+1)(t+2)/2 together with the
Wang–Wang vertex-isoperimetric inequality in Z^3 (|∂A| ≳ 4(3|A|/4)^{2/3}); the 64/243 bound is the same argument with the
Loomis–Whitney constant |∂A| ≥ 2|A|^{2/3}. So 64/243 is not a meaningful target.
Formalization notes: Fire dynamics: step t+1 = protect P(t+1), then spread to unprotected neighbours; protected vertices stay protected forever; protecting an already burnt vertex is allowed but useless, and re-protecting wastes budget, so allowing arbitrary sets of size ≤ c·s is equivalent to the usual rules. The fire is deterministic, so adaptive strategies are the same as fixed schedules P : ℕ → Finset V3. Budget at step 0 is 0. Containment = the union of all burnt sets is finite (equivalently, the fire stops). Contains is monotone in c, so c* > 32/27 ⇔ ∃ c > 32/27, ¬Contains c. The lower bound is the formalized side because the upper side is essentially settled numerically (≈6.4 wall). Proving ¬Claim means every rate c > 32/27 contains all finite outbreaks, i.e. c* ≤ 32/27 (hence = 32/27).
-/
namespace OpenProblems.QEDE077

/-- The vertices of the grid `Z^3`. -/
abbrev V3 : Type := ℤ × ℤ × ℤ

/-- Grid adjacency: `ℓ¹` distance exactly `1`. -/
def Adj3 (u v : V3) : Prop :=
  |u.1 - v.1| + |u.2.1 - v.2.1| + |u.2.2 - v.2.2| = 1

/-- The burnt set after `t` steps, starting from the fire `B0`, when the set `P s` is protected at step
`s ≥ 1`. At step `t + 1` the firefighters first protect `P (t + 1)`; then the fire spreads to every
neighbour of a burnt vertex that has not been protected at any step `≤ t + 1`. -/
def burnt (B0 : Set V3) (P : ℕ → Finset V3) : ℕ → Set V3
  | 0 => B0
  | t + 1 => burnt B0 P t ∪
      {v : V3 | (∀ s : ℕ, s ≤ t + 1 → v ∉ P s) ∧ ∃ u ∈ burnt B0 P t, Adj3 u v}

/-- Rate `c` contains every finite outbreak: for every finite initial fire there is a schedule with
at most `c * s` (equivalently `⌊c s⌋`) vertices protected at step `s` such that only finitely many
vertices ever burn. -/
def Contains (c : ℝ) : Prop :=
  ∀ B0 : Finset V3, ∃ P : ℕ → Finset V3,
    (∀ s : ℕ, ((P s).card : ℝ) ≤ c * (s : ℝ)) ∧
    (⋃ t : ℕ, burnt (↑B0 : Set V3) P t).Finite

/-- `c* > 32/27`: some rate above `32/27` does not contain every finite outbreak. -/
def Claim : Prop := ∃ c : ℝ, 32 / 27 < c ∧ ¬ Contains c

end OpenProblems.QEDE077
