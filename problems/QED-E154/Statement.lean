import Mathlib
/-! QED-E154: Are the fractional parts of (3/2)^n dense?
Write down 3/2, 9/4, 27/8, ... and keep only the part after the decimal point. Numerically these fractional parts look uniformly spread over [0,1), but nobody can prove they even come arbitrarily close to every number in [0,1]. Prove that they do.
Informal statement: Prove that $\{ \{(3/2)^n\} : n \in \mathbb{N}\}$ is dense in $[0,1]$, where $\{t\} = t - \lfloor t \rfloor$.
Formalization notes:
* {t} is `Int.fract t` = t − ⌊t⌋ ∈ [0,1).
* Density in [0,1] is stated directly: every x ∈ [0,1] is approximated within every ε > 0.
  Note x = 1 is approximated by values near 1, and since infinitely many n are needed for
  smaller and smaller ε (finitely many values cannot be dense), the n = 0 term is irrelevant.
* `Claim` = density. `¬Claim` = some subinterval of [0,1] is avoided by all {(3/2)^n}.
-/
namespace OpenProblems.QEDE154
noncomputable section

def Claim : Prop :=
  ∀ x : ℝ, x ∈ Set.Icc (0 : ℝ) 1 → ∀ ε : ℝ, 0 < ε →
    ∃ n : ℕ, |Int.fract (((3 : ℝ) / 2) ^ n) - x| < ε

end
end OpenProblems.QEDE154
