import Mathlib
/-! QED-E127: Two colours, sums of at most two: does every solution compute the halting problem?
Hindman's theorem says that for any finite colouring of the positive integers there is an infinite set H all of whose finite sums have one colour. Restrict this to sums of one or two distinct elements. A computable 4-colouring is known to force every such H to compute the halting problem, but with only 2 colours (and no extra 'apartness' condition) nobody knows. Decide whether some computable 2-colouring forces every solution to compute the halting problem.
Informal statement: For $H\subseteq\mathbb N_{>0}$ let $FS^{\le2}(H)=H\cup\{x+y:x,y\in H,\ x\ne y\}$. Decide whether there exists a computable $c:\mathbb N_{>0}\to\{0,1\}$ such that every infinite $H\subseteq\mathbb N_{>0}$ on which $FS^{\le2}(H)$ is $c$-monochromatic satisfies $\emptyset'\le_T H$. Either answer is a solution. (A relativizable positive answer gives $\mathsf{RCA}_0\vdash\mathsf{HT}^{\le2}_2\to\mathsf{ACA}_0$.)
Formalization notes:
* Colourings are `c : ℕ → Bool` with Mathlib's `Computable c`; the value `c 0` is irrelevant
  since solutions lie in the positive integers, so this is the same as a computable colouring
  of `ℕ_{>0}`.
* `FS2 H = H ∪ {a + b : a, b ∈ H, a ≠ b}`.
* The halting set `∅'` is `K = {n | φₙ(n)↓}`, where `φₙ` is `Nat.Partrec.Code.eval` of the code
  `Denumerable.ofNat Nat.Partrec.Code n` (Mathlib's standard Gödel numbering of partial
  recursive codes). Sets are represented by their total 0/1 characteristic functions as
  `ℕ →. ℕ` (`Part.some`), and `∅' ≤_T H` is Mathlib's `TuringReducible (chiK) (chi H)`,
  i.e. `chiK` is partial recursive relative to the oracle `chi H` (`RecursiveIn {chi H}`).
* `Claim`: some computable 2-colouring has every infinite monochromatic `FS^{≤2}` solution
  `H ⊆ ℕ_{>0}` computing `∅'`. Solutions exist for every colouring (Hindman), so the
  universal statement is not vacuous. Proving `Claim` or `¬Claim` (every computable 2-colouring
  has an infinite solution not computing `∅'`) both answer the problem.
-/
namespace OpenProblems.QEDE127
noncomputable section
open scoped Classical

/-- Sums of one or two distinct elements of `H`. -/
def FS2 (H : Set ℕ) : Set ℕ :=
  {x : ℕ | x ∈ H ∨ ∃ a ∈ H, ∃ b ∈ H, a ≠ b ∧ x = a + b}

/-- Characteristic function of a set, as a total function `ℕ →. ℕ`. -/
def chi (S : Set ℕ) : ℕ →. ℕ := fun n : ℕ => Part.some (if n ∈ S then 1 else 0)

/-- The halting set `∅' = {n | φₙ(n)↓}`. -/
def haltK : Set ℕ :=
  {n : ℕ | (Nat.Partrec.Code.eval (Denumerable.ofNat Nat.Partrec.Code n) n).Dom}

def Claim : Prop :=
  ∃ c : ℕ → Bool, Computable c ∧
    ∀ H : Set ℕ, H.Infinite → (∀ x ∈ H, 0 < x) →
      (∃ b : Bool, ∀ x ∈ FS2 H, c x = b) →
        TuringReducible (chi haltK) (chi H)

end
end OpenProblems.QEDE127
