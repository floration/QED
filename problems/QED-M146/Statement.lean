import Mathlib
/-! QED-M146: Primes with a missing digit in bases 10 and 11 at once
Are there infinitely many primes that have no digit 9 when written in base 10 and also no digit 10
(the digit 'A') when written in base 11?
Informal statement: Let 𝒜 = {n ≥ 1 : 9 is not a base-10 digit of n and 10 is not a base-11 digit of n}.
Prove that 𝒜 contains infinitely many primes. (A stronger goal is
#{p ≤ x : p ∈ 𝒜} = x^{γ+o(1)} with γ = log 9/log 10 + log 10/log 11 − 1 ≈ 0.9145; it is not part of
this Claim.)
Formalization notes: Base-b digits are `Nat.digits b n` (least significant first, no leading zeros,
so "9 is not a digit" is exactly `9 ∉ Nat.digits 10 p`). Primes are ≥ 2, so the condition n ≥ 1 is
automatic. `Claim` is the infinitude statement; proving it answers the question positively, `¬Claim`
means only finitely many such primes exist. The asymptotic count is not formalized.
-/
namespace OpenProblems.QEDM146

noncomputable section

def Claim : Prop :=
  Set.Infinite {p : ℕ | p.Prime ∧ 9 ∉ Nat.digits 10 p ∧ 10 ∉ Nat.digits 11 p}

end

end OpenProblems.QEDM146
