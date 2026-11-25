import Mathlib
/-! QED-E142: Three mutually orthogonal Latin squares of order 10
Two Latin squares of the same size are orthogonal if, when you lay one on top of the other, every ordered pair of symbols appears exactly once. Euler's 36-officers problem shows no orthogonal pair exists for order 6, but orthogonal pairs of order 10 were found in 1959. Nobody knows whether three Latin squares of order 10 can be pairwise orthogonal.
Informal statement: Let $N(10)$ be the maximum number of pairwise orthogonal Latin squares of order $10$. Decide whether $N(10)\ge 3$, i.e. whether there exist $L_1,L_2,L_3:[10]\times[10]\to[10]$, each a Latin square, such that for every $a\ne b$ the map $(i,j)\mapsto (L_a(i,j),L_b(i,j))$ is a bijection $[10]^2\to[10]^2$.
Formalization notes: A Latin square of order 10 is `L : Fin 10 → Fin 10 → Fin 10` with every
row `L i` and every column `fun i => L i j` bijective. Two squares are orthogonal when
`(i,j) ↦ (L i j, M i j)` is a bijection `Fin 10 × Fin 10 → Fin 10 × Fin 10`. A triple is
`L : Fin 3 → (Fin 10 → Fin 10 → Fin 10)`, pairwise orthogonal for distinct indices
(orthogonality forces the three squares to be distinct). Claim = a set of 3 MOLS(10)
exists (N(10) ≥ 3); ¬Claim = N(10) = 2 (given the known N(10) ≥ 2).
-/
namespace OpenProblems.QEDE142
noncomputable section

def IsLatin (L : Fin 10 → Fin 10 → Fin 10) : Prop :=
  (∀ i : Fin 10, Function.Bijective (L i)) ∧
    ∀ j : Fin 10, Function.Bijective (fun i : Fin 10 => L i j)

def Orth (L M : Fin 10 → Fin 10 → Fin 10) : Prop :=
  Function.Bijective (fun p : Fin 10 × Fin 10 => (L p.1 p.2, M p.1 p.2))

def Claim : Prop :=
  ∃ L : Fin 3 → (Fin 10 → Fin 10 → Fin 10),
    (∀ a : Fin 3, IsLatin (L a)) ∧ ∀ a b : Fin 3, a ≠ b → Orth (L a) (L b)

end
end OpenProblems.QEDE142
