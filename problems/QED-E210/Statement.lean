import Mathlib
/-! QED-E210: Thue-Morse along fourth powers
Let s(m) be the number of 1s in the binary expansion of m. It is known that s(n), s(n^2) and (since 2023) s(n^3)
are even for asymptotically half of all n. Prove the same for fourth powers: s(n^4) is even for asymptotically
half of all n.
Informal statement: Let $s_2(m)$ be the binary digit sum. Prove
$\lim_{N\to\infty}\frac1N\#\{0\le n<N:\ s_2(n^4)\equiv0\pmod 2\}=\tfrac12$.
Formalization notes: s₂(m) is `(Nat.digits 2 m).sum` (Mathlib's little-endian base-2 digit list; s₂(0) = 0).
The counting function is #{n ∈ range N : s₂(n⁴) even}, divided by N as a real (for N = 0 the quotient is the
junk value 0, irrelevant for a limit at infinity). `Claim` = the ratio tends to 1/2. `¬Claim` = it does not
(the strengthening to all n^k, k ≥ 4, is not encoded).
-/
namespace OpenProblems.QEDE210

noncomputable section

/-- Binary digit sum. -/
def s2 (m : ℕ) : ℕ := (Nat.digits 2 m).sum

def Claim : Prop :=
  Filter.Tendsto
    (fun N : ℕ => ((((Finset.range N).filter (fun n : ℕ => s2 (n ^ 4) % 2 = 0)).card : ℕ) : ℝ) / (N : ℝ))
    Filter.atTop (nhds (1 / 2 : ℝ))

end

end OpenProblems.QEDE210
