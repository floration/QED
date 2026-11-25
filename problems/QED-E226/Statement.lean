import Mathlib
/-! QED-E226: Prime Nim losing positions are not automatic
In Prime Nim you remove a prime number of stones; the player who cannot move loses. Show that no finite automaton reading pile sizes in any base can recognise the losing positions.
Informal statement: Let $L\subseteq\mathbb N$ be defined recursively by $n\in L\iff n-p\notin L$ for every prime $p\le n$ (the P-positions of the subtraction game with subtraction set the primes; $L=\{0,1,9,10,25,34,35,49,\dots\}$, OEIS A025043). Prove that for no integer $k\ge2$ is the characteristic sequence of $L$ $k$-automatic.
Formalization notes:
* `IsPrimeNimP L` is the defining recursion of the P-positions of the subtraction game whose
  moves are `n ↦ n - p`, `p` prime, `p ≤ n`. Every move decreases `n`, so exactly one set satisfies
  it (strong induction); `0, 1 ∈ L` since no prime is `≤ 1`.
* `k`-automaticity is expressed by Eilenberg's theorem: a sequence `χ : ℕ → X` is `k`-automatic
  iff its `k`-kernel `{ n ↦ χ(k^e n + r) : e ≥ 0, 0 ≤ r < k^e }` is finite (Allouche–Shallit,
  Automatic Sequences, Thm 6.6.2). This characterisation is independent of whether the automaton
  reads digits most- or least-significant first and of leading zeros. Here `χ n = (n ∈ L)`, so the
  kernel is a set of functions `ℕ → Prop`.
* `Claim`: a set satisfying the recursion exists (true; included so the universal part is not
  vacuous), and for every such set and every `k ≥ 2` the `k`-kernel is infinite. Proving `¬Claim`
  amounts to showing that the characteristic sequence of `L` is `k`-automatic for some `k ≥ 2`.
-/
namespace OpenProblems.QEDE226
noncomputable section

/-- The defining recursion of the P-positions of Prime Nim (subtraction set = primes). -/
def IsPrimeNimP (L : Set ℕ) : Prop :=
  ∀ n : ℕ, n ∈ L ↔ ∀ p : ℕ, p.Prime → p ≤ n → n - p ∉ L

/-- The `k`-kernel of the characteristic sequence of `L`. -/
def kernel (k : ℕ) (L : Set ℕ) : Set (ℕ → Prop) :=
  {f : ℕ → Prop | ∃ e r : ℕ, r < k ^ e ∧ f = fun n : ℕ => (k ^ e * n + r) ∈ L}

/-- The characteristic sequence of `L` is `k`-automatic (Eilenberg's kernel criterion). -/
def IsAutomatic (k : ℕ) (L : Set ℕ) : Prop := (kernel k L).Finite

def Claim : Prop :=
  (∃ L : Set ℕ, IsPrimeNimP L) ∧
    ∀ L : Set ℕ, IsPrimeNimP L → ∀ k : ℕ, 2 ≤ k → ¬ IsAutomatic k L

end
end OpenProblems.QEDE226
