import Mathlib
/-! QED-E198: Is the Shannon capacity of the 7-cycle below its Lovász theta?
The Shannon capacity Θ(G) of a graph measures how many messages per channel use can be sent with zero error when G records which symbols can be confused. For the 7-cycle the best lower bound is about 3.2588 (2026 computer constructions) and the only upper bound is still Lovász's 1979 theta number 7cos(π/7)/(1+cos(π/7)) ≈ 3.3177. Decide whether Θ(C_7) is strictly smaller than this theta value.
Informal statement: For a graph $G$ let $\Theta(G)=\sup_{k\ge1}\alpha(G^{\boxtimes k})^{1/k}$, $\boxtimes$ the strong product. Decide whether $\Theta(C_7)<\vartheta(C_7)=\dfrac{7\cos(\pi/7)}{1+\cos(\pi/7)}$; equivalently (since $\Theta\le\vartheta$), whether $\Theta(C_7)=\vartheta(C_7)$ fails.
Formalization notes:
* C₇ has vertex set ZMod 7, with a ~ b iff b = a + 1 or a = b + 1.
* The k-th strong power C₇^{⊠k} has vertex set (Fin k → ZMod 7); distinct x, y are adjacent
  (confusable) iff every coordinate is equal or adjacent. So S is independent in C₇^{⊠k} iff any
  two distinct words of S differ, in some coordinate, by a value that is neither equal nor
  adjacent (i.e. by ±2 or ±3 mod 7).
* Θ(C₇) = sup_{k≥1} α_k^{1/k}. We avoid the real `iSup` (and its junk value) by the equivalent
  form: Θ(C₇) < ϑ  ⇔  ∃ c < ϑ such that |S| ≤ c^k for every k ≥ 1 and every independent S in
  C₇^{⊠k} (since α_k^{1/k} ≤ c for all k iff sup ≤ c, and c^k is monotone in c ≥ 0; note c ≥ 1
  is forced by k = 1).
* ϑ(C₇) = 7cos(π/7)/(1+cos(π/7)) is written via `Real.cos` and `Real.pi`.
* Claim: Θ(C₇) < ϑ(C₇). ¬Claim: Θ(C₇) ≥ ϑ(C₇), i.e. (by Lovász's Θ ≤ ϑ) Θ(C₇) = ϑ(C₇).
-/
namespace OpenProblems.QEDE198
noncomputable section

/-- Adjacency of the 7-cycle on `ZMod 7`. -/
def c7Adj (a b : ZMod 7) : Prop := b = a + 1 ∨ a = b + 1

/-- `S` is an independent set of the strong power `C₇^{⊠k}`. -/
def IsIndepStrong (k : ℕ) (S : Finset (Fin k → ZMod 7)) : Prop :=
  ∀ x ∈ S, ∀ y ∈ S, x ≠ y → ∃ i : Fin k, x i ≠ y i ∧ ¬ c7Adj (x i) (y i)

/-- Lovász theta of `C₇`. -/
def theta7 : ℝ := 7 * Real.cos (Real.pi / 7) / (1 + Real.cos (Real.pi / 7))

/-- `Θ(C₇) < ϑ(C₇)`. -/
def Claim : Prop :=
  ∃ c : ℝ, c < theta7 ∧ ∀ k : ℕ, 1 ≤ k → ∀ S : Finset (Fin k → ZMod 7),
    IsIndepStrong k S → (S.card : ℝ) ≤ c ^ k

end
end OpenProblems.QEDE198
