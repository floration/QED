import Mathlib
/-! QED-M135: Is the Shannon capacity of a graph computable?
The Shannon capacity Θ(G) of a finite graph is the limit of α(G^k)^{1/k}, where α is the independence number of
the k-th strong power. Every α(G^k) is computable, so one can list ever better lower bounds, but no algorithm is
known that produces upper bounds converging to Θ(G). Decide whether some algorithm, given G and a rational q, halts
exactly when Θ(G) < q (equivalently, whether Θ is a computable function).
Informal statement: Encode finite simple graphs and rationals as natural numbers and let
$\Theta(G)=\sup_k\alpha(G^{\boxtimes k})^{1/k}$. Determine whether $U=\{(G,q):\Theta(G)<q\}$ is recursively
enumerable. (Since $\{(G,q):\Theta(G)>q\}$ is r.e., $U$ is r.e. iff $G\mapsto\Theta(G)$ is a computable
real-valued function.)
Formalization notes: A graph code is (n, l) : ℕ × List (ℕ × ℕ); it denotes the simple graph on Fin n in which
u ~ v iff u ≠ v and (u, v) or (v, u) occurs in l (pairs with an entry ≥ n are ignored). Every finite simple graph
arises (up to isomorphism; Θ is an isomorphism invariant). A rational threshold is a code (a, b) : ℕ × ℕ denoting
a/(b+1); negative thresholds are omitted since Θ ≥ 0 makes Θ < q false for them (a computable, trivial part). The
k-th strong power G^⊠k has vertex set Fin k → Fin n, with σ ~ τ iff σ ≠ τ and for every coordinate i, σ i = τ i or
σ i ~ τ i. α is the maximum size of an independent finset (a set of ℕ bounded by the number of vertices, so sSup is
the true maximum). Θ(G) = sup_{k ≥ 1} α(G^⊠k)^{1/k} (real rpow), which equals the limit by Fekete's lemma
(supermultiplicativity); the family is bounded by n so the iSup is the true supremum. "r.e." is Mathlib's `REPred`
(the predicate is the domain of a partial recursive function) on the Primcodable type of codes.
`Claim` = U is r.e. (equivalently Θ is computable). `¬Claim` = U is not r.e. (Θ is not computable). The weaker
subquestion (is Θ(C₇) a computable real?) is not encoded.
-/
namespace OpenProblems.QEDM135

noncomputable section

open Classical

/-- The graph on Fin n coded by an edge list: u ~ v iff u ≠ v and (u, v) or (v, u) occurs in the list. -/
def toGraph (c : ℕ × List (ℕ × ℕ)) : SimpleGraph (Fin c.1) :=
  SimpleGraph.fromRel fun u v : Fin c.1 => ((u : ℕ), (v : ℕ)) ∈ c.2

/-- The k-th strong power G^⊠k on Fin k → V: σ ~ τ iff σ ≠ τ and each coordinate is equal or adjacent
(the relation is already symmetric, so `fromRel` adds nothing beyond σ ≠ τ). -/
def strongPow {V : Type} (G : SimpleGraph V) (k : ℕ) : SimpleGraph (Fin k → V) :=
  SimpleGraph.fromRel fun σ τ : Fin k → V => ∀ i : Fin k, σ i = τ i ∨ G.Adj (σ i) (τ i)

/-- Independence number: the largest size of a finset with no two adjacent elements. -/
def indepNum {V : Type} (G : SimpleGraph V) : ℕ :=
  sSup {m : ℕ | ∃ s : Finset V, s.card = m ∧ ∀ a ∈ s, ∀ b ∈ s, ¬ G.Adj a b}

/-- Shannon capacity Θ(G) = sup_{k≥1} α(G^⊠k)^{1/k}. -/
def shannonCap {V : Type} (G : SimpleGraph V) : ℝ :=
  ⨆ k : ℕ, ((indepNum (strongPow G (k + 1)) : ℕ) : ℝ) ^ ((1 : ℝ) / ((k : ℝ) + 1))

/-- The nonnegative rational a/(b+1). -/
def qOf (p : ℕ × ℕ) : ℝ := (p.1 : ℝ) / ((p.2 : ℝ) + 1)

def Claim : Prop :=
  REPred (fun p : (ℕ × List (ℕ × ℕ)) × (ℕ × ℕ) => shannonCap (toGraph p.1) < qOf p.2)

end

end OpenProblems.QEDM135
