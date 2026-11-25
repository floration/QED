import Mathlib
/-! QED-E190: Conjugacy problem for one-relator groups
A one-relator group is obtained from a free group on finitely many letters by imposing a single relation r = 1. Magnus showed in 1932 that one can always decide whether two words are equal in such a group. Can one also always decide whether two words are conjugate, i.e. whether u = g v g^{-1} for some g? Many classes are done, including (by a 2026 claim) all one-relator groups without Baumslag-Solitar subgroups, which are hyperbolic; what remains are one-relator groups that contain a Baumslag-Solitar subgroup.
Informal statement: For $n\ge1$ and $r\in F_n$ (free group on $x_1,\dots,x_n$) let $G_r=F_n/\langle\!\langle r\rangle\!\rangle$ and $\pi:F_n\to G_r$. Decide whether, for every $n$ and every $r\in F_n$, the set $\mathrm{Conj}_r=\{(u,v)\in F_n^2:\exists g\in G_r,\ \pi(u)=g\,\pi(v)\,g^{-1}\}$ is decidable. A solution is either a proof that it is (an algorithm uniform in $(n,r,u,v)$ is a stronger positive answer), or an explicit pair $(n,r)$ for which $\mathrm{Conj}_r$ is undecidable. (Since Baumslag-Solitar-free one-relator groups are hyperbolic, the problem concerns only $r$ for which $G_r$ contains some $BS(p,q)$.)
Formalization notes:
* `G r` is `FreeGroup (Fin n) ⧸ normalClosure {r}`, the one-relator group (built by hand rather
  than via `PresentedGroup`; it is the same quotient).
* Inputs are words `List (Fin n × Bool)` (letter, `false` = inverse in Mathlib's convention, `FreeGroup.of x = mk [(x, true)]`;
  either convention gives the same decision problem), mapped to the group by `FreeGroup.mk` and
  the quotient map. Words need not be reduced; the predicate depends only on the group elements.
  `List (Fin n × Bool) × List (Fin n × Bool)` is `Primcodable` via Mathlib's instances, and
  decidability is Mathlib's `ComputablePred` (computable characteristic function).
* Conjugacy is Mathlib's `IsConj` in `G r`.
* Claim is the non-uniform statement: for every n and every relator r, conjugacy in G_r is
  decidable. ¬Claim = some explicit-or-not (n, r) with undecidable conjugacy problem (a
  classical existence proof suffices for ¬Claim; the informal statement asks for an explicit
  pair, which any natural proof would give). The stronger uniform version is not formalized.
  n = 0 is included harmlessly (trivial group).
-/
namespace OpenProblems.QEDE190
noncomputable section

/-- The one-relator group `⟨x₁, …, xₙ | r⟩`. -/
abbrev G {n : ℕ} (r : FreeGroup (Fin n)) : Type :=
  FreeGroup (Fin n) ⧸ Subgroup.normalClosure ({r} : Set (FreeGroup (Fin n)))

/-- Image of a word in the one-relator group. -/
def toG {n : ℕ} (r : FreeGroup (Fin n)) (w : List (Fin n × Bool)) : G r :=
  QuotientGroup.mk (s := Subgroup.normalClosure ({r} : Set (FreeGroup (Fin n)))) (FreeGroup.mk w)

def Claim : Prop :=
  ∀ n : ℕ, ∀ r : FreeGroup (Fin n),
    ComputablePred (fun p : List (Fin n × Bool) × List (Fin n × Bool) =>
      IsConj (toG r p.1) (toG r p.2))

end
end OpenProblems.QEDE190
