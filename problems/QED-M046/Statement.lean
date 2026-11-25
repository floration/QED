import Mathlib
/-! QED-M046: Deciding rationality of PL rotation numbers
A circle homeomorphism made of finitely many affine pieces with rational break points and slopes has a rotation number.
Rational rotation numbers can be certified by a rational periodic orbit, and irrational values do occur
(Belk–Hyde–Moore: √2 − 1 with slopes 3/2, 2/3, 1). Is there an algorithm that always decides which case holds?
Informal statement: Let 𝒫 be the set of orientation-preserving PL homeomorphisms of ℝ/ℤ with finitely many rational
break points, rational slopes and f(0) ∈ ℚ, encoded by these data. Is {f ∈ 𝒫 : ρ(f) ∈ ℚ} decidable?
Formalization notes: A code is ((a, b), pieces) with all rationals given as num/(den+1) by pairs of naturals
(`qOf`). Piece k is (b_k, s_k): the k-th break point and the slope on [b_k, b_{k+1}) (with b_{last+1} := 1). `Valid`
requires: at least one piece, b_0 = 0, 0 = b_0 < b_1 < … < 1, all slopes > 0, a := f(0) lift value in [0,1), and
Σ s_k (b_{k+1} − b_k) = 1 (degree one). Every rational PL circle homeomorphism has such a code (take the lift with
F(0) ∈ [0,1); a break point may be inserted at 0). `lift c` is the lift F : ℝ → ℝ, F(x) = ⌊x⌋ + a + Σ_k s_k·(clamp of
fract x to [b_k, b_{k+1}] − b_k). By Poincaré's theory, ρ(f) ∈ ℚ iff F^q(x) = x + p for some x ∈ ℝ, p ∈ ℤ, q ≥ 1;
this is used as the definition of `HasRationalRotation`, avoiding limits. "Decidable" is Mathlib's `ComputablePred`
on the `Primcodable` type of codes; validity itself is decidable, so Claim is equivalent to decidability of rational
rotation number on valid codes. Proving Claim = an algorithm; proving ¬Claim = undecidability.
-/
namespace OpenProblems.QEDM046

/-- Codes: `((num, den) of f(0), [((num, den) of break point, (num, den) of slope), …])`. -/
abbrev Code := (ℕ × ℕ) × List ((ℕ × ℕ) × (ℕ × ℕ))

/-- The nonnegative rational `num / (den + 1)`. -/
def qOf (p : ℕ × ℕ) : ℚ := (p.1 : ℚ) / ((p.2 : ℚ) + 1)

/-- Break points `b_0, …, b_{m-1}`. -/
def breaks (c : Code) : List ℚ := c.2.map (fun x => qOf x.1)

/-- Slopes `s_0, …, s_{m-1}`. -/
def slopes (c : Code) : List ℚ := c.2.map (fun x => qOf x.2)

/-- Right endpoints `b_1, …, b_{m-1}, 1` of the pieces. -/
def ends (c : Code) : List ℚ := (breaks c).tail ++ [1]

/-- A strictly increasing list. -/
def StrictlyIncreasing : List ℚ → Prop
  | [] => True
  | [_] => True
  | a :: b :: l => a < b ∧ StrictlyIncreasing (b :: l)

/-- The code describes an orientation-preserving degree-one PL circle homeomorphism. -/
def Valid (c : Code) : Prop :=
  c.2 ≠ [] ∧ (breaks c).head? = some 0 ∧ StrictlyIncreasing (breaks c ++ [1]) ∧
    (∀ s ∈ slopes c, 0 < s) ∧ qOf c.1 < 1 ∧
    (List.zipWith (fun x e => qOf x.2 * (e - qOf x.1)) c.2 (ends c)).sum = 1

/-- The lift `F : ℝ → ℝ` of the PL map with `F(0) = a ∈ [0,1)`. -/
noncomputable def lift (c : Code) (x : ℝ) : ℝ :=
  (Int.floor x : ℝ) + (qOf c.1 : ℝ) +
    (List.zipWith
      (fun p e => (qOf p.2 : ℝ) * (max (qOf p.1 : ℝ) (min (Int.fract x) (e : ℝ)) - (qOf p.1 : ℝ)))
      c.2 (ends c)).sum

/-- Rational rotation number, via existence of a periodic orbit of the circle map. -/
def HasRationalRotation (c : Code) : Prop :=
  ∃ q : ℕ, 0 < q ∧ ∃ p : ℤ, ∃ x : ℝ, (lift c)^[q] x = x + (p : ℝ)

def Claim : Prop := ComputablePred (fun c : Code => Valid c ∧ HasRationalRotation c)

end OpenProblems.QEDM046
