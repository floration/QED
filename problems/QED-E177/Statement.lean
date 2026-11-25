import Mathlib
/-! QED-E177: Decision-tree depth below the cube of degree
Every Boolean function f on n bits is uniquely a real multilinear polynomial; let deg(f) be its degree and D(f) the fewest adaptive bit queries that always determine f(x). Since 2004 we know D(f) <= deg(f)^3, while the largest known gap is only about quadratic. Lower the exponent 3: show D(f) <= C·deg(f)^{3-ε} for some fixed ε > 0.
Informal statement: For $f:\{0,1\}^n\to\{0,1\}$ let $D(f)$ be the minimum depth of a deterministic decision tree computing $f$, and $\deg(f)$ the degree of the unique multilinear polynomial over $\mathbb R$ agreeing with $f$. Prove there exist $\varepsilon>0$ and $C$ such that $D(f)\le C\,\deg(f)^{3-\varepsilon}$ for all $n$ and all $f$. (Stronger, also open: $D(f)=O(\deg(f)^2)$.)
Formalization notes:
* Boolean functions: `f : (Fin n → Bool) → Bool` (`true` ↔ 1).
* Decision trees: inductive type `DTree n` with leaves labelled by an output bit and internal
  nodes querying a variable `i : Fin n`, with a subtree for each answer. `eval` runs the tree on
  an input, `depth` is the length of the longest root-to-leaf path. `D f` is the infimum (`sInf`
  in ℕ) of depths of trees with `eval t = f`; the set is nonempty (the complete tree querying
  all variables computes `f`), so `sInf` is the genuine minimum, no junk value.
* Degree: the unique real multilinear polynomial `p(x) = Σ_S c_S ∏_{i∈S} x_i` agreeing with f on
  {0,1}^n has coefficients given by Möbius inversion,
  `c_S = Σ_{T ⊆ S} (-1)^{|S|-|T|} f(1_T)` (an integer; `1_T` is the indicator input of T).
  `deg f` is the largest `|S|` with `c_S ≠ 0` (0 if none, i.e. f ≡ 0). This is the standard
  degree (equal to the Fourier degree).
* Claim: ∃ ε > 0, ∃ C : ℝ, ∀ n f, D f ≤ C · deg(f)^{3-ε} (real power `rpow`). Edge cases:
  deg f = 0 iff f is constant, and then D f = 0, so the inequality holds there whatever the
  junk value of `0 ^ (3-ε)` (always 0 or 1 ≥ 0, with C ≥ 0 forced by any nonconstant f).
  Large ε gives no loophole: ε ≥ 1 would contradict the known quadratic separation
  (pointer functions), so a proof necessarily has 0 < ε < 1.
* Proving `Claim` = an improvement of Midrijanis's exponent 3. Proving `¬Claim` = for every
  ε > 0 the ratio D(f)/deg(f)^{3-ε} is unbounded.
-/
namespace OpenProblems.QEDE177
noncomputable section

/-- Deterministic decision trees on `n` Boolean variables. -/
inductive DTree (n : ℕ) : Type
  | leaf : Bool → DTree n
  | node : Fin n → DTree n → DTree n → DTree n

namespace DTree

/-- Run the tree on input `x`: at `node i t0 t1` go to `t1` if `x i = true`, else to `t0`. -/
def eval {n : ℕ} : DTree n → (Fin n → Bool) → Bool
  | leaf b, _ => b
  | node i t0 t1, x => if x i then eval t1 x else eval t0 x

/-- Depth: number of queries on the longest path. -/
def depth {n : ℕ} : DTree n → ℕ
  | leaf _ => 0
  | node _ t0 t1 => max (depth t0) (depth t1) + 1

end DTree

/-- Deterministic query complexity. -/
def D {n : ℕ} (f : (Fin n → Bool) → Bool) : ℕ :=
  sInf {d : ℕ | ∃ t : DTree n, t.eval = f ∧ t.depth = d}

/-- Coefficient of `∏_{i ∈ S} x_i` in the multilinear representation of `f`. -/
def coeff {n : ℕ} (f : (Fin n → Bool) → Bool) (S : Finset (Fin n)) : ℤ :=
  ∑ T ∈ S.powerset, (-1 : ℤ) ^ (S.card - T.card) *
    (if f (fun i : Fin n => decide (i ∈ T)) then 1 else 0)

open scoped Classical in
/-- Real (multilinear) degree. -/
def deg {n : ℕ} (f : (Fin n → Bool) → Bool) : ℕ :=
  ((Finset.univ : Finset (Finset (Fin n))).filter (fun S : Finset (Fin n) => coeff f S ≠ 0)).sup
    Finset.card

def Claim : Prop :=
  ∃ ε : ℝ, 0 < ε ∧ ∃ C : ℝ, ∀ (n : ℕ) (f : (Fin n → Bool) → Bool),
    (D f : ℝ) ≤ C * (deg f : ℝ) ^ (3 - ε)

end
end OpenProblems.QEDE177
