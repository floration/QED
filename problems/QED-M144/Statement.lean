import Mathlib
/-! QED-M144: Joint residues of the largest prime factors of n and n+1
Let P(n) be the largest prime factor of n. Show that the last digits of P(n) and P(n+1) behave like
two independent fair choices from {1,3,7,9}: each of the 16 pairs occurs for asymptotically 1/16 of
all n. More generally, for any modulus q, the pair (P(n) mod q, P(n+1) mod q) should be uniform over
pairs of reduced residues.
Informal statement: Let P(n) denote the largest prime factor of n ≥ 2. For every q ≥ 2 and
a, b ∈ (ℤ/qℤ)^×, the natural density of {n ≥ 2 : P(n) ≡ a, P(n+1) ≡ b (mod q)} equals φ(q)⁻².
In particular (q = 10) for all a, b ∈ {1,3,7,9}, #{2 ≤ n ≤ x : P(n) ≡ a, P(n+1) ≡ b (mod 10)} ∼ x/16.
(A logarithmic-density version is a natural first step; not part of `Claim`.)
Formalization notes: `lpf m` is the maximum of `Nat.primeFactors m`; for m ≥ 2 it is the largest
prime factor (only n ≥ 2 are counted, so the junk value lpf 1 = 0 never enters). Residues are taken
by casting to `ZMod q`; "reduced residue" is `IsUnit` in `ZMod q`, and φ is `Nat.totient`.
Natural density is the limit of (1/x)·#{2 ≤ n ≤ x : …} as x → ∞ through the naturals (equivalent
to through the reals, since the count is a step function). `Claim` is the general modulus-q
statement; the mod-10 headline is its case q = 10 (φ(10) = 4), and `Claim10` records it
separately. Proving `Claim` = equidistribution for every q; proving `¬Claim` = some q, a, b for
which the density fails to exist or differs from φ(q)⁻².
-/
namespace OpenProblems.QEDM144
noncomputable section

open Filter Topology

/-- Largest prime factor of `m` (0 for `m ≤ 1`). -/
def lpf (m : ℕ) : ℕ := (Nat.primeFactors m).sup id

/-- `#{2 ≤ n ≤ x : P(n) ≡ a, P(n+1) ≡ b (mod q)}`. -/
def count (q : ℕ) (a b : ZMod q) (x : ℕ) : ℕ :=
  Set.ncard {n : ℕ | 2 ≤ n ∧ n ≤ x ∧ ((lpf n : ℕ) : ZMod q) = a ∧ ((lpf (n + 1) : ℕ) : ZMod q) = b}

/-- The mod-10 headline: each of the 16 pairs of last digits has density 1/16. -/
def Claim10 : Prop :=
  ∀ a b : ℕ, a ∈ ({1, 3, 7, 9} : Finset ℕ) → b ∈ ({1, 3, 7, 9} : Finset ℕ) →
    Tendsto (fun x : ℕ => (count 10 (a : ZMod 10) (b : ZMod 10) x : ℝ) / (x : ℝ)) atTop
      (𝓝 (1 / 16 : ℝ))

/-- Joint equidistribution of `(P(n) mod q, P(n+1) mod q)` over pairs of reduced residues. -/
def Claim : Prop :=
  ∀ q : ℕ, 2 ≤ q → ∀ a b : ZMod q, IsUnit a → IsUnit b →
    Tendsto (fun x : ℕ => (count q a b x : ℝ) / (x : ℝ)) atTop
      (𝓝 (1 / ((Nat.totient q : ℝ) ^ 2)))

end
end OpenProblems.QEDM144
