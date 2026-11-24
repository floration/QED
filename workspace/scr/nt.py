DEF={
'P':"/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/\ndef P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id",
'SF':"/-- no decimal digit 7 -/\ndef SevenFree (n : ℕ) : Prop := 7 ∉ Nat.digits 10 n",
'rev':"/-- decimal digit reversal -/\ndef rev (n : ℕ) : ℕ := Nat.ofDigits 10 (Nat.digits 10 n).reverse",
'ds':"/-- digit sum in base `b` -/\ndef ds (b n : ℕ) : ℕ := (Nat.digits b n).sum",
'Om':"/-- number of prime factors with multiplicity -/\ndef Ω (n : ℕ) : ℕ := n.primeFactorsList.length",
'carm':"/-- Carmichael number (Korselt-free definition) -/\ndef Carmichael (n : ℕ) : Prop := 1 < n ∧ ¬ n.Prime ∧ ∀ a : ℕ, Nat.Coprime a n → a ^ (n - 1) ≡ 1 [MOD n]",
'cnt':"/-- `#{n ≤ x : S n}` -/\nnoncomputable def count (S : ℕ → Prop) (x : ℕ) : ℕ := Nat.card {n : ℕ // n ≤ x ∧ S n}",
'pn':"/-- `p k` is the k-th prime, `p 1 = 2` -/\nnoncomputable def pr (k : ℕ) : ℕ := Nat.nth Nat.Prime (k - 1)",
}
S={
'N-026':('SF',"∀ q : ℚ, 0 < q → q < 1 → ∃ D : Finset ℕ, (∀ d ∈ D, 0 < d ∧ SevenFree d) ∧ ∑ d ∈ D, (1 : ℚ) / d = q"),
'N-066':('SF',"∃ N₀ : ℕ, ∀ N ≥ N₀, Odd N → ∃ p₁ p₂ p₃ : ℕ, p₁.Prime ∧ p₂.Prime ∧ p₃.Prime ∧ SevenFree p₁ ∧ SevenFree p₂ ∧ SevenFree p₃ ∧ p₁ + p₂ + p₃ = N"),
'N-102':('rev Om',"Set.Infinite {p : ℕ | p.Prime ∧ Ω (rev p) ≤ 3}"),
'N-123':('P',"Set.Infinite {n : ℕ | (n : ℝ) ^ (0.9 : ℝ) < P n ∧ (n : ℝ) ^ (0.9 : ℝ) < P (n + 1) ∧ (n : ℝ) ^ (0.9 : ℝ) < P (n + 2)}"),
'N-141':('',"Set.Infinite {p : ℕ | p.Prime ∧ ((p + 2).Prime ∨ (2 * p + 1).Prime ∨ (2 * p + 3).Prime)}"),
'N-164':('P',"Set.Infinite {p : ℕ | p.Prime ∧ (p : ℝ) ^ (1.5 : ℝ) < P (p ^ 2 + p + 1)}"),
'N-175':('rev',"Set.Infinite {p : ℕ | p.Prime ∧ ∀ q ∈ (rev p).primeFactors, (p : ℝ) ^ (0.1 : ℝ) < q}"),
'N-193':('SF Om',"Set.Infinite {p : ℕ | p.Prime ∧ SevenFree p ∧ Ω (2 * p + 1) ≤ 3}"),
'N-208':('SF',"∃ x₀ : ℝ, ∀ x : ℝ, x₀ ≤ x → ∃ p : ℕ, p.Prime ∧ SevenFree p ∧ x ≤ p ∧ (p : ℝ) ≤ x + x ^ (0.6 : ℝ)"),
'N-212':('P pn',"Set.Infinite {n : ℕ | 1 ≤ n ∧ (pr (n + 1) : ℝ) ^ (1.5 : ℝ) < P (pr n * pr (n + 1) + 1)}"),
'N-213':('P SF',"Set.Infinite {p : ℕ | p.Prime ∧ SevenFree p ∧ (P (p - 1) : ℝ) ≤ (p : ℝ) ^ (0.3 : ℝ)}"),
'N-241':('SF',"Set.Infinite {p : ℕ | p.Prime ∧ SevenFree p ∧ ∃ n : ℕ, p = ⌊(n : ℝ) * Real.sqrt 2⌋₊}"),
'N-259':('SF ds',"Set.Infinite {p : ℕ | p.Prime ∧ SevenFree p ∧ (ds 10 p).Prime}"),
'N-280':('ds',"Set.Infinite {p : ℕ | p.Prime ∧ ds 2 p = ds 3 p}"),
'N-281':('',"Set.Finite {t : ℤ × ℤ × ℤ | t.1 ^ 2 + t.2.1 ^ 4 = t.2.2 ^ 7 + 7}"),
'N-282':('P',"Set.Infinite {p : ℕ | p.Prime ∧ (P (p ^ 2 + 1) : ℝ) < (p : ℝ) ^ (1 / 2 : ℝ)}"),
'N-283':('SF',"∃ N₀ : ℕ, ∀ n ≥ N₀, ∃ p a b : ℕ, p.Prime ∧ SevenFree a ∧ SevenFree b ∧ n = p + a ^ 2 + b ^ 2"),
'N-284':('SF',"∃ K N₀ : ℕ, ∀ n ≥ N₀, Even n → ∃ p : ℕ, ∃ l : List ℕ, p.Prime ∧ SevenFree p ∧ l.length ≤ K ∧ n = p + (l.map (2 ^ ·)).sum"),
'N-318':('SF cnt',"Tendsto (fun x : ℕ => (count (fun n => ¬ ∃ m p : ℕ, p.Prime ∧ SevenFree p ∧ n = m ^ 2 + p) x : ℝ) / x) atTop (𝓝 0)"),
'N-319':('',"∃ N : ℕ, ∀ n ≥ N, 7 ∈ Nat.digits 10 (n.factorial + 1)"),
'N-341':('',"Set.Infinite {t : ℕ × ℕ × ℕ | t.1.Prime ∧ t.2.1.Prime ∧ t.2.2.Prime ∧ t.1 ^ 2 + t.2.1 ^ 2 + t.2.2 ^ 2 = 3 * t.1 * t.2.1 * t.2.2}"),
'N-351':('',"Set.Infinite {r : ℕ | r.Prime ∧ ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ r = p ^ 2 + q ^ 4}"),
'N-352':('',"Set.Infinite {r : ℕ | r.Prime ∧ ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ r = p ^ 2 + q ^ 3}"),
'N-353':('P',"Set.Infinite {p : ℕ | p.Prime ∧ (P (p - 1) : ℝ) ≤ (p : ℝ) ^ (0.1 : ℝ) ∧ (P (p + 1) : ℝ) ≤ (p : ℝ) ^ (0.1 : ℝ)}"),
'N-372':('',"Set.Infinite {p : ℕ | p.Prime ∧ (p - 1).divisors.card = (p + 1).divisors.card}"),
'N-379':('carm',"Set.Infinite {n : ℕ | Carmichael n ∧ (Nat.digits 10 n).reverse = Nat.digits 10 n}"),
'N-389':('carm ds',"Set.Infinite {n : ℕ | Carmichael n ∧ (ds 10 n).Prime}"),
'N-404':('ds',"Set.Infinite {p : ℕ | p.Prime ∧ (ds 2 p).Prime ∧ (ds 10 p).Prime}"),
'N-405':('SF',"Set.Infinite {p : ℕ | p.Prime ∧ SevenFree p ∧ SevenFree (p ^ 2)}"),
'N-406':('',"Irrational (∑' p : Nat.Primes, (1 : ℝ) / ((p : ℝ) * 2 ^ (p : ℕ)))"),
'N-407':('SF pn',"Set.Infinite {q : ℕ | q.Prime ∧ SevenFree (pr q)}"),
'N-412':('carm SF',"Set.Infinite {n : ℕ | Carmichael n ∧ SevenFree (n - 1)}"),
'N-421':('',"Set.Infinite {v : ℕ × ℕ × ℕ × ℕ | v.1.Prime ∧ v.2.1.Prime ∧ v.2.2.1.Prime ∧ v.2.2.2.Prime ∧ v.1 ^ 3 + v.2.1 ^ 3 = v.2.2.1 ^ 3 + v.2.2.2 ^ 3 + 1}"),
'N-433':('SF',"Set.Infinite {n : ℕ | ∃ q₁ q₂ : ℕ, q₁.Prime ∧ q₂.Prime ∧ SevenFree q₁ ∧ SevenFree q₂ ∧ n ^ 2 + 1 = q₁ * q₂}"),
'N-435':('SF',"∀ k : ℕ, ∃ a d : ℕ, 0 < d ∧ ∀ i < k, (a + i * d).Prime ∧ SevenFree (a + i * d)"),
'N-436':('SF',"Set.Infinite {p : ℕ | p.Prime ∧ ∃ a b : ℕ, 0 < a ∧ 0 < b ∧ SevenFree a ∧ SevenFree b ∧ p = a ^ 2 + b ^ 2}"),
'N-441':('',"Set.Infinite {v : Fin 4 → ℕ | (∀ i, (v i).Prime) ∧ ∀ i : Fin 3, IsSquare (v i.castSucc + v i.succ)}"),
'N-450':('',"Set.Infinite {p : ℕ | p.Prime ∧ 9 ∉ Nat.digits 10 p ∧ 10 ∉ Nat.digits 11 p}"),
'N-463':('SF',"Set.Infinite {p : ℕ | p.Prime ∧ SevenFree p ∧ ∃ n : ℕ, p = ⌊(n : ℝ) ^ (1.1 : ℝ)⌋₊}"),
'N-477':('P',"Tendsto (fun n : ℕ => (P (2 ^ n + 3 ^ n) : ℝ) / (n : ℝ) ^ 2) atTop atTop"),
'N-484':('P',"Tendsto (fun n : ℕ => (P (2 ^ n + n) : ℝ) / n) atTop atTop"),
'N-485':('P',"Tendsto (fun n : ℕ => (P (n ^ n + 1) : ℝ) / n) atTop atTop"),
'N-498':('P cnt',"Tendsto (fun x : ℕ => (count (fun n => P n % 4 = 3 ∧ P (n + 1) % 4 = 3) x : ℝ) / x) atTop (𝓝 (1 / 4))"),
'N-453':('P cnt',"Tendsto (fun x : ℕ => (count (fun p => p.Prime ∧ P (p - 1) % 4 = 1) x : ℝ) / (count Nat.Prime x)) atTop (𝓝 (1 / 2))"),
'N-464':('P cnt',"Tendsto (fun x : ℕ => (count (fun n => P (n ^ 2 + 1) < P ((n + 1) ^ 2 + 1)) x : ℝ) / x) atTop (𝓝 (1 / 2))"),
'N-279':('P cnt',"∀ a ∈ ({1, 3, 7, 9} : Finset ℕ), ∀ b ∈ ({1, 3, 7, 9} : Finset ℕ), Tendsto (fun x : ℕ => (count (fun n => P n % 10 = a ∧ P (n + 1) % 10 = b) x : ℝ) / x) atTop (𝓝 (1 / 16))"),
'N-530':('',"Set.Infinite {n : ℕ | 3 ≤ ([n, n + 2, 2 * n + 1, 2 * n + 3].filter Nat.Prime).length}"),
'N-531':('carm SF',"Set.Infinite {n : ℕ | Carmichael n ∧ SevenFree n}"),
'N-555':('',"∀ k : ℕ, ∃ l : List ℕ, l.length = k ∧ l.Nodup ∧ (∀ p ∈ l, p.Prime) ∧ l.Chain' (fun a b => IsSquare (a + b))"),
'N-574':('P',"Irrational (∑' n : ℕ, if 2 ≤ n then (1 : ℝ) / ((n : ℝ) * P n) else 0)"),
'N-601':('SF',"∃ C : ℕ, Set.Infinite {p : ℕ | p.Prime ∧ SevenFree p ∧ ∃ q : ℕ, q.Prime ∧ SevenFree q ∧ p < q ∧ q ≤ p + C}"),
'N-603':('',"∃ N : ℕ, ∀ n ≥ N, 7 ∈ Nat.digits 10 (Fintype.card (Nat.Partition n))"),
'N-608':('P',"Summable (fun k : ℕ => (1 : ℝ) / ((fun n => P (n ^ 2 + 1))^[k] 2 : ℝ)) ∧ Irrational (∑' k : ℕ, (1 : ℝ) / ((fun n => P (n ^ 2 + 1))^[k] 2 : ℝ))"),
}
import json
D={r[0]:r for r in json.load(open('/home/claude/D2.json'))}
for pid,(uses,cl) in S.items():
    ns=pid.replace('-','');r=D[pid]
    defs='\n'.join(DEF[u] for u in uses.split())
    M=r[5].replace('-/','- /')
    open(f'/home/claude/op/problems/{pid}/Statement.lean','w').write(f"""import Mathlib
open Filter Topology
/-! {pid}: {r[1]}
Informal: {M} -/
namespace OpenProblems.{ns}
{defs}
def Claim : Prop :=
  {cl}
end OpenProblems.{ns}
""")
print(len(S))
