import Mathlib
/-! QED-E134: Turán density of the tight 5-cycle
A 3-uniform hypergraph is a collection of triples of points. The tight 5-cycle consists of five points v0,...,v4 arranged in a circle together with the five triples of cyclically consecutive points. What is the largest fraction of all triples a hypergraph on n points can contain without a tight 5-cycle, as n grows? An iterated construction achieves 2√3 − 3 ≈ 0.4641, and flag algebras give an upper bound of about 0.468. Prove that 2√3 − 3 is the answer.
Informal statement: For a 3-graph $H$ write $C_5^{(3)}\subseteq H$ if there are distinct $v_0,\dots,v_4\in V(H)$ with $\{v_i,v_{i+1},v_{i+2}\}\in E(H)$ for all $i\in\mathbb Z/5$. Let $\mathrm{ex}(n)=\max\{|E(H)|: |V(H)|=n,\ C_5^{(3)}\not\subseteq H\}$. Prove that $\pi(C_5^{(3)}):=\lim_{n\to\infty}\mathrm{ex}(n)/\binom n3 = 2\sqrt3-3$.
Formalization notes:
* A 3-graph on `Fin n` is a finset `E` of 3-element subsets of `Fin n` (every 3-graph on an
  n-vertex set is isomorphic to one of these, and ex(n) is isomorphism invariant).
* `HasTightC5 E` : there is an injective `f : Fin 5 → Fin n` with `{f i, f (i+1), f (i+2)} ∈ E`
  for every `i : Fin 5`; addition in `Fin 5` is modulo 5, so this is exactly indexing by ℤ/5.
  Injectivity makes the five vertices distinct, so each such set really has 3 elements.
* `ex n` is the maximum of `E.card` over C5-free 3-graphs on `Fin n` (a `Finset.sup` over the
  finite type of all families; the empty family is C5-free, so this is a genuine maximum).
* For n < 3 the ratio `ex n / choose n 3` is the junk value 0/0 = 0; irrelevant for the limit.
* Claim: `ex n / C(n,3) → 2√3 − 3`. The limit is known to exist (the ratio is nonincreasing for
  n ≥ 3 by averaging), so ¬Claim means π(C_5^{(3)}) ≠ 2√3 − 3 (given the known lower bound,
  π > 2√3 − 3).
-/
namespace OpenProblems.QEDE134
noncomputable section
open scoped Classical
open Filter Topology

/-- `E` contains a tight 5-cycle on five distinct vertices. -/
def HasTightC5 {n : ℕ} (E : Finset (Finset (Fin n))) : Prop :=
  ∃ f : Fin 5 → Fin n, Function.Injective f ∧
    ∀ i : Fin 5, ({f i, f (i + 1), f (i + 2)} : Finset (Fin n)) ∈ E

/-- The Turán number of the tight 5-cycle among 3-graphs on `Fin n`. -/
def ex (n : ℕ) : ℕ :=
  ((Finset.univ : Finset (Finset (Finset (Fin n)))).filter
      (fun E : Finset (Finset (Fin n)) => (∀ e ∈ E, e.card = 3) ∧ ¬ HasTightC5 E)).sup
    Finset.card

def Claim : Prop :=
  Tendsto (fun n : ℕ => ((ex n : ℕ) : ℝ) / ((Nat.choose n 3 : ℕ) : ℝ)) atTop
    (𝓝 (2 * Real.sqrt 3 - 3))

end
end OpenProblems.QEDE134
