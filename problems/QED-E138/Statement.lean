import Mathlib
/-! QED-E138: Infinitely many non-Wieferich primes
By Fermat's little theorem, every odd prime p divides 2^(p−1)−1. Usually p^2 does not; the only known exceptions are 1093 and 3511, and there are none other below 2^64. Yet nobody can prove that the usual case happens infinitely often: are there infinitely many primes p with p^2 not dividing 2^(p−1)−1?
Informal statement: Prove that the set $\{p\text{ prime}: 2^{p-1}\not\equiv 1 \pmod{p^2}\}$ is infinite.
Formalization notes: Stated in ℕ. Natural-number subtraction is harmless since
2^(p−1) ≥ 1, so `2^(p-1) - 1` is the true value. The prime 2 is included (4 ∤ 1), which is
the standard convention and changes nothing about infiniteness. Proving Claim = infinitely
many non-Wieferich primes (base 2); ¬Claim = all but finitely many primes are Wieferich.
-/
namespace OpenProblems.QEDE138
noncomputable section

def Claim : Prop :=
  Set.Infinite {p : ℕ | p.Prime ∧ ¬ (p ^ 2 ∣ 2 ^ (p - 1) - 1)}

end
end OpenProblems.QEDE138
