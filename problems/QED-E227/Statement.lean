import Mathlib
/-! QED-E227: The prime-sum graph is Hamiltonian-laceable
Line up the numbers 1 to 2n so that neighbours always sum to a prime, starting at any chosen odd
number and ending at any chosen even number.
Informal statement: Let Γ_n be the graph on [2n] = {1, …, 2n} with xy an edge iff x ≠ y and x + y is
prime (it is bipartite: odd vs. even). Prove that for all sufficiently large n, for every odd a and even
b in [2n], Γ_n has a Hamiltonian path from a to b. (Conjecturally this holds for all n ≥ 4.)
Formalization notes: A Hamiltonian path of Γ_n from a to b is a list `l` that is a permutation of
[1, …, 2n] (`List.Perm l (List.range' 1 (2 * n))`, so every vertex appears exactly once), whose first
entry is a and last entry is b, and whose consecutive entries sum to a prime (distinctness of
neighbours is automatic). Consecutive entries are accessed with `getD` (the default is never used since
indices are in range). `Claim` is the "sufficiently large n" version; the conjectural n ≥ 4 version is
not stated. Proving `Claim` = eventual Hamiltonian-laceability; `¬Claim` = infinitely many n with some
odd a, even b admitting no such path.
-/
namespace OpenProblems.QEDE227

noncomputable section

/-- `l` is a Hamiltonian path of the prime-sum graph on `{1, …, 2n}` from `a` to `b`. -/
def IsPrimeSumHamPath (n a b : ℕ) (l : List ℕ) : Prop :=
  List.Perm l (List.range' 1 (2 * n)) ∧ l.head? = some a ∧ l.getLast? = some b ∧
    ∀ i : ℕ, i + 1 < l.length → (l.getD i 0 + l.getD (i + 1) 0).Prime

def Claim : Prop :=
  ∃ N : ℕ, ∀ n : ℕ, N ≤ n → ∀ a b : ℕ, 1 ≤ a → a ≤ 2 * n → 1 ≤ b → b ≤ 2 * n →
    a % 2 = 1 → b % 2 = 0 → ∃ l : List ℕ, IsPrimeSumHamPath n a b l

end

end OpenProblems.QEDE227
