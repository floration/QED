import Mathlib
/-! QED-E192: Hard squares at activity -1: free-strip transfer-matrix eigenvalues are roots of unity
Take a row of K sites. A row state is a set of sites with no two neighbours occupied (there are Fibonacci-many). Let O_K be the matrix with entry (-1)^{|t|} from state s to state t when s and t share no occupied site, and 0 otherwise: the transfer matrix of the hard-square lattice gas at activity -1 on a strip with free side boundaries. Show that every eigenvalue of O_K is a root of unity for every K, i.e. its characteristic polynomial is a product of cyclotomic polynomials.
Informal statement: For $K\ge1$ let $\mathcal S_K=\{s\subseteq\{1,\dots,K\}: s\text{ has no two consecutive elements}\}$ and $O_K\in\mathbb Z^{\mathcal S_K\times\mathcal S_K}$, $(O_K)_{s,t}=(-1)^{|t|}[s\cap t=\emptyset]$. Prove that for every $K\ge1$ every root of $\det(xI-O_K)$ is a root of unity. ($O_K$ itself need not have finite order; the claim is about the spectrum only.)
Formalization notes: Sites are `Fin K` (0-indexed, same as {1,…,K} up to shift). `State K` is the subtype of
finsets of `Fin K` with no two elements i, j satisfying i + 1 = j (as natural numbers), i.e. no two
consecutive occupied sites (free boundary: site K-1 and site 0 are NOT adjacent). `O K` is the integer matrix
with entry (-1)^|t| if s ∩ t = ∅ and 0 otherwise. Its characteristic polynomial is taken after mapping to ℂ
(`Matrix.charpoly`, which is det(X·I - O), monic of degree |State K| ≥ 1, so it has roots and the claim is not
vacuous). Claim: for every K ≥ 1, every complex root z of the charpoly satisfies z^n = 1 for some n ≥ 1.
Proving Claim settles the Fendley–Schoutens–van Eerten free-boundary conjecture; ¬Claim exhibits a K and an
eigenvalue that is not a root of unity. The sign convention (sign on t rather than s) gives a similar matrix,
so the spectrum is convention-independent.
-/
namespace OpenProblems.QEDE192
noncomputable section

/-- Row states of a free strip of width `K`: sets of sites with no two consecutive sites occupied. -/
abbrev State (K : ℕ) : Type :=
  {s : Finset (Fin K) // ∀ i ∈ s, ∀ j ∈ s, (i : ℕ) + 1 ≠ (j : ℕ)}

/-- Transfer matrix of hard squares at activity `-1` on the free strip of width `K`. -/
def O (K : ℕ) : Matrix (State K) (State K) ℤ :=
  fun s t => if s.1 ∩ t.1 = ∅ then (-1 : ℤ) ^ t.1.card else 0

def Claim : Prop :=
  ∀ K : ℕ, 1 ≤ K → ∀ z : ℂ, ((O K).map (Int.castRingHom ℂ)).charpoly.IsRoot z →
    ∃ n : ℕ, 0 < n ∧ z ^ n = 1

end
end OpenProblems.QEDE192
