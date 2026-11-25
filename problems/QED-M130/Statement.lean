import Mathlib
/-! QED-M130: Positivity of order-6 linear recurrences: decidable?
An integer sequence obeying a fixed linear recurrence u_{n+6} = a_1 u_{n+5} + ... + a_6 u_n is determined by six coefficients and six starting values. Is there an algorithm that, given these twelve integers, decides whether every term of the sequence is nonnegative? Such an algorithm exists for recurrences of order at most 5; order 6 is the first open case.
Informal statement: For $a=(a_1,\dots,a_6)\in\mathbb Z^6$ and $c=(c_0,\dots,c_5)\in\mathbb Z^6$ let $u=u^{a,c}$ be defined by $u_n=c_n$ ($n<6$) and $u_{n+6}=\sum_{i=1}^6 a_iu_{n+6-i}$. Let $\mathrm{Pos}=\{(a,c)\in\mathbb Z^{12}: u^{a,c}_n\ge 0\ \forall n\in\mathbb N\}$. Is $\mathrm{Pos}$ a decidable (computable) subset of $\mathbb Z^{12}$? Claim (either direction accepted): $\mathrm{Pos}$ is decidable, or $\mathrm{Pos}$ is undecidable.
Formalization notes:
* `lrs a c` is the integer sequence with initial values c 0, …, c 5 and recurrence u(n+6) = a 0·u(n+5) + a 1·u(n+4) + … + a 5·u(n) (so `a i` is a_{i+1}). Defined by structural recursion.
* Computability uses Mathlib's `ComputablePred` (Partrec/Computable, i.e. Turing-computable via partial recursive functions). Inputs are encoded as a pair of lists of pairs of naturals: (p, q) codes the integer p − q, and an instance is valid only if both lists have length exactly 6 (invalid inputs are rejected, i.e. not in `PosInput`). Decoding and length checks are primitive recursive, and every integer 12-tuple has a code, so `PosInput` is computable iff Pos ⊆ ℤ¹² is computable under any standard encoding. Using ℕ-pairs avoids relying on a `Primcodable ℤ` instance.
* Degenerate instances (a_6 = 0, i.e. order < 6) are included; they are decidable by Ouaknine–Worrell, so including them changes nothing. Rational coefficients/initial values (the literature's usual setting) reduce to integers by clearing denominators (u'_n = D^n·E·u_n satisfies an integer recurrence of the same order and has the same signs), so the integer version is equivalent.
* `Claim` = Positivity for order-6 integer LRS is decidable. `¬Claim` = it is undecidable. Either settles the problem (the board accepts either direction). Pos is co-r.e. (a negative term is found by search), so `Claim` is equivalent to Pos being r.e.
-/
namespace OpenProblems.QEDM130

/-- The order-6 linear recurrence sequence with coefficients `a` and initial values `c`. -/
def lrs (a c : Fin 6 → ℤ) : ℕ → ℤ
  | 0 => c 0
  | 1 => c 1
  | 2 => c 2
  | 3 => c 3
  | 4 => c 4
  | 5 => c 5
  | n + 6 => a 0 * lrs a c (n + 5) + a 1 * lrs a c (n + 4) + a 2 * lrs a c (n + 3) +
      a 3 * lrs a c (n + 2) + a 4 * lrs a c (n + 1) + a 5 * lrs a c n

/-- The integer coded by a pair of naturals. -/
def decInt (p : ℕ × ℕ) : ℤ := (p.1 : ℤ) - (p.2 : ℤ)

/-- The 6-vector coded by a list (missing entries read as 0; such inputs are rejected anyway). -/
def vecOf (L : List (ℕ × ℕ)) : Fin 6 → ℤ := fun i => decInt (L.getD i.val (0, 0))

/-- The coded instance is valid and its sequence is nonnegative. -/
def PosInput (x : List (ℕ × ℕ) × List (ℕ × ℕ)) : Prop :=
  x.1.length = 6 ∧ x.2.length = 6 ∧ ∀ n : ℕ, 0 ≤ lrs (vecOf x.1) (vecOf x.2) n

/-- Positivity of order-6 integer linear recurrence sequences is decidable. -/
def Claim : Prop := ComputablePred PosInput

end OpenProblems.QEDM130
