import Mathlib
/-! QED-M036: Finding Huang's vertex
Huang's theorem says that any set of more than half the corners of the n-cube contains a corner
with at least √n neighbours in the set. When the set is listed by a small circuit, how hard is it
to find such a corner, or a flaw in the listing? The problem is easily shown to be at least as hard
as the pigeonhole class PPP. Is it in PPP, so that it is PPP-complete, or does Huang's
linear-algebra proof make it harder?
Informal statement: HUANG: given a Boolean circuit f : {0,1}^n → {0,1}^n with inputs read as
elements of [2^{n-1}+1] (others ignored), output either i ≠ j in [2^{n-1}+1] with f(i) = f(j), or
i, j_1, …, j_m in [2^{n-1}+1] with m = ⌈√n⌉ such that f(j_1),…,f(j_m) are distinct and each is at
Hamming distance 1 from f(i). Is HUANG ∈ PPP (under polynomial-time reductions; or, in the
black-box model, is it reducible to PIGEON)? If not, which standard TFNP class contains it, and is
it complete for it?
Formalization notes: Claim is the black-box (query / decision-tree) form of "HUANG ∈ PPP", i.e.
HUANG ∈ PPP^dt in the sense of Göös–Kamath–Robere–Sokolov and later TFNP^dt papers.
* Black-box HUANG_n: the input is the table of f : [2^{n-1}+1] → {0,1}^n, accessed bit by bit;
  input bits are indexed by `Dom n × Fin n` (`Dom n = Fin (2^(n-1)+1)`), so the input length is
  N = (2^{n-1}+1)·n and polylog(N) = poly(n). Solutions (`HSol`, `IsHSol`) are exactly the two kinds
  in the informal statement; ⌈√n⌉ is `ceilSqrt n` (integer ceiling of the square root). The witnesses
  must lie in the domain. HUANG_n is total: if f is injective its image has 2^{n-1}+1 > 2^n/2
  vertices, and by Huang some image vertex has ≥ √n, hence ≥ ⌈√n⌉, neighbours in the image.
* Black-box PIGEON_m: input table of g : {0,1}^m → {0,1}^m; solutions are z with g(z) = 0^m or
  z ≠ z' with g(z) = g(z').
* `DTree`: ordinary Boolean decision trees; depth = number of queries on the longest path.
* A depth-d reduction from HUANG_n to PIGEON_m (`DTReduction`): every bit of the PIGEON_m instance
  is computed by a depth-≤d decision tree on the HUANG_n input, and every candidate PIGEON solution
  s is mapped by a depth-≤d decision tree to a HUANG_n solution; `Correct` requires that for every
  input x, whenever s is a valid solution of the derived instance, the tree's output is a valid
  solution for x. This is the standard many-one decision-tree reduction.
* PPP^dt membership: reductions with m ≤ polylog(N) PIGEON bits (i.e. 2^{polylog N} pigeons) and
  depth polylog(N). Since log N = Θ(n), Claim asks for m ≤ (n+2)^c and depth ≤ (n+2)^c for one c
  and every n.
Proving `Claim` = a black-box reduction of HUANG to PIGEON (a uniform such reduction also gives
white-box HUANG ∈ PPP). Proving `¬Claim` = a query-complexity separation: for every c there is n
with no such reduction, i.e. HUANG ∉ PPP^dt (the white-box negative form would imply FP ≠ PPP and
is out of reach unconditionally). PPP-hardness (the converse reduction) is known and recorded in
the problem's results; the follow-up "which class contains it" is not part of Claim.
-/
namespace OpenProblems.QEDM036
noncomputable section

/-- Boolean decision trees querying bits indexed by `α`, with leaves labelled in `γ`.
`node a t₀ t₁` queries bit `a` and continues in `t₀` if it is `false`, in `t₁` if `true`. -/
inductive DTree (α : Type) (γ : Type) : Type where
  | leaf : γ → DTree α γ
  | node : α → DTree α γ → DTree α γ → DTree α γ

/-- Evaluation of a decision tree on the input `x`. -/
def DTree.eval {α γ : Type} (x : α → Bool) : DTree α γ → γ
  | DTree.leaf c => c
  | DTree.node a t₀ t₁ => if x a = true then DTree.eval x t₁ else DTree.eval x t₀

/-- Depth (number of queries on the longest root-leaf path). -/
def DTree.depth {α γ : Type} : DTree α γ → ℕ
  | DTree.leaf _ => 0
  | DTree.node _ t₀ t₁ => max (DTree.depth t₀) (DTree.depth t₁) + 1

/-- `⌈√n⌉` as a natural number. -/
def ceilSqrt (n : ℕ) : ℕ := Nat.sqrt n + if Nat.sqrt n * Nat.sqrt n = n then 0 else 1

/-- Vertices of the n-cube. -/
abbrev Cube (n : ℕ) : Type := Fin n → Bool

/-- Hamming distance. -/
def hamming {n : ℕ} (u v : Cube n) : ℕ := (Finset.univ.filter fun k : Fin n => u k ≠ v k).card

/-- The domain `[2^{n-1}+1]` of the listing. -/
abbrev Dom (n : ℕ) : Type := Fin (2 ^ (n - 1) + 1)

/-- Bit positions of a black-box HUANG_n input: bit `k` of `f(i)`. -/
abbrev HIn (n : ℕ) : Type := Dom n × Fin n

/-- The listing `f` encoded by the input bits `x`. -/
def hf {n : ℕ} (x : HIn n → Bool) (i : Dom n) : Cube n := fun k => x (i, k)

/-- Candidate HUANG_n solutions: a collision `(i, j)`, or a vertex index `i` with `⌈√n⌉` indices. -/
abbrev HSol (n : ℕ) : Type := (Dom n × Dom n) ⊕ (Dom n × (Fin (ceilSqrt n) → Dom n))

/-- Validity of a HUANG_n solution. -/
def IsHSol {n : ℕ} (x : HIn n → Bool) : HSol n → Prop
  | Sum.inl (i, j) => i ≠ j ∧ hf x i = hf x j
  | Sum.inr (i, J) =>
      Function.Injective (fun k : Fin (ceilSqrt n) => hf x (J k)) ∧
        ∀ k : Fin (ceilSqrt n), hamming (hf x i) (hf x (J k)) = 1

/-- Bit positions of a black-box PIGEON_m input: bit `k` of `g(z)`. -/
abbrev PIn (m : ℕ) : Type := Cube m × Fin m

/-- The map `g` encoded by the input bits `y`. -/
def pg {m : ℕ} (y : PIn m → Bool) (z : Cube m) : Cube m := fun k => y (z, k)

/-- Candidate PIGEON_m solutions: a preimage of `0^m`, or a collision. -/
abbrev PSol (m : ℕ) : Type := Cube m ⊕ (Cube m × Cube m)

/-- Validity of a PIGEON_m solution. -/
def IsPSol {m : ℕ} (y : PIn m → Bool) : PSol m → Prop
  | Sum.inl z => pg y z = fun _ => false
  | Sum.inr (z, z') => z ≠ z' ∧ pg y z = pg y z'

/-- A decision-tree reduction from HUANG_n to PIGEON_m. -/
structure DTReduction (n m : ℕ) where
  /-- each PIGEON input bit as a decision tree over the HUANG input -/
  bit : PIn m → DTree (HIn n) Bool
  /-- each PIGEON solution mapped back by a decision tree -/
  sol : PSol m → DTree (HIn n) (HSol n)

/-- All trees of the reduction have depth at most `d`. -/
def DTReduction.DepthLE {n m : ℕ} (R : DTReduction n m) (d : ℕ) : Prop :=
  (∀ p : PIn m, (R.bit p).depth ≤ d) ∧ ∀ s : PSol m, (R.sol s).depth ≤ d

/-- Correctness: valid PIGEON solutions of the derived instance map to valid HUANG solutions. -/
def DTReduction.Correct {n m : ℕ} (R : DTReduction n m) : Prop :=
  ∀ (x : HIn n → Bool) (s : PSol m),
    IsPSol (fun p : PIn m => DTree.eval x (R.bit p)) s → IsHSol x (DTree.eval x (R.sol s))

/-- HUANG ∈ PPP^dt: polylog(N) = poly(n) size and depth decision-tree reductions to PIGEON. -/
def Claim : Prop :=
  ∃ c : ℕ, ∀ n : ℕ, ∃ m : ℕ, m ≤ (n + 2) ^ c ∧
    ∃ R : DTReduction n m, R.DepthLE ((n + 2) ^ c) ∧ R.Correct

end
end OpenProblems.QEDM036
