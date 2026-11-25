import Mathlib
/-! N-681: Is the Mandelbrot set decidable at Gaussian rationals?
Is there an algorithm that, given a complex number with rational real and imaginary parts,
decides whether it lies in the Mandelbrot set? Escaping points and points with a non-repelling
cycle can be certified; the difficulty is possible Gaussian rationals in M all of whose cycles
repel.
Informal statement: Let M = {c ∈ ℂ : (f_c^n(0))_{n≥0} bounded}, f_c(z) = z² + c. Prove or
disprove that M ∩ ℚ(i) is a decidable subset of ℚ(i). (A sufficient condition is (*): every
c ∈ (M ∩ ℚ(i)) \ ℤ[i] has a non-repelling cycle; (*) is not part of the Claim.)
Formalization notes: Gaussian rationals are encoded by tuples (p₁, m₁, p₂, m₂, d) of naturals,
denoting ((p₁ − m₁) + (p₂ − m₂) i)/(d + 1) with the subtractions done in ℤ (cast to ℂ; no ℕ
subtraction). Every Gaussian rational has such codes, and this encoding is computably equivalent
to any standard one, so decidability of M ∩ ℚ(i) is equivalent to `ComputablePred` of the
membership predicate on codes (Mathlib's `ComputablePred`, i.e. computable characteristic
function w.r.t. the `Primcodable` structure on ℕ × ℕ × ℕ × ℕ × ℕ). Membership in M is
"the orbit of 0 is bounded". Proving `Claim` = giving a decision procedure (classically: proving
the predicate computable); proving `¬Claim` = showing M ∩ ℚ(i) is undecidable.
-/
namespace OpenProblems.N681

/-- `n`-th iterate of `z ↦ z² + c` at `0`. -/
noncomputable def mandelOrbit (c : ℂ) (n : ℕ) : ℂ := (fun z : ℂ => z ^ 2 + c)^[n] 0

/-- Membership in the Mandelbrot set: the critical orbit is bounded. -/
def InMandelbrot (c : ℂ) : Prop := ∃ R : ℝ, ∀ n : ℕ, ‖mandelOrbit c n‖ ≤ R

/-- Decode `(p₁, m₁, p₂, m₂, d)` as the Gaussian rational `((p₁ − m₁) + (p₂ − m₂) i)/(d + 1)`. -/
noncomputable def gaussRat (q : ℕ × ℕ × ℕ × ℕ × ℕ) : ℂ :=
  ((((q.1 : ℤ) - (q.2.1 : ℤ) : ℤ) : ℂ) + (((q.2.2.1 : ℤ) - (q.2.2.2.1 : ℤ) : ℤ) : ℂ) * Complex.I)
    / ((q.2.2.2.2 : ℂ) + 1)

def Claim : Prop :=
  ComputablePred (fun q : ℕ × ℕ × ℕ × ℕ × ℕ => InMandelbrot (gaussRat q))

end OpenProblems.N681
