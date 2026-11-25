import Mathlib
/-! QED-M147: Largest prime factor of p−1 in residue classes
For each prime p, take the largest prime factor of p − 1. Show that this factor is 1 mod 4 for half of all primes and 3 mod 4 for the other half. More generally, show it is spread evenly over the allowed residue classes mod q.
Informal statement: Let $P(n)$ be the largest prime factor of $n$. Prove that for every fixed $q\ge2$ and every $a$ with $\gcd(a,q)=1$, $\#\{p\le x:\ P(p-1)\equiv a\ (\mathrm{mod}\ q)\}\sim\frac{\pi(x)}{\varphi(q)}$ as $x\to\infty$. The first open case is $q=4$, $a=1$: $\#\{p\le x: P(p-1)\equiv1\ (4)\}\sim\tfrac12\pi(x)$.
Formalization notes: P(n) = largest prime factor, `gpf n = max 1 (sup of n.primeFactors)`, so P(1) = 1 (only
p = 2 has p − 1 = 1; a single prime does not affect the asymptotic). x ranges over ℕ (the counts only change at
integers). `countRes q a x` = #{p ≤ x prime : P(p − 1) ≡ a (mod q)}, written as `gpf (p-1) % q = a % q`
(truncated subtraction is harmless since p ≥ 2). The asymptotic `count ∼ π(x)/φ(q)` is stated as
`count / π(x) → 1/φ(q)`, which is equivalent because π(x) > 0 for x ≥ 2 and φ(q) ≥ 1 (the ratio's junk value
for x < 2 does not affect the limit). `Nat.primeCounting x` = π(x), `Nat.totient` = φ. `Claim` = the
asymptotic for all q ≥ 2 and all a coprime to q; `¬Claim` = it fails for some (q, a), e.g. a persistent bias
for q = 4.
-/
namespace OpenProblems.QEDM147
noncomputable section

/-- Largest prime factor of `n`, with `gpf 0 = gpf 1 = 1`. -/
def gpf (n : ℕ) : ℕ := max 1 (n.primeFactors.sup id)

/-- `#{p ≤ x prime : P(p - 1) ≡ a (mod q)}`. -/
def countRes (q a x : ℕ) : ℕ :=
  ((Finset.range (x + 1)).filter (fun p : ℕ => p.Prime ∧ gpf (p - 1) % q = a % q)).card

/-- `P(p - 1)` is equidistributed among the reduced residue classes mod `q`. -/
def Claim : Prop :=
  ∀ q a : ℕ, 2 ≤ q → Nat.Coprime a q →
    Filter.Tendsto (fun x : ℕ => (countRes q a x : ℝ) / (Nat.primeCounting x : ℝ))
      Filter.atTop (nhds (1 / (Nat.totient q : ℝ)))

end
end OpenProblems.QEDM147
