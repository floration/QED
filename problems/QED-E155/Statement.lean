import Mathlib
/-! QED-E155: Is Euler's constant irrational?
Euler's constant γ ≈ 0.5772 is the limit of 1 + 1/2 + ... + 1/n − ln n. It also equals −Γ'(1), where Γ is the Gamma function. More than 280 years after Euler, nobody knows whether γ is a fraction. Prove that it is not.
Informal statement: Prove that $\gamma=\lim_{n\to\infty}\left(\sum_{k=1}^n \tfrac1k-\ln n\right)\notin\mathbb{Q}$.
Formalization notes: To be self-contained, γ is characterised as the limit of
H_n − log n, with H_n = ∑_{k=1}^n 1/k written as a sum over `Finset.range n` of
1/(k+1). The Claim says every real limit of this sequence is irrational. The limit is
known to exist (Mathlib: `Real.tendsto_harmonic_sub_log`, limit
`Real.eulerMascheroniConstant`), so the hypothesis is satisfiable and the Claim is exactly
"γ is irrational"; limits in ℝ are unique so there is no other g. ¬Claim = γ ∈ ℚ.
-/
namespace OpenProblems.QEDE155
noncomputable section

/-- H_n − log n. -/
def gammaSeq (n : ℕ) : ℝ :=
  (∑ k ∈ Finset.range n, (1 : ℝ) / ((k : ℝ) + 1)) - Real.log (n : ℝ)

def Claim : Prop :=
  ∀ g : ℝ, Filter.Tendsto gammaSeq Filter.atTop (nhds g) → Irrational g

end
end OpenProblems.QEDE155
