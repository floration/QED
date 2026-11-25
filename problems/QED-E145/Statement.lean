import Mathlib
/-! QED-E145: No perfect single-error-correcting code over a 6-letter alphabet
A code of words of length n over a 6-letter alphabet is 1-perfect if every possible word is either a codeword or differs from exactly one codeword in exactly one position. Over alphabets whose size is a prime power, such codes (Hamming codes) exist in infinitely many lengths. Over 6 letters none is known for n≥2. Counting arguments and Lloyd's theorem leave only lengths 7, 19, 43, 97, 115, 259, ..., and only 7 and 19 have been ruled out. Prove that none exists.
Informal statement: Let $H(n,6)=\{0,\dots,5\}^n$ with the Hamming distance $d$. Prove that for no $n\ge2$ is there $C\subseteq H(n,6)$ such that every $x\in H(n,6)$ has exactly one $c\in C$ with $d(x,c)\le1$.
Formalization notes: Words are `Fin n → Fin 6`; distance is Mathlib's `hammingDist`
(number of coordinates where two words differ). A 1-perfect code is a finite set `C` of
words with every word within distance 1 of exactly one codeword (balls of radius 1 tile
the space). The cases n = 0, 1 are excluded since they are trivially perfect (a single
codeword). Claim = no 1-perfect code over a 6-letter alphabet for any length n ≥ 2;
¬Claim = such a code exists for some n ≥ 2 (necessarily n ∈ {43, 97, 115, 259, ...}).
-/
namespace OpenProblems.QEDE145
noncomputable section

def Claim : Prop :=
  ∀ n : ℕ, 2 ≤ n → ¬ ∃ C : Finset (Fin n → Fin 6),
    ∀ x : Fin n → Fin 6, ∃! c : Fin n → Fin 6, c ∈ C ∧ hammingDist x c ≤ 1

end
end OpenProblems.QEDE145
