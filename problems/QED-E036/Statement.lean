import Mathlib
/-! QED-E036: Integer complexity of powers of two
Is (1+1)(1+1)...(1+1), with 2k ones, always the shortest way to write 2^k using only 1, + and ×?
Informal statement: Let $\|n\|$ be the least number of 1's in an expression for $n$ built from $1$, $+$, $\times$. Prove or disprove: $\|2^k\|=2k$ for all $k\ge1$.
Formalization notes: Expressions are binary trees with leaves `one` and nodes `add`/`mul`; `ones` counts leaves. Since (1+1)^k uses exactly 2k ones, ‖2^k‖ = 2k is equivalent to: every expression evaluating to 2^k has at least 2k ones. Claim = the conjecture holds for all k ≥ 1; ¬Claim = some 2^k has an expression with fewer than 2k ones. (The stronger 2^k 3^l form is not encoded.)
-/
namespace OpenProblems.QEDE036

inductive Expr : Type
  | one : Expr
  | add : Expr → Expr → Expr
  | mul : Expr → Expr → Expr

def Expr.eval : Expr → ℕ
  | Expr.one => 1
  | Expr.add a b => a.eval + b.eval
  | Expr.mul a b => a.eval * b.eval

def Expr.ones : Expr → ℕ
  | Expr.one => 1
  | Expr.add a b => a.ones + b.ones
  | Expr.mul a b => a.ones + b.ones

def Claim : Prop :=
  ∀ k : ℕ, 1 ≤ k → ∀ e : Expr, e.eval = 2 ^ k → 2 * k ≤ e.ones

end OpenProblems.QEDE036
