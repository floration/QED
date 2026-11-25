import Mathlib
/-! N-678: First-order convergence law for random Latin squares
Pick a Latin square of order n uniformly at random and read it as a multiplication table x∘y on n
symbols. Does every first-order sentence about this quasigroup have a limiting probability as n → ∞?
(A zero-one law fails: the number of idempotents x∘x = x has mean exactly 1 and is conjecturally
Poisson(1).)
Informal statement: Let L_n be uniform among Latin squares on [n] and Q_n = ([n], ∘) with
x∘y = L_n(x,y). Prove or disprove: for every first-order sentence φ in the language {∘, =},
lim_{n→∞} Pr[Q_n ⊨ φ] exists.
Formalization notes: The language `qLang` has a single binary function symbol and no relation
symbols; equality is built into Mathlib's first-order logic (`FirstOrder.Language.Sentence`). A Latin
square of order n is a map L : Fin n → Fin n → Fin n whose rows and columns are bijections. The
structure `QG n L` is `Fin n` with `x ∘ y := L x y`. `satProb n φ` is the fraction of Latin squares of
order n satisfying φ (computed with `Set.ncard` on finite sets of functions; for n = 0 there is one
empty Latin square). `Claim` says every sentence has a real limit probability. Proving `¬ Claim`
means exhibiting a sentence whose satisfaction probability does not converge.
-/
namespace OpenProblems.N678

open FirstOrder FirstOrder.Language

/-- Function symbols: one binary operation. -/
inductive QFunc : ℕ → Type
  | mul : QFunc 2

/-- The language `{∘}` of quasigroup multiplication tables (equality is built in). -/
def qLang : Language.{0, 0} :=
  { Functions := QFunc
    Relations := fun _ => Empty }

/-- `L` is a Latin square: every row and every column is a bijection. -/
def IsLatin {n : ℕ} (L : Fin n → Fin n → Fin n) : Prop :=
  (∀ x : Fin n, Function.Bijective (L x)) ∧ (∀ y : Fin n, Function.Bijective (fun x => L x y))

/-- Carrier of the quasigroup given by the table `L` (a type synonym for `Fin n`). -/
def QG (n : ℕ) (_L : Fin n → Fin n → Fin n) : Type := Fin n

/-- Interpretation of the function symbols. -/
def QFunc.interp {n : ℕ} (L : Fin n → Fin n → Fin n) : {k : ℕ} → QFunc k → (Fin k → Fin n) → Fin n
  | _, QFunc.mul, xs => L (xs 0) (xs 1)

instance qgStructure (n : ℕ) (L : Fin n → Fin n → Fin n) : qLang.Structure (QG n L) where
  funMap := fun f xs => QFunc.interp L f xs
  RelMap := fun r _ => Empty.elim r

/-- Probability that a uniformly random Latin square of order `n` satisfies `φ`. -/
noncomputable def satProb (n : ℕ) (φ : qLang.Sentence) : ℝ :=
  (Set.ncard {L : Fin n → Fin n → Fin n | IsLatin L ∧ φ.Realize (QG n L)} : ℝ) /
    (Set.ncard {L : Fin n → Fin n → Fin n | IsLatin L} : ℝ)

def Claim : Prop :=
  ∀ φ : qLang.Sentence, ∃ ℓ : ℝ, Filter.Tendsto (fun n : ℕ => satProb n φ) Filter.atTop (nhds ℓ)

end OpenProblems.N678
