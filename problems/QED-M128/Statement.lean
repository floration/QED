import Mathlib
/-! QED-M128: Monochromatic rectangles in low-rank Boolean matrices: beating 2^{-sqrt r}
Take any m-by-n matrix of 0s and 1s whose real rank is r. It is known that it always contains an all-0 or all-1 submatrix (some rows times some columns) covering at least a 2^{-O(sqrt r)} fraction of the entries. Can sqrt r be replaced by r^c for some c < 1/2? By a standard reduction this is the same as a communication protocol of cost O(r^c), beating the current sqrt(rank) bound on the way to the log-rank conjecture.
Informal statement: Do there exist constants $c<1/2$ and $C>0$ such that for all $m,n\ge1$ and every $M\in\{0,1\}^{m\times n}$ with $r=\operatorname{rank}_{\mathbb R}(M)\ge1$ there are $A\subseteq[m]$, $B\subseteq[n]$, $b\in\{0,1\}$ with $M_{ij}=b$ for all $(i,j)\in A\times B$ and $|A||B|\ge mn\,2^{-Cr^{c}}$? (By the Nisan--Wigderson/Lovett recursion this is equivalent, up to constants, to $D(M)=O(\operatorname{rank}(M)^{c})$ for all Boolean $M$.)
Formalization notes:
* Boolean matrices are `Matrix (Fin m) (Fin n) ℝ` with all entries 0 or 1; rank is Mathlib's
  `Matrix.rank` over ℝ. The hypothesis `1 ≤ rank` forces m, n ≥ 1 and excludes the zero matrix.
* A monochromatic rectangle is `A : Finset (Fin m)`, `B : Finset (Fin n)` and a value `b` with
  `M i j = b` on `A × B`; `b : ℝ` is unrestricted, but on a nonempty rectangle it is an entry,
  hence 0 or 1, and the size bound `|A||B| ≥ mn·2^{-C r^c} > 0` forces nonemptiness.
* `2^{-C r^c}` uses real powers (`Real.rpow`); r ≥ 1 so `r^c` is the usual power.
* Claim: ∃ c < 1/2, ∃ C > 0 with the rectangle bound for all m, n, M. (A witness c ≤ 0 would be
  even stronger, since r^c is increasing in c for r ≥ 1.) The communication-protocol form
  mentioned in parentheses is not formalized; it is equivalent by the standard recursion.
  Proving Claim = the first polynomial improvement over Sudakov–Tomon's 2^{-O(√r)};
  ¬Claim = for every c < 1/2 and C > 0 some Boolean matrix has all monochromatic rectangles of
  density < 2^{-C r^c} (which would refute the log-rank conjecture).
-/
namespace OpenProblems.QEDM128
noncomputable section

def Claim : Prop :=
  ∃ c : ℝ, c < 1 / 2 ∧ ∃ C : ℝ, 0 < C ∧
    ∀ m n : ℕ, ∀ M : Matrix (Fin m) (Fin n) ℝ,
      (∀ i : Fin m, ∀ j : Fin n, M i j = 0 ∨ M i j = 1) → 1 ≤ M.rank →
        ∃ (A : Finset (Fin m)) (B : Finset (Fin n)) (b : ℝ),
          (∀ i ∈ A, ∀ j ∈ B, M i j = b) ∧
          (m : ℝ) * (n : ℝ) * (2 : ℝ) ^ (-(C * (M.rank : ℝ) ^ c)) ≤
            (A.card : ℝ) * (B.card : ℝ)

end
end OpenProblems.QEDM128
