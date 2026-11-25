import Mathlib
/-! QED-E031: An effective bound for the sum-free excess
Every set of N nonzero integers contains a sum-free subset (no x+y=z inside it) of size a bit more than N/3; Bedert (2025) showed the excess grows at least like log log N. It is also known that you cannot always beat N/3 by more than o(N), but that proof gives no rate. Prove a quantitative version: some N-element sets have no sum-free subset larger than N/3 + N/(log N)^c.
Informal statement: Let $S(N)=\min_{A\subset\mathbb Z\setminus\{0\},\,|A|=N}\max\{|B|:B\subseteq A\text{ sum-free}\}$. Known: $N/3+c\log\log N\le S(N)\le N/3+o(N)$, with the $o(N)$ ineffective. Prove that there is $c>0$ with $S(N)\le N/3+O\big(N/(\log N)^{c}\big)$. Any explicitly quantified $o(N)$ (e.g. $N/(\log\log N)^{c}$) would be partial progress.
Formalization notes: SumFree B: x+y ∉ B for all x,y in B (x=y allowed, the standard convention). Claim: there are c>0, C and N₀ such that for every N >= N₀ some N-element set A of nonzero integers has every sum-free subset of size <= N/3 + C·N/(log N)^c. Junk values: for N <= 1, log N <= 0 and the division misbehaves, but N₀ is chosen by the prover and the statement is only about large N; a negative C cannot help because Erdos's N/3 lower bound would be violated. ¬Claim means no (log N)^{-c} rate holds. Weaker explicit rates are not captured.
-/
namespace OpenProblems.QEDE031
def SumFree (B : Finset ℤ) : Prop :=
  ∀ x ∈ B, ∀ y ∈ B, x + y ∉ B

def Claim : Prop :=
  ∃ c : ℝ, 0 < c ∧ ∃ C : ℝ, ∃ N₀ : ℕ, ∀ N : ℕ, N₀ ≤ N →
    ∃ A : Finset ℤ, (0 : ℤ) ∉ A ∧ A.card = N ∧
      ∀ B ⊆ A, SumFree B → (B.card : ℝ) ≤ (N : ℝ) / 3 + C * (N : ℝ) / (Real.log N) ^ c
end OpenProblems.QEDE031
