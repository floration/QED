import Mathlib
/-! N-683: Distinct character degrees of the symmetric group
Conjugate partitions give irreducible representations of S_n of the same dimension, so at most
about half of the p(n) irreducible representations have distinct dimensions. Does the fraction
d(n)/p(n) of distinct dimensions tend to a positive limit?
Informal statement: Let d(n) = #{f^λ : λ ⊢ n} be the number of distinct irreducible character degrees of S_n and p(n) the number of partitions of n. Prove or disprove: d(n)/p(n) converges to a positive limit L as n → ∞.
Formalization notes: The original asks to determine whether lim d(n)/p(n) exists, find it, and
in particular decide whether liminf d(n)/p(n) > 0. Claim is the natural conjecture "the limit
exists and is positive". Proving ¬Claim means: either d(n)/p(n) does not converge, or it
converges to 0. Partitions of n are generated explicitly as weakly decreasing lists of positive
integers summing to n (`partitionsList n`; first part k+1 <= m, remaining parts <= k+1). The
degree f^λ is defined by the hook length formula f^λ = n! / Π_{cells} hook(cell), where the hook
of cell (i,j) is (λ_i - j - 1) + #{k > i : λ_k > j} + 1; the division is exact by the hook length
theorem, so this is the number of standard Young tableaux, i.e. the dimension of the Specht
module. d(n) counts distinct values of this list, p(n) its length (p(n) >= 1). Data: p(40) =
37338, d(40) = 16216 (checked with an independent script implementing these exact definitions);
d(n)/p(n) ∈ [0.40, 0.47] for 20 <= n <= 45; arXiv:2410.01726 suggests p(n)/d(n) may tend to
about 2.5 (a referee suggested π√(2/3)), but this is not part of Claim.
-/
namespace OpenProblems.N683

/-- `partitionsAux fuel n m`: all partitions of `n` into parts `<= m`, as weakly decreasing lists.
`fuel` only guarantees termination; `fuel >= n` suffices. -/
def partitionsAux : ℕ → ℕ → ℕ → List (List ℕ)
  | 0, n, _ => if n = 0 then [[]] else []
  | fuel + 1, n, m =>
    if n = 0 then [[]] else
      (List.range (min m n)).flatMap (fun k =>
        (partitionsAux fuel (n - (k + 1)) (k + 1)).map (fun l => (k + 1) :: l))

/-- All partitions of `n`, each listed once as a weakly decreasing list of positive parts. -/
def partitionsList (n : ℕ) : List (List ℕ) := partitionsAux n n n

/-- Product of all hook lengths of the Young diagram with row lengths `l`. -/
def hookProduct (l : List ℕ) : ℕ :=
  ∏ i ∈ Finset.range l.length, ∏ j ∈ Finset.range (l.getD i 0),
    ((l.getD i 0 - j - 1) + ((l.drop (i + 1)).filter (fun r => decide (j < r))).length + 1)

/-- Degree of the irreducible character of S_n indexed by `l`, via the hook length formula. -/
def charDegree (n : ℕ) (l : List ℕ) : ℕ := n.factorial / hookProduct l

/-- p(n), the number of partitions of n. -/
def numPartitions (n : ℕ) : ℕ := (partitionsList n).length

/-- d(n), the number of distinct irreducible character degrees of S_n. -/
def numDistinctDegrees (n : ℕ) : ℕ := ((partitionsList n).map (charDegree n)).dedup.length

def Claim : Prop :=
  ∃ L : ℝ, 0 < L ∧
    Filter.Tendsto (fun n : ℕ => (numDistinctDegrees n : ℝ) / (numPartitions n : ℝ))
      Filter.atTop (nhds L)

end OpenProblems.N683
