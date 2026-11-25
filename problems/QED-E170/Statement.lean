import Mathlib
/-! QED-E170: Are lower Bruhat intervals in S_n rank-unimodal?
In the Bruhat order on permutations, u <= w roughly means that u can be obtained from w by undoing inversions. For a permutation w, count the permutations below it with exactly k inversions, for k = 0, 1, ..., inv(w). Does this sequence always rise and then fall? Bjorner and Ekedahl proved that the first half never decreases, but the full statement is open.
Informal statement: For $w\in S_n$ let $f_k(w)=\#\{u\in S_n:\ u\le w\text{ in Bruhat order},\ \mathrm{inv}(u)=k\}$, where $u\le w$ iff $\#\{a\le i:u(a)\ge j\}\le\#\{a\le i:w(a)\ge j\}$ for all $i,j\in[n]$. Claim: for every $n$ and every $w\in S_n$ there is $m$ with $f_0(w)\le\dots\le f_m(w)\ge f_{m+1}(w)\ge\dots\ge f_{\mathrm{inv}(w)}(w)$.
Formalization notes:
* Permutations of [n] are `Equiv.Perm (Fin n)` (0-indexed; the criterion is unchanged by the shift).
* `bruhatLE u w` is the standard rank-matrix (tableau) criterion for Bruhat order on S_n (Björner–Brenti, Combinatorics of Coxeter Groups, Thm 2.1.5): u ≤ w iff u[i,j] ≤ w[i,j] for all i, j, where w[i,j] = #{a ≤ i : w(a) ≥ j}. The identity is the minimum, as it should be.
* `invCount w` = number of pairs a < b with w(b) < w(a) = Coxeter length.
* `f w k` = number of u ≤ w with invCount u = k (defined for every k : ℕ; it is 0 for k > inv w and f w (inv w) = 1).
* `Claim`: for all n and w there is m with f nondecreasing on [0, m] and nonincreasing on [m, ∞). Because f w (inv w) = 1 > 0 = f w (inv w + 1), any such m satisfies m ≤ inv w, and the tail beyond inv w is identically 0, so this is exactly unimodality of (f_0, …, f_{inv w}). `¬Claim` = an explicit w ∈ S_n whose lower interval is not rank-unimodal (a finite check).
-/
namespace OpenProblems.QEDE170
noncomputable section
open Classical

/-- Bruhat order on `S_n` via the rank-matrix criterion. -/
def bruhatLE {n : ℕ} (u w : Equiv.Perm (Fin n)) : Prop :=
  ∀ i j : Fin n,
    (Finset.univ.filter (fun a : Fin n => a ≤ i ∧ j ≤ u a)).card ≤
      (Finset.univ.filter (fun a : Fin n => a ≤ i ∧ j ≤ w a)).card

/-- Number of inversions (Coxeter length). -/
def invCount {n : ℕ} (w : Equiv.Perm (Fin n)) : ℕ :=
  (Finset.univ.filter (fun p : Fin n × Fin n => p.1 < p.2 ∧ w p.2 < w p.1)).card

/-- Number of elements of rank `k` in the lower Bruhat interval `[e, w]`. -/
def f {n : ℕ} (w : Equiv.Perm (Fin n)) (k : ℕ) : ℕ :=
  (Finset.univ.filter (fun u : Equiv.Perm (Fin n) => bruhatLE u w ∧ invCount u = k)).card

/-- Every lower Bruhat interval in every symmetric group is rank-unimodal. -/
def Claim : Prop :=
  ∀ n : ℕ, ∀ w : Equiv.Perm (Fin n), ∃ m : ℕ,
    (∀ k : ℕ, k < m → f w k ≤ f w (k + 1)) ∧ (∀ k : ℕ, m ≤ k → f w (k + 1) ≤ f w k)

end
end OpenProblems.QEDE170
