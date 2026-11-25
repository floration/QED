import Mathlib
/-! QED-M041: Proof complexity of the sensitivity theorem
STATUS: NOT YET FORMALIZED
Encode Huang's sensitivity theorem (any set of more than half the vertices of the n-cube contains a vertex with at least √n neighbours in the set) as an unsatisfiable CNF SENS_n on N = 2^n main variables. Does it have polynomial-size (in N) refutations in resolution, cutting planes, or low-degree sum-of-squares?
Informal statement: Let $N=2^n$, $d=\lceil\sqrt n\rceil-1$. $\mathrm{SENS}_n$ is the CNF on variables $x_v$ ($v\in\{0,1\}^n$) plus sequential-counter variables encoding $\sum_v x_v\ge 2^{n-1}+1$, together with the clauses $\neg x_v\vee\bigvee_{u\in U}\neg x_u$ for every $v$ and every $(d+1)$-set $U$ of neighbours of $v$ (size $N\cdot n^{O(\sqrt n)}=N^{1+o(1)}$). It is unsatisfiable by Huang's theorem. Does $\mathrm{SENS}_n$ have refutations of size $N^{O(1)}$ in (a) resolution, (b) cutting planes, (c) sum-of-squares of degree $O(\log N)$? Lower bounds $2^{N^{\Omega(1)}}$ are equally of interest.
Formalization notes: Not formalized. Missing pieces: (1) a precise fixed encoding of the cardinality constraint by sequential-counter clauses (must be specified exactly; different encodings can change resolution complexity only polynomially, but the statement needs one); (2) definitions of resolution refutations (DAG of clauses with size), cutting-planes refutations (integer linear inequalities with addition, scaling, division-rounding rules), and degree-d sum-of-squares/Positivstellensatz refutations with their size; (3) the asymptotic family statement 'size N^{O(1)}' (∃ k, ∀ n, size ≤ N^k + k). None of this is in Mathlib; together roughly 200-400 lines. The intended Claim is three separate questions (a),(b),(c); the main content is (b) and (c). Proving a lower bound 2^{N^{Ω(1)}} would refute the corresponding part.
-/
namespace OpenProblems.QEDM041

def Claim : Prop := sorry

end OpenProblems.QEDM041
