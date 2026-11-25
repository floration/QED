import Mathlib
/-! QED-E135: Property B: beat the square-root exponent
Let m(n) be the fewest sets of size n needed so that however you colour the points red and blue, some set is entirely one colour. A random construction shows m(n) is at most about n²·2ⁿ. The best lower bound, from 2000, is about √(n/log n)·2ⁿ. The task is to show that m(n) is at least n^{1/2+δ}·2ⁿ for some fixed δ > 0, a polynomial improvement over the square-root barrier.
Informal statement: Let $m(n)$ be the minimum number of edges of an $n$-uniform hypergraph that is not 2-colourable (has no vertex 2-colouring without a monochromatic edge). Prove there exist $\delta>0$ and $c>0$ such that $m(n)\ge c\,n^{1/2+\delta}\,2^n$ for all $n\ge1$.
Formalization notes: A hypergraph is a finite set `E` of finite subsets of a finite vertex
set `Fin N` (no repeated edges; repeated edges never help a minimal non-2-colourable
hypergraph, and any finite vertex set can be relabelled as `Fin N`). `NotTwoColorable E`
says every colouring `c : Fin N → Bool` makes some edge monochromatic. Rather than define
`m n` as an `sInf` (with a junk value for empty sets), the Claim states the lower bound
directly for every n-uniform non-2-colourable hypergraph, which is equivalent to
`m n ≥ c n^{1/2+δ} 2^n` (for n ≥ 1 such hypergraphs exist, e.g. all n-subsets of a
(2n−1)-set, so `m n` is a genuine minimum). `n^{1/2+δ}` is the real power `Real.rpow`.
Proving Claim = the polynomial improvement over Radhakrishnan–Srinivasan; ¬Claim = for
every δ, c > 0 some n ≥ 1 has m(n) < c n^{1/2+δ} 2^n (equivalently, since m(n) > 0,
m(n) = O(n^{1/2+δ} 2^n) fails to be beaten: liminf m(n)/(n^{1/2+δ}2^n) = 0 for all δ > 0).
-/
namespace OpenProblems.QEDE135
noncomputable section

/-- Every red/blue colouring of the vertices leaves some edge monochromatic. -/
def NotTwoColorable {N : ℕ} (E : Finset (Finset (Fin N))) : Prop :=
  ∀ c : Fin N → Bool, ∃ e ∈ E, ∃ b : Bool, ∀ v ∈ e, c v = b

def Claim : Prop :=
  ∃ δ : ℝ, 0 < δ ∧ ∃ C : ℝ, 0 < C ∧
    ∀ n : ℕ, 1 ≤ n → ∀ N : ℕ, ∀ E : Finset (Finset (Fin N)),
      (∀ e ∈ E, e.card = n) → NotTwoColorable E →
        C * (n : ℝ) ^ ((1 : ℝ) / 2 + δ) * (2 : ℝ) ^ n ≤ (E.card : ℝ)

end
end OpenProblems.QEDE135
