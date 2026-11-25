import Mathlib
/-! QED-M134: Binary codes near distance 1/2: remove the logarithm
Let A(n,d) be the largest number of binary strings of length n that pairwise differ in at least d positions. When d=(1/2-eps)n, random codes give about 2^{(2/ln 2) eps^2 n} strings, but the best upper bounds (the 1977 linear-programming bound and its 2026 refinements) give only 2^{O(eps^2 log(1/eps)) n}. Show that the logarithm is not needed: the rate is at most a constant times eps^2.
Informal statement: Let $A_2(n,d)=\max\{|C|:C\subseteq\{0,1\}^n,\ d_H(x,y)\ge d\ \forall x\ne y\in C\}$. Prove that there is an absolute constant $K$ such that for every $\varepsilon\in(0,1/4]$, $\limsup_{n\to\infty}\frac1n\log_2A_2\!\left(n,\lceil(\tfrac12-\varepsilon)n\rceil\right)\le K\varepsilon^2$.
Formalization notes: Words are `Fin n → Bool`, distance is Mathlib's `hammingDist`. `A2 n d` is the maximum
cardinality over all codes (finsets of words) whose distinct elements are at Hamming distance ≥ d, computed as
the `sup` of `card` over the finite filtered family (the empty code is always admissible, so this is a genuine
maximum; A2 n d ≥ 1). The limsup inequality limsup (1/n) log₂ A2 ≤ Kε² is stated in the equivalent
limsup-free form: for every η > 0, eventually A2 n ⌈(1/2-ε)n⌉ ≤ 2^{(Kε²+η)n} (real power). K is quantified
before ε (absolute constant). Non-vacuity: Gilbert–Varshamov forces K ≥ 2/ln 2, and MRRW-type bounds give only
O(ε² log(1/ε)), so the claim is not implied by known bounds and a large K does not trivialize it (it must hold
uniformly as ε → 0). Claim true removes the log factor; ¬Claim says that for every K some ε ∈ (0,1/4] has
limsup rate > Kε².
-/
namespace OpenProblems.QEDM134
noncomputable section

/-- Maximum size of a binary code of length `n` with minimum Hamming distance at least `d`. -/
def A2 (n d : ℕ) : ℕ :=
  ((Finset.univ : Finset (Finset (Fin n → Bool))).filter
      (fun C => ∀ x ∈ C, ∀ y ∈ C, x ≠ y → d ≤ hammingDist x y)).sup Finset.card

def Claim : Prop :=
  ∃ K : ℝ, ∀ ε : ℝ, 0 < ε → ε ≤ 1 / 4 → ∀ η : ℝ, 0 < η →
    ∀ᶠ n : ℕ in Filter.atTop,
      (A2 n ⌈(1 / 2 - ε) * (n : ℝ)⌉₊ : ℝ) ≤ (2 : ℝ) ^ ((K * ε ^ 2 + η) * (n : ℝ))

end
end OpenProblems.QEDM134
