import Mathlib
/-! QED-M143: Hats on a flat torus: how much must be left uncovered?
The hat tile can cover the plane, but never in a repeating pattern, so copies of the hat can never exactly cover a flat torus (a doughnut-shaped surface that is flat, like a video-game screen that wraps around). Packing hats on a torus of area A always leaves some area uncovered. Show that the least uncovered area grows without bound as A grows, and find how fast it grows. Cutting a square out of a hat tiling shows it is at most a constant times the square root of A.
Informal statement: Let $H$ be the hat polykite (area normalised to $1$); copies may be rotated and reflected. For a lattice $\Lambda\subset\mathbb R^2$ of covolume $A$, a packing of $T_\Lambda=\mathbb R^2/\Lambda$ is a finite family of isometric copies of $H$ in $T_\Lambda$ with disjoint interiors (each copy embedded). Let $g(A)=\inf_{\Lambda:\,\mathrm{covol}(\Lambda)=A}\ \inf_{\text{packings}}\ \big(A-\#\text{copies}\big)$. Trivially $g(A)=O(\sqrt A)$. (i) Prove $g(A)\to\infty$ as $A\to\infty$. (ii) Determine the order of growth of $g$; in particular, is $g(A)\asymp\sqrt A$?
Formalization notes:
* Hat: the 8-kite union in hex coordinates `(a,b) ↦ a + b/2 + i(√3/2) b` (same encoding as QED-E096), of area
  `8√3` (each kite has area √3). Instead of normalising the area to 1 we keep this hat and measure the uncovered
  area as `A − N · 8√3`. Rescaling the plane by `(8√3)^{−1/2}` shows `g_here(A) = 8√3 · g(A / (8√3))`, so (i) and
  the order of growth in (ii) are unchanged.
* Lattice Λ = ℤu + ℤv with `u, v ∈ ℂ`, covolume `|Re u · Im v − Im u · Re v|` (> 0 iff u, v independent).
* Packing of the torus by N hats ⇔ Λ-periodic packing of the plane with N orbits: isometries `g₀, …, g_{N−1}` of ℂ
  (reflections allowed) such that the translates `gᵢ(H) + m u + n v` (i < N, m, n ∈ ℤ) have pairwise disjoint
  interiors for distinct indices `(i, m, n)`. Disjointness of `gᵢ(H)` from its own nonzero Λ-translates is exactly
  "each copy is embedded in the torus"; disjointness across different i is the packing condition. The copies on
  the torus are the images of the gᵢ(H), so #copies = N and the uncovered area is `A − 8√3 · N`.
* `Claim` = part (i): for every M there is A₀ such that every packing of every torus of covolume ≥ A₀ leaves
  uncovered area > M, i.e. g(A) → ∞. (Degenerate lattices have covolume 0 and are excluded once A₀ > 0.)
  `¬Claim` = bounded defect along a sequence of tori with covolume → ∞. Part (ii)'s √A lower bound is recorded as
  `SqrtDefect`, not part of `Claim` (the O(√A) upper bound is the known trivial bound).
-/
namespace OpenProblems.QEDM143
noncomputable section

/-- Hex-grid point `(a, b) ↦ a + b/2 + i·(√3/2)·b`. -/
def hexPt (a b : ℤ) : ℂ := ⟨(a : ℝ) + (b : ℝ) / 2, Real.sqrt 3 / 2 * (b : ℝ)⟩

/-- A kite with the given four grid vertices. -/
def kite (p q r s : ℤ × ℤ) : Set ℂ :=
  convexHull ℝ {hexPt p.1 p.2, hexPt q.1 q.2, hexPt r.1 r.2, hexPt s.1 s.2}

/-- The hat monotile, as a union of 8 kites. -/
def hat : Set ℂ :=
  kite (0, 0) (2, -1) (2, 0) (1, 1) ∪ kite (0, 0) (1, 1) (0, 2) (-1, 2) ∪
  kite (0, 0) (-1, -1) (0, -2) (1, -2) ∪ kite (0, 0) (1, -2) (2, -2) (2, -1) ∪
  kite (4, -2) (5, -1) (4, 0) (3, 0) ∪ kite (4, -2) (3, 0) (2, 0) (2, -1) ∪
  kite (2, 2) (0, 3) (0, 2) (1, 1) ∪ kite (2, 2) (1, 1) (2, 0) (3, 0)

/-- Area of the hat. -/
def hatArea : ℝ := 8 * Real.sqrt 3

/-- Covolume of the lattice `ℤu + ℤv`. -/
def covol (u v : ℂ) : ℝ := |u.re * v.im - u.im * v.re|

/-- Translate of a set by the lattice vector `m u + n v`. -/
def ltrans (u v : ℂ) (m n : ℤ) (X : Set ℂ) : Set ℂ :=
  (fun z : ℂ => z + ((m : ℂ) * u + (n : ℂ) * v)) '' X

/-- `N` hats `g i '' hat` form a packing of the torus `ℂ / (ℤu + ℤv)`. -/
def IsTorusPacking (u v : ℂ) (N : ℕ) (g : Fin N → (ℂ ≃ᵢ ℂ)) : Prop :=
  ∀ i j : Fin N, ∀ m n m' n' : ℤ, (i, m, n) ≠ (j, m', n') →
    Disjoint (interior (ltrans u v m n (g i '' hat))) (interior (ltrans u v m' n' (g j '' hat)))

/-- Uncovered area of a packing of `N` hats on a torus with periods `u, v`. -/
def defect (u v : ℂ) (N : ℕ) : ℝ := covol u v - (N : ℝ) * hatArea

/-- Part (ii) lower bound, not part of `Claim`: `g(A) ≥ c √A` for large `A`. -/
def SqrtDefect : Prop :=
  ∃ c : ℝ, 0 < c ∧ ∃ A₀ : ℝ, ∀ u v : ℂ, A₀ ≤ covol u v →
    ∀ (N : ℕ) (g : Fin N → (ℂ ≃ᵢ ℂ)), IsTorusPacking u v N g →
      c * Real.sqrt (covol u v) ≤ defect u v N

/-- Part (i): the least uncovered area tends to infinity with the area of the torus. -/
def Claim : Prop :=
  ∀ M : ℝ, ∃ A₀ : ℝ, ∀ u v : ℂ, A₀ ≤ covol u v →
    ∀ (N : ℕ) (g : Fin N → (ℂ ≃ᵢ ℂ)), IsTorusPacking u v N g → M < defect u v N

end
end OpenProblems.QEDM143
