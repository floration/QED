import Mathlib
/-! QED-E166: Does the cubic-residue graph on 127 vertices force a monochromatic triangle?
Folkman showed that there are graphs with no 4 mutually adjacent vertices in which every red/blue colouring of the edges creates a single-coloured triangle. The fewest vertices such a graph can have, F_e(3,3;4), is only known to lie between 21 and 786. A natural candidate is the graph on the integers mod 127 that joins x and y when x - y is a nonzero cube mod 127; it has no 4 mutually adjacent vertices. Decide whether every red/blue colouring of its edges has a single-coloured triangle. A yes would show F_e(3,3;4) <= 127.
Informal statement: Let $G_{127}$ be the Cayley graph on $\mathbb Z_{127}$ with connection set $C=\{x^3: x\in\mathbb Z_{127}^{*}\}$ (a subgroup of order $42$ containing $-1$, so $G_{127}$ is a $42$-regular simple graph; it is $K_4$-free). Decide whether $G_{127}\to(3,3)^e$, i.e. whether every map $c:E(G_{127})\to\{0,1\}$ admits a triangle of $G_{127}$ whose three edges have the same colour. (Known: $21\le F_e(3,3;4)\le 786$; a positive answer gives $F_e(3,3;4)\le 127$.)
Formalization notes:
* `G127` is built with `SimpleGraph.fromRel` from the relation "x − y is the cube of a nonzero element of ZMod 127". `fromRel` adds x ≠ y and symmetrises; since −1 = (−1)³ is a cube the relation is already symmetric, so this is exactly the Cayley graph Cay(ℤ₁₂₇, C). Note x ≠ y is automatic anyway, as a nonzero cube is nonzero in the field ZMod 127.
* An edge 2-colouring is any function `c : Sym2 (ZMod 127) → Bool`; its values on non-edges and on diagonal pairs are irrelevant, because only pairs that are edges of `G127` are inspected. A monochromatic triangle is a, b, d pairwise adjacent (hence distinct) with c{a,b} = c{b,d} = c{a,d}.
* `Claim` = G127 → (3,3)^e (giving F_e(3,3;4) ≤ 127, using the known K₄-freeness, which is a finite check and not part of `Claim`). `¬Claim` = there is a 2-colouring of the edges of G127 with no monochromatic triangle. Both are open; either settles the problem.
-/
namespace OpenProblems.QEDE166

/-- The cubic-residue Cayley graph on ℤ/127. -/
def G127 : SimpleGraph (ZMod 127) :=
  SimpleGraph.fromRel (fun x y : ZMod 127 => ∃ z : ZMod 127, z ≠ 0 ∧ x - y = z ^ 3)

/-- Every red/blue colouring of the edges of `G127` has a monochromatic triangle. -/
def Claim : Prop :=
  ∀ c : Sym2 (ZMod 127) → Bool,
    ∃ a b d : ZMod 127, G127.Adj a b ∧ G127.Adj b d ∧ G127.Adj a d ∧
      c (s(a, b)) = c (s(b, d)) ∧ c (s(a, b)) = c (s(a, d))

end OpenProblems.QEDE166
