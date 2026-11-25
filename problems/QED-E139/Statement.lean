import Mathlib
/-! QED-E139: Does the odd greedy algorithm always terminate?
Every fraction with an odd denominator can be written as a sum of distinct unit fractions with odd denominators. The odd greedy algorithm tries to find such a sum by repeatedly subtracting the largest unit fraction 1/n, with n odd, that still fits. Does it always stop after finitely many steps when the starting fraction has an odd denominator? In every case tested it does, sometimes only after surprisingly many steps.
Informal statement: For $x\in\mathbb Q\cap(0,1)$ with odd denominator, set $x_0=x$. While $x_k>0$, let $n_k$ be the least odd integer with $1/n_k\le x_k$ and set $x_{k+1}=x_k-1/n_k$. Prove or disprove: for every such $x$ there is a $k$ with $x_k=0$.
Formalization notes:
* `IsLeastOdd n y`: n is odd, 1/n ≤ y, and no odd m with 1/m ≤ y is smaller, i.e. n is the least odd integer with
  1/n ≤ y (the largest odd-denominator unit fraction not exceeding y). Odd n ≥ 1, so no division by zero; for y > 0
  such n exists and is unique, so each greedy step is uniquely determined.
* `Terminates x`: there are k and sequences xs, ns with xs 0 = x, and for every i < k: xs i > 0, ns i is the least odd
  integer with 1/(ns i) ≤ xs i, and xs (i+1) = xs i − 1/(ns i); and xs k = 0. Since the greedy step is
  deterministic and defined whenever the current value is positive, such a run exists iff the odd greedy algorithm
  started at x reaches 0 after k steps. (Stating it as existence of a run avoids defining the step via Nat.find,
  which would need an in-file existence proof.)
* `Claim`: every rational x in (0,1) with odd denominator (x.den is the reduced denominator) terminates. Proving
  `Claim` = the algorithm always halts; ¬Claim = some such x on which it runs forever.
-/
namespace OpenProblems.QEDE139

/-- n is the least odd natural number with 1/n ≤ y. -/
def IsLeastOdd (n : ℕ) (y : ℚ) : Prop :=
  Odd n ∧ (1 : ℚ) / (n : ℚ) ≤ y ∧ ∀ m : ℕ, Odd m → (1 : ℚ) / (m : ℚ) ≤ y → n ≤ m

/-- The odd greedy algorithm started at x reaches 0 after finitely many steps. -/
def Terminates (x : ℚ) : Prop :=
  ∃ k : ℕ, ∃ xs : ℕ → ℚ, ∃ ns : ℕ → ℕ, xs 0 = x ∧
    (∀ i : ℕ, i < k → 0 < xs i ∧ IsLeastOdd (ns i) (xs i) ∧ xs (i + 1) = xs i - 1 / (ns i : ℚ)) ∧
    xs k = 0

def Claim : Prop :=
  ∀ x : ℚ, 0 < x → x < 1 → Odd x.den → Terminates x

end OpenProblems.QEDE139
