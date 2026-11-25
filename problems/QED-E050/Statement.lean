import Mathlib
/-! QED-E050: Does Antihydra halt?
Start with 8 and repeatedly replace a by ⌊3a/2⌋. Score +2 for each even term and −1 for each odd term. Does the running score ever go negative?
Informal statement: With a₀ = 8, a_{n+1} = ⌊3aₙ/2⌋, E_n = #{i < n : aᵢ even}, O_n = #{i < n : aᵢ odd}, is O_n ≤ 2E_n for every n? (Equivalently, the 6-state TM 1RB1RA_0LC1LE_1LD1LC_1LA0LB_1LF1RE_---0RA never halts, per the bbchallenge wiki.)
Formalization notes: `a` is the Hydra/Antihydra orbit with ℕ floor division. The score after n terms is 2·E n − O n; since it moves by +2 or −1, it goes negative iff it hits −1, iff O n > 2·E n for some n. `Claim` = "Antihydra never halts" (the conjectured answer). `¬Claim` = Antihydra halts. The TM equivalence itself is not formalized.
-/
namespace OpenProblems.QEDE050

/-- The Antihydra orbit: a₀ = 8, a_{n+1} = ⌊3aₙ/2⌋. -/
def a : ℕ → ℕ
  | 0 => 8
  | n + 1 => 3 * a n / 2

/-- Number of even terms among a₀, …, a_{n-1}. -/
def E (n : ℕ) : ℕ := ((Finset.range n).filter (fun i : ℕ => Even (a i))).card

/-- Number of odd terms among a₀, …, a_{n-1}. -/
def O (n : ℕ) : ℕ := ((Finset.range n).filter (fun i : ℕ => ¬ Even (a i))).card

/-- Antihydra never halts. -/
def Claim : Prop := ∀ n : ℕ, O n ≤ 2 * E n

end OpenProblems.QEDE050
