import Mathlib
/-! QED-M035: Does UGC imply SSEH?
Give a polynomial-time reduction from Unique Games to Small-Set Expansion, i.e. prove UGC ⇒ SSEH
(Raghavendra–Steurer proved SSEH ⇒ UGC), or exhibit a separation in an explicit model.
Informal statement: Prove that Small-Set Expansion is UG-hard: for every η > 0 there are
δ ∈ (0,1) and ε > 0 such that for every alphabet size q there is a polynomial-time many-one
reduction from Gap-UG_q(1−ε, ε) to Gap-SSE(η, δ). Here Gap-UG_q(1−ε, ε) means: YES if some
labelling satisfies ≥ 1−ε of the constraints, NO if none satisfies more than ε. Gap-SSE(η, δ)
means, for regular graphs: YES if some vertex set of measure δ has expansion ≤ η, NO if every
vertex set of measure δ has expansion ≥ 1−η. Such reductions give UGC ⇒ SSEH. A separation is
only meaningful in a restricted model and is not part of Claim.
Formalization notes:
* `UGInstance q` (as in QED-M028): n variables, m constraints, the e-th constraint is
  `perm e (f (src e)) = f (dst e)`. `value f` is the satisfied fraction (0 if m = 0, so empty
  instances are NO instances).
* `SGraph` is an undirected multigraph given as an edge list (self-loops allowed, counted twice in
  degrees). `IsRegular` means n ≥ 1 and all degrees are equal to some r ≥ 1. μ(S) = |S|/n and
  Φ(S) = |∂S| / vol(S), where vol(S) = ∑_{v∈S} deg v = r|S| and ∂S is the set of edges with exactly
  one endpoint in S. This is the Raghavendra–Steurer(–Tulsiani) formulation with exact measure δ.
  Both YES and NO instances must be regular, so the promise sets are disjoint for η < 1/2.
* Polynomial time: instances are encoded as bit strings (`encUG`, `encG`) using self-delimiting
  unary numerals (polynomially related to the natural instance size). A reduction is a map
  R : UGInstance q → SGraph together with a function F : List Bool → List Bool that is
  `Turing.TM2ComputableInPolyTime` (Mathlib's polynomial-time multi-stack Turing machines, with
  the identity encoding of `List Bool` over the alphabet `Bool`) and satisfies
  F (encUG I) = encG (R I).
* Quantifiers: δ and ε depend only on η, and the reduction may depend on q. UGC gives, for each
  ε, some q = q(ε) with Gap-UG_q(1−ε, ε) NP-hard, so Claim ⇒ (UGC ⇒ SSEH). Requiring the reduction
  for every q is necessary. Otherwise q = 1, where every instance with m > 0 has value 1, would
  give a trivial reduction (test m = 0).
* Claim also follows from unconditional NP-hardness of Gap-SSE(η, δ), since Gap-UG_q is a promise
  problem in NP. The bare implication "UGC ⇒ SSEH" is not used as Claim because it is vacuously
  true if UGC is false.
Proving `Claim` = such reductions (SSE is UG-hard). Proving `¬Claim` = for some η > 0 no
(δ, ε) has polynomial-time reductions for all q. That would in particular imply P ≠ NP (if
P = NP, every promise problem in NP reduces to any non-trivial one), so the negative direction is
out of reach unconditionally, as expected.
-/
namespace OpenProblems.QEDM035
noncomputable section

/-! ### Unique Games -/

/-- A Unique Games instance over alphabet `Fin q`. -/
structure UGInstance (q : ℕ) where
  n : ℕ
  m : ℕ
  src : Fin m → Fin n
  dst : Fin m → Fin n
  perm : Fin m → Equiv.Perm (Fin q)

/-- Fraction of constraints satisfied by the labelling `f`. -/
def UGInstance.value {q : ℕ} (I : UGInstance q) (f : Fin I.n → Fin q) : ℝ :=
  ((Finset.univ.filter (fun e : Fin I.m => I.perm e (f (I.src e)) = f (I.dst e))).card : ℝ) /
    (I.m : ℝ)

/-- YES instances of Gap-UG(1−ε, ε). -/
def UGYes {q : ℕ} (ε : ℝ) (I : UGInstance q) : Prop := ∃ f : Fin I.n → Fin q, 1 - ε ≤ I.value f

/-- NO instances of Gap-UG(1−ε, ε). -/
def UGNo {q : ℕ} (ε : ℝ) (I : UGInstance q) : Prop := ∀ f : Fin I.n → Fin q, I.value f ≤ ε

/-! ### Small-Set Expansion -/

/-- An undirected multigraph as an edge list. -/
structure SGraph where
  n : ℕ
  m : ℕ
  src : Fin m → Fin n
  dst : Fin m → Fin n

/-- Degree (a self-loop contributes 2). -/
def SGraph.deg (G : SGraph) (v : Fin G.n) : ℕ :=
  (Finset.univ.filter fun e : Fin G.m => G.src e = v).card +
    (Finset.univ.filter fun e : Fin G.m => G.dst e = v).card

/-- Nonempty and `r`-regular for some `r ≥ 1`. -/
def SGraph.IsRegular (G : SGraph) : Prop :=
  0 < G.n ∧ ∃ r : ℕ, 0 < r ∧ ∀ v : Fin G.n, G.deg v = r

/-- Number of edges leaving `S`. -/
def SGraph.boundary (G : SGraph) (S : Finset (Fin G.n)) : ℕ :=
  (Finset.univ.filter fun e : Fin G.m =>
    (G.src e ∈ S ∧ G.dst e ∉ S) ∨ (G.src e ∉ S ∧ G.dst e ∈ S)).card

/-- Volume of `S`. -/
def SGraph.vol (G : SGraph) (S : Finset (Fin G.n)) : ℕ := ∑ v ∈ S, G.deg v

/-- Edge expansion `Φ(S) = |∂S| / vol(S)`. -/
def SGraph.expansion (G : SGraph) (S : Finset (Fin G.n)) : ℝ :=
  (G.boundary S : ℝ) / (G.vol S : ℝ)

/-- Uniform measure `|S| / n`. -/
def SGraph.measure (G : SGraph) (S : Finset (Fin G.n)) : ℝ := (S.card : ℝ) / (G.n : ℝ)

/-- YES instances of Gap-SSE(η, δ). -/
def SSEYes (η δ : ℝ) (G : SGraph) : Prop :=
  G.IsRegular ∧ ∃ S : Finset (Fin G.n), G.measure S = δ ∧ G.expansion S ≤ η

/-- NO instances of Gap-SSE(η, δ). -/
def SSENo (η δ : ℝ) (G : SGraph) : Prop :=
  G.IsRegular ∧ ∀ S : Finset (Fin G.n), G.measure S = δ → 1 - η ≤ G.expansion S

/-! ### Encodings and polynomial time -/

/-- Self-delimiting unary numeral. -/
def unary (k : ℕ) : List Bool := List.replicate k true ++ [false]

/-- Concatenation of a list of bit strings. -/
def concatL : List (List Bool) → List Bool
  | [] => []
  | l :: t => l ++ concatL t

/-- Encoding of a Unique Games instance. -/
def encUG {q : ℕ} (I : UGInstance q) : List Bool :=
  unary I.n ++ unary I.m ++
    concatL (List.ofFn fun e : Fin I.m =>
      unary (I.src e).val ++ unary (I.dst e).val ++
        concatL (List.ofFn fun i : Fin q => unary (I.perm e i).val))

/-- Encoding of a graph. -/
def encG (G : SGraph) : List Bool :=
  unary G.n ++ unary G.m ++
    concatL (List.ofFn fun e : Fin G.m => unary (G.src e).val ++ unary (G.dst e).val)

/-- Bit strings encoded as themselves over the alphabet `Bool`. -/
def listBoolEnc : Computability.FinEncoding (List Bool) where
  Γ := Bool
  encode := id
  decode := Option.some
  decode_encode := fun _ => rfl
  ΓFin := inferInstance

/-- `F` is computable in polynomial time by a Mathlib multi-stack Turing machine. -/
def PolyTimeFn (F : List Bool → List Bool) : Prop :=
  Nonempty (Turing.TM2ComputableInPolyTime listBoolEnc listBoolEnc F)

/-- Small-Set Expansion is UG-hard. -/
def Claim : Prop :=
  ∀ η : ℝ, 0 < η → ∃ δ : ℝ, 0 < δ ∧ δ < 1 ∧ ∃ ε : ℝ, 0 < ε ∧ ∀ q : ℕ,
    ∃ (R : UGInstance q → SGraph) (F : List Bool → List Bool),
      PolyTimeFn F ∧ (∀ I : UGInstance q, F (encUG I) = encG (R I)) ∧
      (∀ I : UGInstance q, UGYes ε I → SSEYes η δ (R I)) ∧
      (∀ I : UGInstance q, UGNo ε I → SSENo η δ (R I))

end
end OpenProblems.QEDM035
