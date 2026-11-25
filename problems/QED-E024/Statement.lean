import Mathlib
/-! QED-E024: Ramsey multiplicity constant of K_4
In any red/blue colouring of the edges of a huge complete graph, some fraction of all 4-vertex sets must be single-coloured (all 6 edges the same colour). The minimum possible fraction is known only to lie between about 0.0296 and 0.03015. Pin it down further, or find its exact value.
Informal statement: Let $c_4=\lim_{n\to\infty}\min_{G,|V(G)|=n}\big(k_4(G)+k_4(\bar G)\big)/\binom n4$.
Known: $0.0296<c_4\le U:=4551721\cdot 2^{-24}\cdot 3^{-2}\approx 0.0301449$ (upper bound:
Parczyk–Pokutta–Spiegel–Szabó, Found. Comput. Math. 2024, from blow-ups of a 768-vertex Cayley
graph). Formalized target (strict improvement of the best known UPPER bound): prove $c_4 < U$.
Formalization notes:
* `mono G` counts 4-element vertex sets of `G` that are cliques of `G` or of its complement
  `Gᶜ` (i.e. the monochromatic K₄'s of the red/blue colouring "red = edge of G"). A 4-set cannot
  be both, so this is k₄(G) + k₄(Ḡ).
* `m n` = min over all simple graphs on `Fin n` of `mono G / C(n,4)` (an `iInf` over the finite,
  nonempty type `SimpleGraph (Fin n)`; values lie in [0,1], so the real `iInf` is a genuine
  minimum). For n < 4 the ratio is the junk value 0, which is irrelevant below.
* Standard averaging over (n−1)-vertex subsets shows `m n` is nondecreasing for n ≥ 4, so
  c₄ = lim m n = sup_{n≥4} m n exists and m n ≤ c₄ for all n ≥ 4. Hence
  c₄ < U  ⇔  ∃ c < U, m n ≤ c for all large n. We state the right-hand side, which avoids
  defining the limit with junk values. (A single finite graph can never prove it, as m n ≤ c₄;
  a proof needs a sequence, e.g. a better blow-up construction.)
* The known upper bound is non-strict (it is the exact density of a blow-up family), so
  `Claim` is a genuine strict improvement. Proving `Claim` = c₄ < 4551721/(2²⁴·9). Proving
  `¬Claim` = c₄ = 4551721/(2²⁴·9) exactly (the PPSS construction is optimal), given the known
  bound c₄ ≤ U.
-/
namespace OpenProblems.QEDE024
noncomputable section
open scoped Classical

/-- Number of monochromatic 4-sets: 4-cliques of `G` plus 4-cliques of the complement. -/
def mono {n : ℕ} (G : SimpleGraph (Fin n)) : ℕ :=
  ((Finset.univ : Finset (Finset (Fin n))).filter (fun s : Finset (Fin n) =>
    s.card = 4 ∧ ((s : Set (Fin n)).Pairwise G.Adj ∨ (s : Set (Fin n)).Pairwise Gᶜ.Adj))).card

/-- Minimum fraction of monochromatic 4-sets over all 2-colourings of `K_n`. -/
def m (n : ℕ) : ℝ :=
  ⨅ G : SimpleGraph (Fin n), (mono G : ℝ) / (Nat.choose n 4 : ℝ)

/-- The best known upper bound `4551721 · 2⁻²⁴ · 3⁻²`. -/
def U : ℝ := 4551721 / ((2 : ℝ) ^ 24 * 9)

/-- `c₄ < U`, expressed via the (nondecreasing) finite minima. -/
def Claim : Prop :=
  ∃ c : ℝ, c < U ∧ ∀ᶠ n : ℕ in Filter.atTop, m n ≤ c

end
end OpenProblems.QEDE024
