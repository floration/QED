import Mathlib
/-! QED-E215: Ovoids of the parabolic quadric Q(6,q) when q is not a power of 3
Over a finite field with q elements (q odd), take the quadratic form Q(x)=x0x1+x2x3+x4x5+x6^2 in seven variables. An ovoid is a set of q^3+1 isotropic points (nonzero solutions of Q=0, up to scaling) no two of which are orthogonal. Ovoids exist when q is a power of 3 and do not exist when q is even or q is a prime larger than 3. Does an ovoid exist for any other q? The smallest open case is q=25.
Informal statement: Let $q=p^h$ with $p\ge5$ prime and $h\ge2$. Put $Q(x)=x_0x_1+x_2x_3+x_4x_5+x_6^2$ on $\mathbb F_q^7$ and $B(x,y)=Q(x+y)-Q(x)-Q(y)$. Decide whether there is a set $S\subseteq\mathbb F_q^7\setminus\{0\}$ with $|S|=q^3+1$, $Q(v)=0$ for all $v\in S$, and $B(v,w)\ne0$ for all distinct $v,w\in S$ (i.e. whether $Q(6,q)$ has an ovoid). The smallest open case is $q=25$; it is widely expected that no such $S$ exists.
Formalization notes: F ranges over all finite fields (`Field F`, `Fintype F`) with
`Fintype.card F = p^h`, p prime ≥ 5, h ≥ 2 (every such q is realized by some F, and the question
does not depend on the choice of F up to isomorphism). Q is the explicit nondegenerate parabolic
form of Q(6,q) and B its polar form. A set S of vectors stands for a set of projective points:
the conditions force distinct elements of S to be non-proportional, because for Q(v) = 0 one has
B(v, λv) = 2λQ(v) = 0; hence |S| = q³+1 vectors give q³+1 distinct singular points, pairwise
non-orthogonal, i.e. pairwise non-collinear on the quadric. A set of q³+1 pairwise non-collinear
singular points of Q(6,q) is exactly an ovoid (standard counting: each of the generators meets it
at most once and the double count forces exactly once), so this is the standard notion.
Claim is the conjectured (expected) answer: Q(6,q) has no ovoid for every q = p^h, p ≥ 5, h ≥ 2.
¬Claim means an ovoid exists for some such q (e.g. q = 25). Deciding a single case such as q = 25
without the general case is not captured by Claim alone.
-/
namespace OpenProblems.QEDE215
noncomputable section

/-- The parabolic quadratic form x0x1 + x2x3 + x4x5 + x6² on F⁷. -/
def Q {F : Type} [Field F] (x : Fin 7 → F) : F :=
  x 0 * x 1 + x 2 * x 3 + x 4 * x 5 + x 6 ^ 2

/-- Its polar bilinear form B(x,y) = Q(x+y) - Q(x) - Q(y). -/
def B {F : Type} [Field F] (x y : Fin 7 → F) : F :=
  Q (x + y) - Q x - Q y

/-- `S` represents an ovoid of Q(6,q): q³+1 nonzero singular vectors, pairwise non-orthogonal. -/
def IsOvoid {F : Type} [Field F] [Fintype F] (S : Finset (Fin 7 → F)) : Prop :=
  S.card = Fintype.card F ^ 3 + 1 ∧ (∀ v ∈ S, v ≠ 0 ∧ Q v = 0) ∧
    ∀ v ∈ S, ∀ w ∈ S, v ≠ w → B v w ≠ 0

def Claim : Prop :=
  ∀ (F : Type) [Field F] [Fintype F] (p h : ℕ), p.Prime → 5 ≤ p → 2 ≤ h →
    Fintype.card F = p ^ h → ¬ ∃ S : Finset (Fin 7 → F), IsOvoid S

end
end OpenProblems.QEDE215
