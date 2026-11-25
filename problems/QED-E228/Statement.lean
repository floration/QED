import Mathlib
/-! QED-E228: Consecutive primes alternating between 1 and 3 mod 4
Prime numbers other than 2 leave remainder 1 or 3 when divided by 4. Shiu proved that arbitrarily long runs of consecutive primes all with the same remainder occur. Show that, for every k, there are infinitely many runs of k consecutive primes whose remainders alternate 1, 3, 1, 3, .... Even k = 3 (a prime that is 3 mod 4 sandwiched between two primes that are 1 mod 4) is open.
Informal statement: Let $p_n$ be the $n$-th prime. Prove that for every $k\ge3$ there are infinitely many $n$ with $p_{n+i}\equiv 2-(-1)^{i}\pmod 4$ for $0\le i<k$ (i.e. the residues run $1,3,1,3,\dots$). The first open case is $k=3$: infinitely many $n$ with $(p_n,p_{n+1},p_{n+2})\equiv(1,3,1)\pmod 4$.
Formalization notes: `Nat.nth Nat.Prime n` is the n-th prime, 0-indexed (p₀ = 2); the indexing shift is
irrelevant for "infinitely many n". The pattern is `pₙ₊ᵢ % 4 = 1` for even i and `3` for odd i, as in the plain
statement and the k = 3 headline. (The original formula 2 + (−1)^i gave the pattern 3,1,3,…, contradicting the
stated k = 3 case; corrected. For the statement "for every k" the two versions are equivalent: an alternating run
of length k + 1 starting with either residue contains one of length k starting with the other.) "Infinitely
many n" is written as: for every N there is n ≥ N. `Claim` quantifies over all k (k ≤ 2 are trivially true and
harmless). `¬Claim` = for some k only finitely many such runs exist.
-/
namespace OpenProblems.QEDE228
noncomputable section

/-- For every `k`, infinitely many runs of `k` consecutive primes have residues `1, 3, 1, 3, …` mod 4. -/
def Claim : Prop :=
  ∀ k N : ℕ, ∃ n : ℕ, N ≤ n ∧
    ∀ i : ℕ, i < k → Nat.nth Nat.Prime (n + i) % 4 = if i % 2 = 0 then 1 else 3

end
end OpenProblems.QEDE228
