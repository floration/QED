import Mathlib
/-! QED-E218: Does a generalized quadrangle of order (4,12) exist?
A generalized quadrangle of order (s,t) is a point-line geometry in which every line has s+1 points, every point is on t+1 lines, two points share at most one line, and for every point P not on a line L exactly one point of L is collinear with P. For five points per line (s=4), the standard counting conditions allow t in {1,2,4,6,8,11,12,16}, and all but t=11 and t=12 are realised. Decide, for t=11 and for t=12, whether such a quadrangle exists.
Informal statement: For each $t\in\{11,12\}$, determine whether there exists a finite incidence structure $(\mathcal P,\mathcal L)$ with nonempty point set, every line of size $5$, every point on exactly $t+1$ lines, two distinct lines meeting in at most one point, and such that for every $P\notin L$ there is exactly one $Q\in L$ collinear with $P$. (Equivalently: determine the set of $t$ for which a $\mathrm{GQ}(4,t)$ exists; known examples give $\{1,2,4,6,8,16\}$.)
Formalization notes:
* Points: `Fin N` (any finite point set up to relabelling). Lines are identified with their
  point sets, `L : Finset (Finset (Fin N))`; this loses nothing because distinct lines of a GQ
  with s ≥ 1 share at most one point and so have distinct point sets.
* `IsGQ s t N L`: N > 0 (nonempty point set: without it the empty structure satisfies every
  axiom vacuously); every line has s+1 points; every point is on exactly t+1 lines; distinct
  lines meet in ≤ 1 point (equivalent to "two points share at most one line"); and for every
  point p and line l with p ∉ l there is exactly one q ∈ l collinear with p (on a common line).
  Connectedness and the standard counts |P| = (s+1)(st+1) follow from these axioms.
* The source problem has two independent cases, and one Prop cannot decide two independent
  bits. So this file covers only t = 12: Claim := ¬ GQExists 4 12. Proving Claim shows no
  GQ(4,12) exists; proving ¬Claim gives one. The case t = 11 is a separate board problem with the
  same definitions.
-/
namespace OpenProblems.QEDE218
noncomputable section

/-- `L` is the line set of a generalized quadrangle of order `(s,t)` on the points `Fin N`. -/
def IsGQ (s t N : ℕ) (L : Finset (Finset (Fin N))) : Prop :=
  0 < N ∧
  (∀ l ∈ L, l.card = s + 1) ∧
  (∀ p : Fin N, (L.filter (fun l : Finset (Fin N) => p ∈ l)).card = t + 1) ∧
  (∀ l ∈ L, ∀ m ∈ L, l ≠ m → (l ∩ m).card ≤ 1) ∧
  (∀ p : Fin N, ∀ l ∈ L, p ∉ l → ∃! q : Fin N, q ∈ l ∧ ∃ m ∈ L, p ∈ m ∧ q ∈ m)

/-- A generalized quadrangle of order `(s,t)` exists. -/
def GQExists (s t : ℕ) : Prop := ∃ N : ℕ, ∃ L : Finset (Finset (Fin N)), IsGQ s t N L

/-- No generalized quadrangle of order (4,12) exists. (Order (4,11) is a separate problem.) -/
def Claim : Prop := ¬ GQExists 4 12

end
end OpenProblems.QEDE218
