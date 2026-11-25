import Mathlib
/-! QED-E042: Happy ending for heptagons: ES(7)=33
Every 33 points in the plane with no three on a line contain 7 points in convex position.
Informal statement: Let $ES(k)$ be the least $N$ such that every $N$-point set in general position in $\mathbb R^2$ contains $k$ points in convex position. Prove $ES(7)=33$.
Formalization notes: The plane is `ℝ × ℝ`; general position means no three distinct points are `Collinear ℝ`. Convex position means no point of T lies in the convex hull of the others. Since a 32-point set without a convex heptagon is known (Erdős–Szekeres 1961), Claim is equivalent to ES(7) = 33; ¬Claim means some 33-point set in general position has no convex heptagon (so ES(7) > 33).
-/
namespace OpenProblems.QEDE042

def GeneralPosition (S : Finset (ℝ × ℝ)) : Prop :=
  ∀ p ∈ S, ∀ q ∈ S, ∀ r ∈ S, p ≠ q → p ≠ r → q ≠ r →
    ¬ Collinear ℝ ({p, q, r} : Set (ℝ × ℝ))

def ConvexPosition (T : Finset (ℝ × ℝ)) : Prop :=
  ∀ p ∈ T, p ∉ convexHull ℝ (((T.erase p : Finset (ℝ × ℝ))) : Set (ℝ × ℝ))

def Claim : Prop :=
  ∀ S : Finset (ℝ × ℝ), S.card = 33 → GeneralPosition S →
    ∃ T : Finset (ℝ × ℝ), T ⊆ S ∧ T.card = 7 ∧ ConvexPosition T

end OpenProblems.QEDE042
