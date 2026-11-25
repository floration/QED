import Mathlib
/-! QED-M138: Diameter of the three-pile shuffle group
Cut a deck of 3n cards into three equal piles and interleave them, choosing any of the 6 orders of the piles at each step. When n is not a power of 3 these moves can produce every (even) arrangement. How many shuffles are needed, in the worst case, to reach every reachable arrangement? Is it of order n log n, as counting suggests, or polynomially larger?
Informal statement: For $\sigma\in S_3$ let $g_\sigma\in S_{3n}$ map position $kn+j$ ($k\in\{0,1,2\}$, $0\le j<n$) to $3j+\sigma(k)$, and let $G_{3,3n}=\langle g_\sigma:\sigma\in S_3\rangle$. For $n$ not a power of $3$ (where $G_{3,3n}\supseteq A_{3n}$), let $D(n)$ be the diameter of the (undirected) Cayley graph $\mathrm{Cay}(G_{3,3n},\{g_\sigma^{\pm1}\})$. Counting gives $D(n)=\Omega(n\log n)$. Determine whether $D(n)=O(n\log n)$; failing that, determine the growth exponent $\lim\log D(n)/\log n$ (in particular, prove $D(n)\le n^{C}$ for an absolute $C$).
Formalization notes:
* Positions are natural numbers; `shuf n σ` is gσ on `[0, 3n)` (position `i = k n + j` with `k = i / n`,
  `j = i % n` goes to `3 j + σ(k)`) and the identity outside, so no `Equiv` proof obligations are needed.
  `shufInv n σ` is its explicit inverse on `[0, 3n)` (`m = 3 j + r ↦ σ⁻¹(r) n + j`). The `Fin 3` casts are exact
  because `i / n < 3` and `m % 3 < 3` for `i, m < 3n`.
* A letter is `(b, σ)`: `b = false` means gσ, `b = true` means gσ⁻¹. `evalWord n w` is the product of the letters
  (as functions). Since the gσ are bijections of a finite set, the group they generate is exactly the set of
  values of words; two group elements are equal iff they agree on `[0, 3n)`.
* `Within n d` says every element of G_{3,3n} is a product of at most `d` letters, i.e. the undirected Cayley graph
  diameter is ≤ d (Cayley graphs are vertex-transitive, so the diameter is the max distance from the identity).
  Judgement call: the Cayley graph is taken undirected (generators and inverses), the standard convention in
  Babai-type diameter questions; the directed diameter is at least as large and the counting lower bound
  Ω(n log n) holds for both.
* `Claim` = the O(n log n) alternative: ∃ C, ∀ n ≥ 2 not a power of 3, D(n) ≤ C · n · ⌊log₂ n⌋.
  (For n ≥ 2, ⌊log₂ n⌋ ≥ 1, so this is exactly D(n) = O(n log n) on that set.) `¬Claim` = D(n)/(n log n) is
  unbounded. The fallback polynomial bound is recorded as `PolyDiameter` but is not part of `Claim`.
-/
namespace OpenProblems.QEDM138
noncomputable section

/-- The shuffle `g_σ` on positions `0, …, 3n-1` (identity on larger positions). -/
def shuf (n : ℕ) (σ : Equiv.Perm (Fin 3)) (i : ℕ) : ℕ :=
  if i < 3 * n then 3 * (i % n) + ((σ (⟨(i / n) % 3, Nat.mod_lt _ (by norm_num)⟩ : Fin 3) : Fin 3) : ℕ) else i

/-- The inverse shuffle `g_σ⁻¹` on positions `0, …, 3n-1` (identity on larger positions). -/
def shufInv (n : ℕ) (σ : Equiv.Perm (Fin 3)) (m : ℕ) : ℕ :=
  if m < 3 * n then n * ((σ.symm (⟨m % 3, Nat.mod_lt _ (by norm_num)⟩ : Fin 3) : Fin 3) : ℕ) + m / 3 else m

/-- A letter: a generator `g_σ` (`false`) or its inverse (`true`). -/
abbrev Letter : Type := Bool × Equiv.Perm (Fin 3)

/-- The permutation (as a function) represented by a letter. -/
def letterFun (n : ℕ) (a : Letter) : ℕ → ℕ :=
  cond a.1 (shufInv n a.2) (shuf n a.2)

/-- The product of a word of letters. -/
def evalWord (n : ℕ) : List Letter → ℕ → ℕ
  | [] => id
  | a :: w => letterFun n a ∘ evalWord n w

/-- Every element of `G_{3,3n}` has word length at most `d`, i.e. `D(n) ≤ d`. -/
def Within (n d : ℕ) : Prop :=
  ∀ w : List Letter, ∃ w' : List Letter, w'.length ≤ d ∧
    ∀ i : ℕ, i < 3 * n → evalWord n w' i = evalWord n w i

/-- Fallback target (not the Claim): polynomial diameter. -/
def PolyDiameter : Prop :=
  ∃ C : ℕ, ∀ n : ℕ, 2 ≤ n → (¬ ∃ k : ℕ, n = 3 ^ k) → Within n (n ^ C)

/-- `D(n) = O(n log n)` for `n` not a power of `3`. -/
def Claim : Prop :=
  ∃ C : ℕ, ∀ n : ℕ, 2 ≤ n → (¬ ∃ k : ℕ, n = 3 ^ k) → Within n (C * n * Nat.log 2 n)

end
end OpenProblems.QEDM138
