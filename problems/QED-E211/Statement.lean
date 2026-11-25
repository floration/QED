import Mathlib
/-! QED-E211: Two consecutive 1s infinitely often in the binary expansion of √2
Write √2 in binary: 1.0110101000001001111... Every irrational number has infinitely many 0s, 1s, '01's and '10's in its binary expansion, but nothing known forces '11' to appear infinitely often. Prove that the block 11 occurs infinitely often in the binary expansion of √2.
Informal statement: Let $b_n=\lfloor 2^n\sqrt2\rfloor \bmod 2$. Prove that $\{n\ge0: b_n=b_{n+1}=1\}$ is infinite; equivalently, no tail of the binary expansion of $\sqrt2$ avoids the block $11$.
Formalization notes: Since √2 is irrational its binary expansion is unique, and its n-th binary
digit after the point (n ≥ 1; n = 0 gives the units digit 1) is ⌊2^n √2⌋ mod 2. We define
`bit n := ⌊(2:ℝ)^n * √2⌋ % 2` as an integer (`Int.floor`, `Real.sqrt`; the value is in {0,1}
because ⌊·⌋ ≥ 0 here and `%` on ℤ with positive modulus is the nonnegative remainder). Claim says
the set of n with bit n = bit (n+1) = 1 is infinite. Including n = 0 (the integer digit) changes
nothing, since only infinitude matters. Proving ¬Claim means showing the expansion of √2 is
eventually free of the block 11.
-/
namespace OpenProblems.QEDE211
noncomputable section

/-- The n-th binary digit of √2 (n = 0: units digit; n ≥ 1: n-th digit after the point). -/
def bit (n : ℕ) : ℤ := ⌊(2 : ℝ) ^ n * Real.sqrt 2⌋ % 2

def Claim : Prop :=
  Set.Infinite {n : ℕ | bit n = 1 ∧ bit (n + 1) = 1}

end
end OpenProblems.QEDE211
