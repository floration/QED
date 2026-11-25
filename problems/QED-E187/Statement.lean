import Mathlib
/-! QED-E187: Rademacher sums exceed √2 standard deviations with probability at most 1/8
Take real weights a_1,...,a_n with a_1²+...+a_n²=1 and independent fair ±1 signs, and form X = Σ a_i ε_i. With three equal weights 1/√3, X equals √3 with probability 1/8, so P(X > √2) can be 1/8. Prove that P(X > √2) <= 1/8 for every n and all such weights.
Informal statement: For $n\ge1$ and $a\in\mathbb R^n$ with $\sum_i a_i^2=1$, let $\varepsilon_1,\dots,\varepsilon_n$ be i.i.d. uniform on $\{\pm1\}$. Prove $\Pr\big(\sum_i a_i\varepsilon_i>\sqrt2\big)\le 1/8$; equivalently $\#\{\varepsilon\in\{\pm1\}^n:\langle a,\varepsilon\rangle>\sqrt2\}\le 2^{n-3}$. (Equality is attained, e.g. $a=(1,1,1)/\sqrt3$.)
Formalization notes:
* Sign vectors are `ε : Fin n → Bool` with `true ↦ +1`, `false ↦ -1`; the uniform probability
  is the counting ratio over the 2^n vectors, so P(X > √2) ≤ 1/8 is `8 · #{ε : X(ε) > √2} ≤ 2^n`.
* The constraint ∑ a_i² = 1 excludes n = 0 automatically. Strict inequality `> √2` as stated.
* Proving Claim = Hollom–Portier Conjecture 6.2 at the point √2; ¬Claim = explicit weights with
  P(X > √2) > 1/8.
-/
namespace OpenProblems.QEDE187
noncomputable section
open scoped Classical

/-- `±1` value of a Boolean sign. -/
def sgn (b : Bool) : ℝ := if b then 1 else -1

def Claim : Prop :=
  ∀ n : ℕ, ∀ a : Fin n → ℝ, ∑ i : Fin n, a i ^ 2 = 1 →
    ((Finset.univ : Finset (Fin n → Bool)).filter
      (fun ε : Fin n → Bool => Real.sqrt 2 < ∑ i : Fin n, a i * sgn (ε i))).card * 8 ≤ 2 ^ n

end
end OpenProblems.QEDE187
