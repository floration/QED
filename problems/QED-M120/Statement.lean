import Mathlib
/-! QED-M120: Superlinear exponent for K_t-intersecting graph families
Consider a family of graphs on the same n labelled vertices such that any two graphs in the family share a complete subgraph K_t among their common edges. Taking all graphs that contain one fixed K_t gives a fraction 2^{-t(t-1)/2} of all graphs, and this is believed to be optimal. An easy entropy argument shows the best possible fraction is at most about 2^{-2t}, so the exponent is at least linear in t. Prove that the exponent grows faster than linearly: the largest fraction is at most 2^{-f(t)} with f(t)/t tending to infinity.
Informal statement: Call $\mathcal F\subseteq 2^{E(K_n)}$ $K_t$-intersecting if for all $G,H\in\mathcal F$ the graph $G\cap H$ contains a copy of $K_t$. Let $\alpha_t=\sup_n\max\{|\mathcal F|\,2^{-\binom n2}:\mathcal F\text{ is }K_t\text{-intersecting on }[n]\}$ and $f(t)=\log_2(1/\alpha_t)$. Prove $f(t)/t\to\infty$. (Known: $f(t)\le\binom t2$; $f(3)=3,f(4)=6,f(5)=10$; Shearer's lemma over a uniformly random partition of $[n]$ into $m$ parts gives $f(t)\ge m\,f(\lceil t/m\rceil)$, hence $f(t)\ge 10\lfloor t/5\rfloor$ and $\lim f(t)/t=\sup_s f(s)/s$. So the claim is equivalent to: for every $C$ there is $s$ with $\alpha_s\le 2^{-Cs}$. Conjectured: $f(t)=\binom t2$.)
Formalization notes:
* Labelled graphs on [n] = Fin n are encoded as edge sets G ⊆ `pairs n`, where `pairs n` is the set of ordered pairs
  (i, j) with i < j (one representative per unordered pair; |pairs n| = C(n,2)). So graphs on [n] correspond
  bijectively to subsets of `pairs n`, and there are 2^{C(n,2)} of them.
* `KtIntersecting t F`: for all G, H ∈ F (G = H allowed, as in the definition), there is a t-element vertex set s all
  of whose pairs i < j in s are edges of both G and H, i.e. G ∩ H contains a copy of K_t (s.card = t forces t
  distinct vertices).
* `frac n t` = (max |F| over K_t-intersecting families of graphs on [n]) / 2^{C(n,2)} ∈ [0, 1]. `alpha t` = sup over n
  (a real `iSup` of a sequence bounded by 1, hence a genuine supremum). alpha t > 0, witnessed by n = t and
  F = {complete graph}, so f(t) = log₂(1/alpha t) is a genuine real number.
* `Claim`: f(t)/t → ∞ as t → ∞ (t cast to ℝ). Proving ¬Claim = f(t)/t is bounded along a subsequence (by the
  known super-additivity, f(t)/t then converges to a finite limit).
-/
namespace OpenProblems.QEDM120
noncomputable section
open scoped Classical

/-- Potential edges of a graph on Fin n, as pairs (i, j) with i < j. -/
def pairs (n : ℕ) : Finset (Fin n × Fin n) :=
  (Finset.univ : Finset (Fin n × Fin n)).filter (fun p : Fin n × Fin n => p.1 < p.2)

/-- Every two members (not necessarily distinct) share a copy of K_t in their common edges. -/
def KtIntersecting {n : ℕ} (t : ℕ) (F : Finset (Finset (Fin n × Fin n))) : Prop :=
  ∀ G ∈ F, ∀ H ∈ F, ∃ s : Finset (Fin n), s.card = t ∧
    ∀ i ∈ s, ∀ j ∈ s, i < j → (i, j) ∈ G ∧ (i, j) ∈ H

/-- A family of graphs on Fin n: all members are edge sets inside `pairs n`. -/
def IsGraphFamily {n : ℕ} (F : Finset (Finset (Fin n × Fin n))) : Prop :=
  ∀ G ∈ F, G ⊆ pairs n

/-- Largest fraction of all labelled graphs on [n] forming a K_t-intersecting family. -/
def frac (n t : ℕ) : ℝ :=
  ((((Finset.univ : Finset (Finset (Finset (Fin n × Fin n)))).filter
      (fun F : Finset (Finset (Fin n × Fin n)) => IsGraphFamily F ∧ KtIntersecting t F)).sup
      Finset.card : ℕ) : ℝ) / (2 : ℝ) ^ (Nat.choose n 2)

/-- α_t = sup_n frac n t. -/
def alpha (t : ℕ) : ℝ := ⨆ n : ℕ, frac n t

/-- f(t) = log₂(1/α_t). -/
def f (t : ℕ) : ℝ := Real.logb 2 (1 / alpha t)

def Claim : Prop :=
  Filter.Tendsto (fun t : ℕ => f t / (t : ℝ)) Filter.atTop Filter.atTop

end
end OpenProblems.QEDM120
