import Mathlib
/-! QED-E193: Do hexagonal and cubic ice have the same residual entropy?
In ice, each oxygen sits at a vertex of a 4-regular crystal lattice and the hydrogens obey the ice rule: two bonds point in and two point out at every vertex. Counting such configurations is counting Eulerian orientations of the lattice. Hexagonal ice (Ih, the lonsdaleite net) and cubic ice (Ic, the diamond net) are two different stackings of the same puckered layers and look identical locally. Onsager proved that hexagonal ice has at least as many configurations per molecule as cubic ice. Are the two per-vertex growth constants exactly equal?
Informal statement: Let $D$ be the diamond net and $H$ the lonsdaleite (hexagonal diamond) net, viewed as 4-regular graphs with period lattices $\Lambda_D,\Lambda_H\cong\mathbb Z^3$. For $m\ge1$ let $D_m=D/m\Lambda_D$ and $H_m=H/m\Lambda_H$ (finite 4-regular toroidal quotients, possibly with parallel edges for tiny $m$). For a 4-regular (multi)graph $G$ let $\mathrm{EO}(G)$ be the number of orientations with in-degree $2$ at every vertex. The limits $W_c=\lim_m \mathrm{EO}(D_m)^{1/|V(D_m)|}$ and $W_h=\lim_m\mathrm{EO}(H_m)^{1/|V(H_m)|}$ exist and satisfy $W_h\ge W_c\ge 3/2$. Decide whether $W_h=W_c$.
Formalization notes:
* Layer model. Both nets are built from the same puckered bilayers stacked along [111]/c.
  Lateral positions lie on a triangular lattice with basis a₁, a₂ (a₁=(1,0),
  a₂=(1/2,√3/2)) and three registries A,B,C at offsets 0, τ, 2τ, τ=(a₁+a₂)/3.
  Bilayer n has a lower sublayer (s=0) and an upper sublayer (s=1). Each lower atom bonds to the
  three nearest upper atoms of its own bilayer (lateral registry shift ±1), and each upper atom
  bonds vertically to the lower atom of bilayer n+1 directly above it. Cubic (diamond, 3C):
  registries A|B B|C C|A ... (shift +1 in every bilayer). Hexagonal (lonsdaleite, 2H):
  A|B B|A A|B ... (shift +1 in even bilayers, −1 in odd ones).
* Coordinates. An atom is (n, s, u) with u ∈ ℤ² the lateral position minus its registry offset,
  written in the basis a₁, a₂. Then the vertical bond is (n,1,u)–(n+1,0,u), and the three intra
  bonds are (n,0,u)–(n,1,u+δ) with δ ∈ {0, −e₁, −e₂} for registry shift +1 (since τ, τ−a₁, τ−a₂
  are the three nearest-neighbour vectors) and δ ∈ {0, e₁, e₂} for shift −1.
  In these coordinates the translation lattice is ℤ² (lateral) × ℤ·(1 bilayer) for diamond
  (2 atoms per cell = primitive FCC cell) and ℤ² × ℤ·(2 bilayers) for lonsdaleite (4 atoms per
  primitive cell). Since mΛ does not depend on the chosen basis of Λ, the torus with
  ZMod m × ZMod m lateral and ZMod m bilayers is exactly D/mΛ_D (2m³ vertices), and with
  ZMod (2m) bilayers it is exactly H/mΛ_H (4m³ vertices). We index by m+1 to avoid m = 0.
* Edges are explicit indices (n, u, k), k : Fin 4 (k = 0,1,2 intra bonds out of (n,0,u),
  k = 3 the vertical bond out of (n,1,u)); so the quotient is treated as a multigraph
  (parallel edges only occur for m = 1; irrelevant for the limit). No loops occur (every edge
  joins s=0 to s=1). An orientation is o : Edge → Bool (true = tail→head); in-degree of v
  counts edges with (o = true ∧ head = v) or (o = false ∧ tail = v). EO counts orientations with
  in-degree 2 everywhere (ice rule). Counting uses `Set.ncard` of a finite set of functions.
* Claim: both sequences EO(D_m)^{1/|V|} and EO(H_m)^{1/|V|} converge to the same real number,
  i.e. W_c = W_h. Since existence of both limits is standard, ¬Claim amounts to W_h ≠ W_c
  (by Onsager, W_h > W_c). (A proof that one limit fails to exist would also give ¬Claim, but
  that would itself be a substantial and surprising result, not a loophole.)
-/
namespace OpenProblems.QEDE193
noncomputable section
open Filter Topology

/-- Edge indices on a torus with `N` bilayers and an `m × m` lateral torus. -/
abbrev Edge (N m : ℕ) : Type := ZMod N × (ZMod m × ZMod m) × Fin 4

/-- Vertices: (bilayer, sublayer 0 = lower / 1 = upper, lateral coordinate). -/
abbrev Vert (N m : ℕ) : Type := ZMod N × Fin 2 × (ZMod m × ZMod m)

/-- Lateral offset of intra-bilayer bond `k` (k = 0,1,2); `flip = false` for registry
shift +1 (offsets 0, −e₁, −e₂), `flip = true` for shift −1 (offsets 0, e₁, e₂). -/
def offset (m : ℕ) (flip : Bool) (k : Fin 4) : ZMod m × ZMod m :=
  if k = 1 then (if flip then ((1 : ZMod m), (0 : ZMod m)) else ((-1 : ZMod m), (0 : ZMod m)))
  else if k = 2 then (if flip then ((0 : ZMod m), (1 : ZMod m)) else ((0 : ZMod m), (-1 : ZMod m)))
  else ((0 : ZMod m), (0 : ZMod m))

/-- Tail of an edge. -/
def tail {N m : ℕ} (e : Edge N m) : Vert N m :=
  if e.2.2 = 3 then (e.1, (1 : Fin 2), e.2.1) else (e.1, (0 : Fin 2), e.2.1)

/-- Head of an edge; `flipAt n` says whether bilayer `n` has registry shift −1. -/
def head {N m : ℕ} (flipAt : ZMod N → Bool) (e : Edge N m) : Vert N m :=
  if e.2.2 = 3 then (e.1 + 1, (0 : Fin 2), e.2.1)
  else (e.1, (1 : Fin 2), e.2.1 + offset m (flipAt e.1) e.2.2)

/-- In-degree of `v` under orientation `o` (`o e = true` means `e` points tail → head). -/
def indeg {N m : ℕ} (flipAt : ZMod N → Bool) (o : Edge N m → Bool) (v : Vert N m) : ℕ :=
  {e : Edge N m | (o e = true ∧ head flipAt e = v) ∨ (o e = false ∧ tail e = v)}.ncard

/-- Number of ice-rule (Eulerian, in-degree 2 everywhere) orientations. -/
def EO (N m : ℕ) (flipAt : ZMod N → Bool) : ℕ :=
  {o : Edge N m → Bool | ∀ v : Vert N m, indeg flipAt o v = 2}.ncard

/-- Diamond (cubic, ABC stacking): every bilayer has shift +1. -/
def cubicFlip (N : ℕ) : ZMod N → Bool := fun _ => false

/-- Lonsdaleite (hexagonal, AB stacking): odd bilayers have shift −1 (N is even below). -/
def hexFlip (N : ℕ) : ZMod N → Bool := fun n => decide (n.val % 2 = 1)

/-- `EO(D_{m+1})^{1/|V(D_{m+1})|}`, |V| = 2(m+1)³. -/
def cubicSeq (m : ℕ) : ℝ :=
  ((EO (m + 1) (m + 1) (cubicFlip (m + 1)) : ℕ) : ℝ) ^ ((1 : ℝ) / (2 * ((m : ℝ) + 1) ^ 3))

/-- `EO(H_{m+1})^{1/|V(H_{m+1})|}`, |V| = 4(m+1)³. -/
def hexSeq (m : ℕ) : ℝ :=
  ((EO (2 * (m + 1)) (m + 1) (hexFlip (2 * (m + 1))) : ℕ) : ℝ) ^
    ((1 : ℝ) / (4 * ((m : ℝ) + 1) ^ 3))

/-- Cubic and hexagonal ice have the same residual entropy: W_c = W_h. -/
def Claim : Prop :=
  ∃ w : ℝ, Tendsto cubicSeq atTop (𝓝 w) ∧ Tendsto hexSeq atTop (𝓝 w)

end
end OpenProblems.QEDE193
