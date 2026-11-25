import Mathlib
/-! QED-E141: An odd weird number
A number is abundant if its proper divisors add up to more than the number itself, and weird if it is abundant but no selection of its distinct proper divisors adds up to exactly the number (70 is the smallest). Weird numbers have positive density, but every known one is even. Does an odd weird number exist?
Informal statement: Decide whether there exists an odd $n\in\mathbb N$ with $\sigma(n)>2n$ such that no subset $S$ of the proper divisors of $n$ satisfies $\sum_{d\in S}d=n$.
Formalization notes:
* σ(n) is `∑ d ∈ n.divisors, d`; abundance is 2n < σ(n) (equivalently the proper divisors
  sum to more than n).
* Not semiperfect: no `S ⊆ n.properDivisors` (a Finset, so a set of distinct proper divisors)
  has sum n.
* `Odd n` excludes n = 0 (where `divisors` is the junk value ∅).
* `Claim` asserts an odd weird number exists; `¬Claim` says none exists.
  Sanity check: with `Odd n` dropped, n = 70 witnesses the body.
-/
namespace OpenProblems.QEDE141
noncomputable section

/-- `n` is weird: abundant but not a sum of distinct proper divisors. -/
def Weird (n : ℕ) : Prop :=
  2 * n < ∑ d ∈ n.divisors, d ∧
    ¬ ∃ S : Finset ℕ, S ⊆ n.properDivisors ∧ ∑ d ∈ S, d = n

def Claim : Prop :=
  ∃ n : ℕ, Odd n ∧ Weird n

end
end OpenProblems.QEDE141
