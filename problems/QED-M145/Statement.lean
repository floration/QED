import Mathlib
/-! QED-M145: Primes with equal binary and ternary digit sums
Show that there are infinitely many primes whose binary digit sum equals their ternary digit sum.
Informal statement: Let $s_q(n)$ be the sum of the base-$q$ digits of $n$. Prove that there are infinitely many primes $p$ with $s_2(p)=s_3(p)$. (Stronger target, not formalized here: $\#\{p\le N:s_2(p)=s_3(p)\}\ge N^{c}$ for some $c>0$.)
Formalization notes:
* `Nat.digits q n` is the list of base-`q` digits of `n` (least significant first), so
  `(Nat.digits q n).sum = s_q(n)`.
* `Claim` is the main statement (infinitely many such primes). Proving `¬Claim` means only finitely
  many primes have equal binary and ternary digit sums. The stronger counting target is a remark.
-/
namespace OpenProblems.QEDM145
noncomputable section

/-- Sum of the base-`q` digits of `n`. -/
def digitSum (q n : ℕ) : ℕ := (Nat.digits q n).sum

def Claim : Prop :=
  {p : ℕ | p.Prime ∧ digitSum 2 p = digitSum 3 p}.Infinite

end
end OpenProblems.QEDM145
