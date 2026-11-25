import Mathlib
/-! QED-E201: 3-query locally decodable codes: beat the cubic lower bound
A 3-query locally decodable code encodes k bits into n bits so that any single message bit can be recovered with probability 1/2+eps by reading just 3 randomly chosen positions, even after a delta fraction of the codeword has been corrupted. The shortest known such codes have length exp(exp(O(sqrt(log k loglog k)))), while the best lower bound (2023) is n >= k^3/polylog(k). Prove n >= k^{3+c} for some fixed c>0.
Informal statement: A map $E:\{0,1\}^k\to\{0,1\}^n$ is a $(3,\delta,\varepsilon)$-LDC if for each $i\in[k]$ there is a probability distribution $\mu_i$ on pairs $(S,f)$ with $S\in[n]^3$ and $f:\{0,1\}^3\to\{0,1\}$ such that for all $x\in\{0,1\}^k$ and all $y\in\{0,1\}^n$ with $d_H(y,E(x))\le\delta n$: $\Pr_{(S,f)\sim\mu_i}[f(y_S)=x_i]\ge\tfrac12+\varepsilon$. Prove: for all fixed $\delta,\varepsilon\in(0,1/2)$ there exist $c=c(\delta,\varepsilon)>0$ and $K$ such that every $(3,\delta,\varepsilon)$-LDC with $k\ge K$ has $n\ge k^{3+c}$. (Strengthening: $c$ independent of $\delta,\varepsilon$.)
Formalization notes:
* Bits are `Bool`; messages `Fin k → Bool`, codewords `Fin n → Bool`; Hamming distance is
  Mathlib's `hammingDist` (number of differing coordinates).
* A decoder for bit i is a probability distribution μ i on the finite set of queries
  (Fin 3 → Fin n) × ((Fin 3 → Bool) → Bool): a query tuple S (repetitions allowed, so this
  covers ≤ 3 queries) and a decision function f. Its success probability on y is
  Σ_q μ i q · [q.2 (y ∘ q.1) = x i]. This is the standard non-adaptive LDC definition used by
  Katz–Trevisan and Alrabiah–Guruswami–Kothari–Manohar (adaptive 3-query decoders are not
  covered by this definition, as in the informal statement).
* `IsLDC3 k n δ ε E` requires the existence of such μ for every i, with success ≥ 1/2 + ε for all
  x and all y with d_H(y, E x) ≤ δ n.
* Quantifiers follow the informal statement: ∀ δ ε ∈ (0,1/2), ∃ c > 0, ∃ K, ∀ k ≥ K, ∀ n, every
  (3,δ,ε)-LDC E : {0,1}^k → {0,1}^n has n ≥ k^{3+c} (real power). There is no junk at n = 0:
  then y is unique and the decoder cannot output both values of x_i with probability > 1/2.
* Claim = the k^{3+c} lower bound (c may depend on δ, ε). ¬Claim: for some δ, ε, for every
  c > 0 there are arbitrarily large k with a (3,δ,ε)-LDC of length n < k^{3+c}.
-/
namespace OpenProblems.QEDE201
noncomputable section

/-- `E` is a non-adaptive `(3, δ, ε)` locally decodable code. -/
def IsLDC3 (k n : ℕ) (δ ε : ℝ) (E : (Fin k → Bool) → (Fin n → Bool)) : Prop :=
  ∀ i : Fin k, ∃ μ : (Fin 3 → Fin n) × ((Fin 3 → Bool) → Bool) → ℝ,
    (∀ q, 0 ≤ μ q) ∧ (∑ q, μ q) = 1 ∧
    ∀ x : Fin k → Bool, ∀ y : Fin n → Bool, (hammingDist y (E x) : ℝ) ≤ δ * n →
      (1 : ℝ) / 2 + ε ≤ ∑ q, μ q * (if q.2 (y ∘ q.1) = x i then (1 : ℝ) else 0)

/-- 3-query LDCs have length at least `k^{3+c}`. -/
def Claim : Prop :=
  ∀ δ ε : ℝ, 0 < δ → δ < 1 / 2 → 0 < ε → ε < 1 / 2 →
    ∃ c : ℝ, 0 < c ∧ ∃ K : ℕ, ∀ k : ℕ, K ≤ k → ∀ n : ℕ,
      ∀ E : (Fin k → Bool) → (Fin n → Bool), IsLDC3 k n δ ε E →
        (k : ℝ) ^ ((3 : ℝ) + c) ≤ (n : ℝ)

end
end OpenProblems.QEDE201
