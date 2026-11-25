import Mathlib
/-! N-677: Periodic optimal colourings of Cayley graphs of Z^2
Join two points of ℤ² when their difference lies in a fixed finite set D. If this graph can be
properly coloured with k colours, can it always be properly coloured with k colours in a doubly
periodic pattern?
Informal statement: For finite symmetric D ⊂ ℤ² \ {0} let G_D = Cay(ℤ², D) with χ(G_D) = k.
Must G_D have a proper k-colouring invariant under a finite-index subgroup of ℤ²?
(Equivalently, does the k-colouring subshift X_{D,k} always contain a periodic point?)
Formalization notes:
* A proper k-colouring is `c : ℤ × ℤ → Fin k` with `c (v + d) ≠ c v` for all v and d ∈ D.
* Invariance under a finite-index subgroup Λ ≤ ℤ² is equivalent to invariance under N·ℤ² for
  some N ≥ 1 (every finite-index subgroup contains N·ℤ², N = index), which is what
  `IsPeriodicColouring` states.
* The claim is stated for every k admitting a proper k-colouring rather than only k = χ(G_D);
  this is equivalent: k = χ is a special case, and a periodic χ-colouring is a periodic
  k-colouring for every k ≥ χ. (χ(G_D) is always finite for finite D.)
* Proving `Claim`: every such colouring problem on ℤ² that is solvable has a periodic solution.
  Proving `¬Claim`: some D, k admit proper k-colourings but no periodic one.
* Only the ℤ² question is formalized (the ℤ^d, d ≥ 3, version is a follow-up).
-/
namespace OpenProblems.N677

/-- `c` is a proper colouring of `Cay(ℤ², D)` with `k` colours. -/
def IsProperColouring (D : Finset (ℤ × ℤ)) (k : ℕ) (c : ℤ × ℤ → Fin k) : Prop :=
  ∀ v : ℤ × ℤ, ∀ d : ℤ × ℤ, d ∈ D → c (v + d) ≠ c v

/-- `c` is invariant under translation by `N·ℤ²` for some `N ≥ 1`. -/
def IsPeriodicColouring {k : ℕ} (c : ℤ × ℤ → Fin k) : Prop :=
  ∃ N : ℕ, 0 < N ∧ ∀ v : ℤ × ℤ,
    c (v + ((N : ℤ), (0 : ℤ))) = c v ∧ c (v + ((0 : ℤ), (N : ℤ))) = c v

def Claim : Prop :=
  ∀ D : Finset (ℤ × ℤ), (0 : ℤ × ℤ) ∉ D → (∀ d : ℤ × ℤ, d ∈ D → -d ∈ D) →
    ∀ k : ℕ, (∃ c : ℤ × ℤ → Fin k, IsProperColouring D k c) →
      ∃ c : ℤ × ℤ → Fin k, IsProperColouring D k c ∧ IsPeriodicColouring c

end OpenProblems.N677
