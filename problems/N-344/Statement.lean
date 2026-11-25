import Mathlib
/-! N-344: Hat Ising universality
STATUS: NOT YET FORMALIZED
The ferromagnetic Ising model on the tile-adjacency graph of a hat tiling should have the same
critical exponents as the square-lattice Ising model.
Informal statement: Let G be the planar graph whose vertices are the tiles of a fixed hat tiling
(Smith–Myers–Kaplan–Goodman-Strauss), with edges between tiles sharing a boundary segment. Consider
the ferromagnetic nearest-neighbour Ising model on G with uniform coupling J = 1. Prove that there is
a critical β_c (independent of the tiling in the hull), and that as β → β_c the spontaneous
magnetization, susceptibility and correlation length obey M(β) ≍ (β − β_c)^{1/8},
χ(β) ≍ |β − β_c|^{−7/4}, ξ(β) ≍ |β − β_c|^{−1}.
Formalization notes: Not formalized. Missing pieces: (1) a construction of hat tilings and their
hull (the substitution/metatile system of Smith et al., with a proof that it tiles the plane), and
the tile-adjacency graph; (2) infinite-volume Ising Gibbs states on an infinite graph (plus/free
boundary conditions, thermodynamic limits of finite-volume measures); (3) definitions of the
spontaneous magnetization, susceptibility (sum of truncated correlations, including its finiteness
convention on both sides of β_c) and correlation length (exponential decay rate of correlations,
for β < β_c), and a convention for which side of β_c each asymptotic refers to. Each is hundreds of
lines; a statement on finite boxes alone would not be faithful. Proving Claim means proving existence
of β_c and the three exponent laws; proving ¬Claim means refuting one of them.
-/
namespace OpenProblems.N344

def Claim : Prop := sorry

end OpenProblems.N344
