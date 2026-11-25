import Mathlib
/-! QED-E061: Logarithmically many conjugacy classes
Every finite group of order n splits into conjugacy classes. Is there one fixed constant c>0 such that every finite group of order n has at least c*log n conjugacy classes? The best known lower bounds lose a power of log log n, and the question is whether that loss is real.
Informal statement: Let $k(G)$ denote the number of conjugacy classes of a finite group $G$. Is $\inf\{k(G)/\log|G| : G \text{ finite}, |G|\ge 2\}>0$? Equivalently, either prove $k(G)\ge c\log|G|$ for an absolute $c>0$ and all finite $G$, or exhibit finite groups $G_i$ with $k(G_i)/\log|G_i|\to0$.
Formalization notes: `k(G)` is `Nat.card (ConjClasses G)` (Mathlib's quotient of `G` by
conjugacy). Groups range over `G : Type` with `[Group G] [Finite G]`; every finite group
is isomorphic to one in `Type` (e.g. on `Fin |G|`), and both `k(G)` and `|G|` are
isomorphism invariants, so this loses nothing. `Real.log` is the natural log; the base
only rescales `c`. The trivial group gives `log 1 = 0 ≤ k`, so including it is harmless
(matches `|G| ≥ 2` in the informal version). Claim: ∃ c > 0, ∀ finite G,
`c * log |G| ≤ k(G)`, i.e. the infimum is positive. ¬Claim is the existence, for every
c > 0, of a finite group with `k(G) < c log |G|`, i.e. a family with `k/log|G| → 0`.
-/
namespace OpenProblems.QEDE061
noncomputable section

def Claim : Prop :=
  ∃ c : ℝ, 0 < c ∧ ∀ (G : Type) [Group G] [Finite G],
    c * Real.log (Nat.card G : ℝ) ≤ (Nat.card (ConjClasses G) : ℝ)

end
end OpenProblems.QEDE061
