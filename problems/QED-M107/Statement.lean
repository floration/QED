import Mathlib
/-! QED-M107: The Thorp shuffle mixes in O(log n) steps
Take a deck of n = 2^d cards and cut it into two equal halves. For each i, the i-th card of each half are placed next to each other, with a fair coin deciding which goes on top. Repeat. A counting argument shows about 2d shuffles are needed before the deck can be close to uniformly random. Prove that a constant times d shuffles always suffice.
Informal statement: Let $n=2^d$, $h=n/2$. For $\xi\in\{0,1\}^h$ let $\sigma_\xi\in S_n$ put the cards from positions $i$ and $i+h$ into positions $2i,2i+1$, in that order if $\xi_i=0$ and swapped if $\xi_i=1$ ($0\le i<h$). Let $\mu_d$ be uniform on $\{\sigma_\xi\}$ and $t_{\rm mix}(d)=\min\{t:\|\mu_d^{*t}-U_{S_n}\|_{TV}\le 1/4\}$. Prove there is an absolute constant $C$ with $t_{\rm mix}(d)\le Cd$ for all $d\ge1$. (Counting the support gives $t_{\rm mix}(d)\ge(2-o(1))d$.)
Formalization notes:
* Positions are `Fin (2^d)`, h = 2^(d-1) (= n/2 for d ≥ 1; only d ≥ 1 is used). `step d ξ`
  maps a position p to the card's new position: if p < h (i = p) it goes to 2i + [ξ i], if
  p ≥ h (i = p - h = p % h) it goes to 2i + 1 - [ξ i]. So ξ i = false puts the card from i at
  2i and the card from i+h at 2i+1, and ξ i = true swaps them, exactly σ_ξ. The value is
  reduced mod 2^d only to build a `Fin` without a proof; since 2i+1 < 2^d this never changes it.
* `run d l` composes the steps for a list l of coin vectors (`run d [ξ₁,…,ξ_t] = σ_{ξ₁} ∘ … ∘
  σ_{ξ_t}`). The t-step law μ_d^{*t} is computed by counting: `prob d t σ` = fraction of the
  2^{ht} sequences s : Fin t → (Fin h → Bool) whose composite equals σ. (Composition order is
  irrelevant: the iid sequence and its reversal have the same law.) Composites of these
  bijections are bijections, so this is the full law on S_n; comparing as functions avoids
  building `Equiv`s.
* `tv d t` = (1/2) Σ_{σ ∈ S_n} |prob d t σ − 1/n!|, the total-variation distance to uniform.
* `Claim` : ∃ C : ℕ, ∀ d ≥ 1, ∃ t ≤ C·d with tv d t ≤ 1/4, i.e. t_mix(d) ≤ C·d (t_mix is a
  minimum over t, so it is ≤ C d iff some t ≤ C d has tv ≤ 1/4). A natural-number C is
  no loss of generality. Proving `¬Claim`: t_mix(d)/d is unbounded.
-/
namespace OpenProblems.QEDM107
noncomputable section
open scoped Classical

/-- One Thorp shuffle with coin vector `ξ`, as a map old position ↦ new position. -/
def step (d : ℕ) (ξ : Fin (2 ^ (d - 1)) → Bool) (p : Fin (2 ^ d)) : Fin (2 ^ d) :=
  let h : ℕ := 2 ^ (d - 1)
  let i : Fin (2 ^ (d - 1)) := ⟨p.val % 2 ^ (d - 1), Nat.mod_lt _ (pow_pos (by norm_num : (0 : ℕ) < 2) (d - 1))⟩
  let dest : ℕ :=
    if p.val < h then 2 * i.val + (if ξ i then 1 else 0)
    else 2 * i.val + (if ξ i then 0 else 1)
  ⟨dest % 2 ^ d, Nat.mod_lt _ (pow_pos (by norm_num : (0 : ℕ) < 2) d)⟩

/-- Composite of the shuffles given by a list of coin vectors. -/
def run (d : ℕ) : List (Fin (2 ^ (d - 1)) → Bool) → (Fin (2 ^ d) → Fin (2 ^ d))
  | [] => id
  | ξ :: l => step d ξ ∘ run d l

/-- Probability that `t` independent Thorp shuffles produce the permutation `σ`. -/
def prob (d t : ℕ) (σ : Equiv.Perm (Fin (2 ^ d))) : ℝ :=
  ((Finset.univ.filter (fun s : Fin t → (Fin (2 ^ (d - 1)) → Bool) =>
      run d (List.ofFn s) = (σ : Fin (2 ^ d) → Fin (2 ^ d)))).card : ℝ) /
    (Fintype.card (Fin t → (Fin (2 ^ (d - 1)) → Bool)) : ℝ)

/-- Total-variation distance between the `t`-step law and the uniform law on `S_{2^d}`. -/
def tv (d t : ℕ) : ℝ :=
  (1 / 2 : ℝ) * ∑ σ : Equiv.Perm (Fin (2 ^ d)),
    |prob d t σ - 1 / ((Nat.factorial (2 ^ d) : ℕ) : ℝ)|

def Claim : Prop :=
  ∃ C : ℕ, ∀ d : ℕ, 1 ≤ d → ∃ t : ℕ, t ≤ C * d ∧ tv d t ≤ 1 / 4

end
end OpenProblems.QEDM107
