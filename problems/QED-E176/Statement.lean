import Mathlib
/-! QED-E176: Block sensitivity below the fourth power of sensitivity
For a Boolean function f on n bits, the sensitivity s(f) is the largest number of single bits
that can each, on their own, change the output at one input. The block sensitivity bs(f) is the
largest number of disjoint groups of bits that can each, flipped together, change the output at
one input. Huang's 2019 theorem gives bs(f) <= s(f)^4, and no better power is known. Can the
exponent 4 be lowered?
Informal statement: For f : {0,1}^n → {0,1} and B ⊆ [n] let x^B be x with the bits in B flipped.
Let s(f) = max_x |{i : f(x) ≠ f(x^{i})}| and bs(f) = max_x max{k : ∃ pairwise disjoint nonempty
B₁,…,B_k ⊆ [n] with f(x^{B_j}) ≠ f(x) ∀ j}. Prove that there exist constants ε > 0 and C such that
bs(f) ≤ C·s(f)^{4−ε} for every n and every f.
Formalization notes:
* Inputs are `Fin n → Bool`, functions `f : (Fin n → Bool) → Bool`; `flipSet x B` flips the
  coordinates in `B : Finset (Fin n)`.
* `sens f` is the max over x (a `Finset.sup` over the finite cube) of the number of sensitive
  coordinates; `blockSens f` is the max over x and over finite families `𝓑` of pairwise disjoint,
  nonempty, sensitive blocks of `𝓑.card`. These are exactly the standard s(f), bs(f).
* The power is the real power `rpow`. If s(f) = 0 then f is constant and bs(f) = 0, so the
  convention 0^a = 0 (a ≠ 0) is harmless; an ε ≥ 4 only makes the claim false, not vacuous.
* Proving `Claim` = an exponent 4 − ε; `¬Claim` = functions with bs ≥ s^{4−o(1)} (i.e. for every
  ε, C a counterexample f).
-/
namespace OpenProblems.QEDE176
noncomputable section
open Classical

/-- Flip the bits of `x` in `B`. -/
def flipSet {n : ℕ} (x : Fin n → Bool) (B : Finset (Fin n)) : Fin n → Bool :=
  fun i => if i ∈ B then !(x i) else x i

/-- Number of sensitive coordinates of `f` at `x`. -/
def sensAt {n : ℕ} (f : (Fin n → Bool) → Bool) (x : Fin n → Bool) : ℕ :=
  (Finset.univ.filter (fun i : Fin n => f (flipSet x {i}) ≠ f x)).card

/-- Sensitivity `s(f)`. -/
def sens {n : ℕ} (f : (Fin n → Bool) → Bool) : ℕ :=
  Finset.univ.sup (fun x : Fin n → Bool => sensAt f x)

/-- `𝓑` is a family of pairwise disjoint, nonempty blocks, each sensitive for `f` at `x`. -/
def SensitiveBlocks {n : ℕ} (f : (Fin n → Bool) → Bool) (x : Fin n → Bool)
    (𝓑 : Finset (Finset (Fin n))) : Prop :=
  (∀ B ∈ 𝓑, B.Nonempty ∧ f (flipSet x B) ≠ f x) ∧
    (∀ B ∈ 𝓑, ∀ B' ∈ 𝓑, B ≠ B' → Disjoint B B')

/-- Block sensitivity of `f` at `x`. -/
def blockSensAt {n : ℕ} (f : (Fin n → Bool) → Bool) (x : Fin n → Bool) : ℕ :=
  (Finset.univ.filter (fun 𝓑 : Finset (Finset (Fin n)) => SensitiveBlocks f x 𝓑)).sup
    (fun 𝓑 => 𝓑.card)

/-- Block sensitivity `bs(f)`. -/
def blockSens {n : ℕ} (f : (Fin n → Bool) → Bool) : ℕ :=
  Finset.univ.sup (fun x : Fin n → Bool => blockSensAt f x)

def Claim : Prop :=
  ∃ ε : ℝ, 0 < ε ∧ ∃ C : ℝ, ∀ (n : ℕ) (f : (Fin n → Bool) → Bool),
    (blockSens f : ℝ) ≤ C * (sens f : ℝ) ^ (4 - ε)

end
end OpenProblems.QEDE176
