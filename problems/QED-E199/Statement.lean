import Mathlib
/-! QED-E199: Are VT codes optimal single-deletion-correcting codes for every length?
A set of binary strings of length n corrects one deletion if no two of its strings can become the same string when each loses one symbol. The Varshamov-Tenengolts code VT_0(n), the strings whose position-weighted sum of 1s is divisible by n+1, is such a code, with about 2^n/(n+1) words. Is VT_0(n) a largest single-deletion-correcting code for every length n?
Informal statement: Let $D(n)=\max\{|C|: C\subseteq\{0,1\}^n,\ \mathcal D_1(x)\cap\mathcal D_1(y)=\emptyset\ \forall x\ne y\in C\}$, where $\mathcal D_1(x)$ is the set of length-$(n-1)$ subsequences of $x$. Let $VT_0(n)=\{x\in\{0,1\}^n:\sum_{i=1}^n i x_i\equiv0\pmod{n+1}\}$, so $|VT_0(n)|=\frac{1}{2(n+1)}\sum_{d\mid n+1,\ d\text{ odd}}\varphi(d)\,2^{(n+1)/d}$. Decide whether $D(n)=|VT_0(n)|$ for all $n\ge1$.
Formalization notes: Binary words of length n are `x : Fin n → Bool` (true = 1). The deletion ball
D₁(x) is the finset of lists obtained from `List.ofFn x` by erasing one position
(`List.eraseIdx`), i.e. all length-(n-1) subsequences. A code C is single-deletion-correcting
when distinct codewords have disjoint deletion balls. VT₀(n) is the set of words with
∑_{i=1}^n i·x_i ≡ 0 (mod n+1), positions 1-indexed (index i : Fin n has weight i.val + 1).
Claim is the "yes" answer: for every n ≥ 1, VT₀(n) is single-deletion-correcting (a classical
theorem of Levenshtein, included so that Claim literally says D(n) = |VT₀(n)|) and no
single-deletion-correcting code is larger. ¬Claim means some length n has a strictly larger
single-deletion-correcting code (since VT₀(n) is known to be one). Note D(n) here is unrestricted
(nonlinear) codes, as in the literature.
-/
namespace OpenProblems.QEDE199
noncomputable section

/-- The single-deletion ball: all words obtained from `x` by deleting exactly one symbol. -/
def del1 (n : ℕ) (x : Fin n → Bool) : Finset (List Bool) :=
  (Finset.univ : Finset (Fin n)).image fun i : Fin n => (List.ofFn x).eraseIdx i.val

/-- `C` corrects a single deletion. -/
def SingleDeletionCorrecting (n : ℕ) (C : Finset (Fin n → Bool)) : Prop :=
  ∀ x ∈ C, ∀ y ∈ C, x ≠ y → Disjoint (del1 n x) (del1 n y)

/-- The Varshamov–Tenengolts code VT₀(n): ∑ i·xᵢ ≡ 0 (mod n+1), positions 1..n. -/
def VT0 (n : ℕ) : Finset (Fin n → Bool) :=
  Finset.univ.filter fun x : Fin n → Bool =>
    (∑ i : Fin n, if x i then i.val + 1 else 0) % (n + 1) = 0

def Claim : Prop :=
  ∀ n : ℕ, 1 ≤ n →
    SingleDeletionCorrecting n (VT0 n) ∧
      ∀ C : Finset (Fin n → Bool), SingleDeletionCorrecting n C → C.card ≤ (VT0 n).card

end
end OpenProblems.QEDE199
