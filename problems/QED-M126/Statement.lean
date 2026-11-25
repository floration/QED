import Mathlib
/-! QED-M126: Glauber dynamics for colourings mixes rapidly with (1+eps)Delta colours
To sample a random proper colouring of a graph with q colours, repeat this step: pick a random
vertex and a random colour, and recolour the vertex if no neighbour already has that colour. For
large maximum degree Delta this chain is known to reach equilibrium in polynomial time once q is a
bit above (1+1/e)Delta. Conjecturally q >= Delta+2 is enough. Weakest asymptotic form: for every
eps > 0, are (1+eps)Delta colours enough once Delta is large?
Informal statement: For a finite graph G on n vertices with maximum degree Δ and q colours, let Ω
be the set of proper q-colourings and P the Glauber (Metropolis) chain on Ω: choose v ∈ V and
c ∈ [q] uniformly and set σ(v) = c if no neighbour of v has colour c. Let
t_mix(G,q) = min{t : max_{σ∈Ω} ‖P^t(σ,·) − U_Ω‖_TV ≤ 1/4}. Claim: for every ε > 0 there are Δ₀
and C such that t_mix(G,q) ≤ C·n^C for every graph G with Δ(G) ≥ Δ₀ and every integer
q ≥ (1+ε)Δ(G).
Formalization notes:
* Graphs are `SimpleGraph (Fin n)` (every finite simple graph up to isomorphism); Δ(G) is Mathlib's
  `SimpleGraph.maxDegree`.
* The chain is run on all maps `Fin n → Fin q`; `glauberStep G σ v c` recolours `v` to `c` if no
  neighbour of `v` has colour `c` and otherwise leaves `σ` unchanged (lazy Metropolis rule; the
  choice c = σ(v) is a holding step, as in the standard chain). From a proper colouring the chain
  stays among proper colourings, so `law` started at a proper σ is supported on Ω and the total
  variation distance computed over all maps equals the one over Ω.
* `trans G q σ τ = #{(v,c) : glauberStep G σ v c = τ} / (n q)` is the transition matrix;
  `law G q σ t` is the row P^t(σ,·), defined by the recursion law_{t+1}(τ) = Σ_ρ law_t(ρ) P(ρ,τ).
* `uniformProper` is the uniform distribution on Ω (0 off Ω); `tvDist μ ν = ½ Σ |μ − ν|`.
* `MixedBy G q t` says max over proper σ of the TV distance at time t is ≤ 1/4. Since
  d(t) = max_σ ‖P^t(σ,·) − π‖_TV is non-increasing for every finite Markov chain with stationary
  distribution π (here π = U_Ω, P is symmetric), "∃ t ≤ T, MixedBy G q t" is equivalent to
  t_mix ≤ T; this avoids `Nat.find`.
* Claim: ∀ ε > 0, ∃ Δ₀ C : ℕ, ∀ n G q, Δ(G) ≥ Δ₀ → q ≥ (1+ε)Δ(G) → t_mix(G,q) ≤ C·n^C.
  Δ₀ is chosen by the prover, so the range Δ+2 > q ≥ (1+ε)Δ (where the chain may be non-ergodic)
  is excluded by taking Δ₀ ≥ 2/ε, exactly as in the informal statement. Proving `Claim` = the
  asymptotic (1+o(1))Δ rapid-mixing conjecture; `¬Claim` = some ε > 0 and graphs of arbitrarily
  large degree with super-polynomial mixing at q ≥ (1+ε)Δ.
-/
namespace OpenProblems.QEDM126
noncomputable section
open Classical

/-- `σ` is a proper colouring of `G`. -/
def IsProper {n q : ℕ} (G : SimpleGraph (Fin n)) (σ : Fin n → Fin q) : Prop :=
  ∀ u v : Fin n, G.Adj u v → σ u ≠ σ v

/-- One Glauber (Metropolis) update with chosen vertex `v` and colour `c`. -/
def glauberStep {n q : ℕ} (G : SimpleGraph (Fin n)) (σ : Fin n → Fin q) (v : Fin n) (c : Fin q) :
    Fin n → Fin q :=
  if (∀ u : Fin n, G.Adj v u → σ u ≠ c) then Function.update σ v c else σ

/-- Transition probability `P(σ, τ)` of the Glauber chain (`(v,c)` uniform on `Fin n × Fin q`). -/
def trans {n q : ℕ} (G : SimpleGraph (Fin n)) (σ τ : Fin n → Fin q) : ℝ :=
  ((Finset.univ.filter (fun vc : Fin n × Fin q => glauberStep G σ vc.1 vc.2 = τ)).card : ℝ) /
    ((n : ℝ) * (q : ℝ))

/-- The distribution `P^t(σ, ·)` of the chain after `t` steps, started at `σ`. -/
def law {n q : ℕ} (G : SimpleGraph (Fin n)) (σ : Fin n → Fin q) : ℕ → (Fin n → Fin q) → ℝ
  | 0 => fun τ => if τ = σ then 1 else 0
  | t + 1 => fun τ => ∑ ρ : Fin n → Fin q, law G σ t ρ * trans G ρ τ

/-- Number of proper colourings `|Ω|`. -/
def numProper {n q : ℕ} (G : SimpleGraph (Fin n)) : ℕ :=
  (Finset.univ.filter (fun σ : Fin n → Fin q => IsProper G σ)).card

/-- The uniform distribution on proper colourings. -/
def uniformProper {n q : ℕ} (G : SimpleGraph (Fin n)) (τ : Fin n → Fin q) : ℝ :=
  if IsProper G τ then 1 / ((numProper (q := q) G : ℕ) : ℝ) else 0

/-- Total variation distance between two functions on a finite type. -/
def tvDist {α : Type} [Fintype α] (μ ν : α → ℝ) : ℝ :=
  (1 / 2 : ℝ) * ∑ a : α, |μ a - ν a|

/-- After `t` steps, every proper starting state is within TV distance `1/4` of uniform. -/
def MixedBy {n : ℕ} (G : SimpleGraph (Fin n)) (q t : ℕ) : Prop :=
  ∀ σ : Fin n → Fin q, IsProper G σ → tvDist (law G σ t) (uniformProper (q := q) G) ≤ 1 / 4

def Claim : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ Δ₀ C : ℕ, ∀ (n : ℕ) (G : SimpleGraph (Fin n)) [DecidableRel G.Adj] (q : ℕ),
    Δ₀ ≤ G.maxDegree → (1 + ε) * (G.maxDegree : ℝ) ≤ (q : ℝ) →
      ∃ t : ℕ, t ≤ C * n ^ C ∧ MixedBy G q t

end
end OpenProblems.QEDM126
