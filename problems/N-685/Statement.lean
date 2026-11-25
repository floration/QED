import Mathlib
/-! N-685: Computable connective constants
Count the self-avoiding walks of length n from the identity in the Cayley graph of a finitely
generated group. Their n-th roots converge (from above, as an infimum) to the connective
constant μ, which is therefore right-computable when the word problem is solvable. Is μ always
a computable real number for groups with solvable word problem?
Informal statement: Let G be a finitely generated group with solvable word problem,
S = S⁻¹ a finite generating set, cₙ the number of n-step self-avoiding walks from e in
Cay(G,S), and μ(G,S) = lim cₙ^{1/n} = inf_{n≥1} cₙ^{1/n}. Is μ(G,S) always a computable real?
(Main question only; the uniformity question is not formalized.)
Formalization notes: G is any group with a map `gen : Fin k → G` whose image generates G;
S = {gen i} ∪ {(gen i)⁻¹} (as a set, so the Cayley graph is simple; a generator equal to 1
gives loops, which self-avoiding walks never use). Words are lists over `Fin k × Bool`
(`true` = inverse letter); "solvable word problem" is `ComputablePred` of "the word evaluates to
1" w.r.t. Mathlib's `Primcodable` instances. An n-step SAW is a step sequence `s : Fin n → S`
whose n+1 partial products (vertices visited, starting at e) are pairwise distinct; cₙ is the
number of these (`Nat.card`, a finite type since S is finite). μ is defined as the infimum
`sInf {cₙ^{1/n} : n ≥ 1}` (equal to the limit by submultiplicativity on vertex-transitive
graphs; the set is nonempty and bounded below by 0, so no junk value). A real x is computable if
there is a computable f : ℕ → ℕ × ℕ × ℕ, f(j) = (a,b,d) coding the rational (a − b)/(d + 1),
with |x − f(j)| ≤ 2^{−j}. Proving `Claim` = μ is computable for every such (G, gen);
`¬Claim` = a group with solvable word problem and generating set with non-computable μ.
-/
namespace OpenProblems.N685

/-- Decode `(a, b, d)` as the rational number `(a − b)/(d + 1)`, as a real. -/
noncomputable def decodeQ (q : ℕ × ℕ × ℕ) : ℝ :=
  (((q.1 : ℤ) - (q.2.1 : ℤ) : ℤ) : ℝ) / ((q.2.2 : ℝ) + 1)

/-- A real number is computable if it has a computable sequence of rational approximations
with error at most `2^{-j}`. -/
def IsComputableReal (x : ℝ) : Prop :=
  ∃ f : ℕ → ℕ × ℕ × ℕ, Computable f ∧ ∀ j : ℕ, |x - decodeQ (f j)| ≤ (1 / 2 : ℝ) ^ j

variable {G : Type} [Group G]

/-- Evaluate a word over the generators (`true` = inverse letter). -/
def evalWord {k : ℕ} (gen : Fin k → G) (w : List (Fin k × Bool)) : G :=
  (w.map (fun a => if a.2 then (gen a.1)⁻¹ else gen a.1)).prod

/-- The symmetric generating set `S = S⁻¹`. -/
def genSet {k : ℕ} (gen : Fin k → G) : Set G :=
  Set.range gen ∪ Set.range (fun i => (gen i)⁻¹)

/-- Vertex after the first `i` steps of a step sequence. -/
def walkVertex {k n : ℕ} (gen : Fin k → G) (s : Fin n → genSet gen) (i : ℕ) : G :=
  ((List.ofFn (fun j : Fin n => ((s j : genSet gen) : G))).take i).prod

/-- Number of `n`-step self-avoiding walks from `1` in `Cay(G, S)`. -/
noncomputable def sawCount {k : ℕ} (gen : Fin k → G) (n : ℕ) : ℕ :=
  Nat.card {s : Fin n → genSet gen //
    Function.Injective (fun i : Fin (n + 1) => walkVertex gen s (i : ℕ))}

/-- Connective constant `μ = inf_{n ≥ 1} cₙ^{1/n}`. -/
noncomputable def connConst {k : ℕ} (gen : Fin k → G) : ℝ :=
  sInf {x : ℝ | ∃ n : ℕ, 1 ≤ n ∧ x = ((sawCount gen n : ℕ) : ℝ) ^ ((1 : ℝ) / (n : ℝ))}

def Claim : Prop :=
  ∀ (G : Type) [Group G] (k : ℕ) (gen : Fin k → G),
    Subgroup.closure (Set.range gen) = ⊤ →
    ComputablePred (fun w : List (Fin k × Bool) => evalWord gen w = 1) →
    IsComputableReal (connConst gen)

end OpenProblems.N685
