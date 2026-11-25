import Mathlib
/-! QED-E126: A regular language of generalized star height two
Regular expressions built from letters using union, concatenation, complement and Kleene star describe
exactly the regular languages. The generalized star height of a language is the smallest nesting
depth of stars any such expression needs. Languages that need zero stars (the star-free ones) and
languages that need one star (like (aa)*) are known, but nobody knows whether any regular language
needs two. Decide whether every regular language has generalized star height at most one.
Informal statement: Generalized regular expressions over a finite alphabet $\Sigma$ are built from
$\emptyset,\{\varepsilon\},a\ (a\in\Sigma)$ by $E\cup F$, $EF$, $\Sigma^*\setminus E$ and $E^*$, with
height $h(E^*)=1+h(E)$, $h$ of atoms $=0$, and $h$ of the other operations the maximum of the
arguments' heights. For regular $L\subseteq\Sigma^*$ let $h_\Sigma(L)=\min\{h(E):\mathcal L(E)=L\}$.
Decide whether there exist a finite $\Sigma$ and a regular $L\subseteq\Sigma^*$ with
$h_\Sigma(L)\ge2$; equivalently, whether $h_\Sigma(L)\le1$ for every regular $L$.
Formalization notes:
* `GRE σ` is the inductive type of generalized regular expressions over the alphabet `σ`, with
  the seven constructors above. `GRE.lang` is its semantics in Mathlib's `Language σ`
  (= `Set (List σ)`): `0` is ∅, `1` is {ε}, `+` is union, `*` is concatenation, `ᶜ` is the
  complement in σ* (the Boolean-algebra complement of `Set (List σ)`), and `KStar.kstar` is the
  Kleene star. `GRE.height` is the generalized star height of the expression.
* Regularity is Mathlib's `Language.IsRegular` (accepted by a DFA with finitely many states).
  Every regular language is denoted by an (ordinary, hence generalized) regular expression
  (Kleene), so h_Σ(L) is defined for all regular L.
* The alphabet is `Fin k` for some k; every finite alphabet is in bijection with some `Fin k` and
  relabelling letters preserves heights, so this loses nothing. The height is relative to the
  alphabet (complement is taken in σ*), as in the informal h_Σ.
* `Claim` = there is a regular language of generalized star height ≥ 2 (all expressions denoting
  it have height ≥ 2). `¬Claim` = every regular language over every finite alphabet is denoted by
  an expression of height ≤ 1. Either proof solves the problem.
-/
namespace OpenProblems.QEDE126
noncomputable section

/-- Generalized regular expressions (with complement). -/
inductive GRE (σ : Type) : Type
  | zero : GRE σ
  | one : GRE σ
  | sym : σ → GRE σ
  | union : GRE σ → GRE σ → GRE σ
  | concat : GRE σ → GRE σ → GRE σ
  | compl : GRE σ → GRE σ
  | star : GRE σ → GRE σ

namespace GRE

variable {σ : Type}

/-- The language denoted by an expression. -/
def lang : GRE σ → Language σ
  | .zero => 0
  | .one => 1
  | .sym a => {[a]}
  | .union e f => lang e + lang f
  | .concat e f => lang e * lang f
  | .compl e => (lang e)ᶜ
  | .star e => KStar.kstar (lang e)

/-- Generalized star height of an expression. -/
def height : GRE σ → ℕ
  | .zero => 0
  | .one => 0
  | .sym _ => 0
  | .union e f => max (height e) (height f)
  | .concat e f => max (height e) (height f)
  | .compl e => height e
  | .star e => height e + 1

end GRE

def Claim : Prop :=
  ∃ k : ℕ, ∃ L : Language (Fin k), L.IsRegular ∧
    ∀ e : GRE (Fin k), GRE.lang e = L → 2 ≤ GRE.height e

end
end OpenProblems.QEDE126
