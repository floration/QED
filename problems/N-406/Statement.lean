import Mathlib
open Filter Topology
/-! N-406: Irrational prime weights
Informal: Prove $\sum_{p}\frac{1}{p\,2^{p}}$ is irrational. -/
namespace OpenProblems.N406

def Claim : Prop :=
  Irrational (∑' p : Nat.Primes, (1 : ℝ) / ((p : ℝ) * 2 ^ (p : ℕ)))
end OpenProblems.N406
