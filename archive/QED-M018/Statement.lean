import Mathlib
/-! QED-M018: Breaking the log k barrier for 3-petal sunflowers
Let f(k,3) be the least m such that every family of m distinct k-element sets contains three
sets whose pairwise intersections all coincide (a 3-petal sunflower). The best known bound is
f(k,3) <= (C log k)^k (Alweiss-Lovett-Wu-Zhang, Rao, Bell-Chueluecha-Warnke). The problem asks
to beat the log k barrier: f(k,3) <= (eps(k) log k)^k with eps(k) -> 0.
Informal statement: Let f(k,3) be the least m such that every family of m distinct k-element
sets contains a 3-petal sunflower. Prove f(k,3) <= (eps(k) log k)^k for some eps(k) -> 0
(e.g. f(k,3) <= (log k)^{(1-c)k}).
Formalization notes: Sets are finite subsets of ℕ (the ground set is irrelevant, since any
finite family lives on a finite ground set). A 3-petal sunflower is three pairwise distinct
members A, B, C with A ∩ B = A ∩ C = B ∩ C. "f(k,3) <= (eps(k) log k)^k for some eps(k) -> 0"
is encoded in the equivalent form: for every ε > 0 there is K such that for all k >= K every
family of k-sets of size strictly greater than (ε log k)^k contains a 3-petal sunflower.
Proving Claim breaks the log k barrier; proving ¬Claim shows there is ε > 0 and infinitely many
k with sunflower-free families of more than (ε log k)^k k-sets, i.e. that
f(k,3) >= (ε log k)^k infinitely often (this would refute the Erdős-Rado sunflower conjecture
for 3 petals). Known: f(k,3) <= (C log k)^k.
-/
namespace OpenProblems.QEDM018

/-- Three sets form a sunflower with 3 petals: they are pairwise distinct and all pairwise
intersections coincide. -/
def IsSunflower3 (A B C : Finset ℕ) : Prop :=
  A ≠ B ∧ A ≠ C ∧ B ≠ C ∧ A ∩ B = A ∩ C ∧ A ∩ B = B ∩ C

def Claim : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ K : ℕ, ∀ k : ℕ, K ≤ k →
    ∀ F : Finset (Finset ℕ), (∀ A ∈ F, A.card = k) →
      (ε * Real.log (k : ℝ)) ^ k < (F.card : ℝ) →
        ∃ A ∈ F, ∃ B ∈ F, ∃ C ∈ F, IsSunflower3 A B C

end OpenProblems.QEDM018
