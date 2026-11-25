import Mathlib
/-! N-651: Three identical vortices on a square torus are chaotic
STATUS: NOT YET FORMALIZED
For point vortices on a flat torus with nonzero total circulation, only N = 2 is integrable;
numerics (Borisov-Mamaev-Kilin) indicate three identical vortices are chaotic. Prove that three
identical point vortices on the square torus form a non-integrable Hamiltonian system.
Informal statement: Let G be the Green function of 𝕋 = ℂ/(ℤ + iℤ) (ΔG = δ₀ − 1) and
H = −Σ_{i<j} G(z_i − z_j) on {(z_1,…,z_N) ∈ 𝕋^N : z_i ≠ z_j} with symplectic form Σ dx_i ∧ dy_i.
The centre Z = Σ z_i ∈ 𝕋 is conserved; the reduced space M_N = {Z = Z_0}/((1/N)ℤ[i]/ℤ[i]) is
symplectic of dimension 2N − 2. Prove that for N = 3 the reduced flow on M_3 has no real-analytic
first integral functionally independent of H. (N = 4 is a secondary target.)
Formalization notes: Not formalized. Needed: the periodic Green function of the square torus
(via Jacobi theta functions or the Weierstrass sigma function plus a quadratic correction, or a
conditionally convergent lattice sum), which Mathlib does not provide with the required
properties (Mathlib's Jacobi theta exists but the identification ΔG = δ₀ − 1, normalisation and
real-analyticity off the diagonal would all have to be built); the symplectic reduction by the
conserved centre and the finite translation group to obtain the 4-dimensional M_3 (Mathlib has
no symplectic manifolds or reductions), or an equivalent formulation in lifted coordinates on
ℂ³ with explicit periodicity and invariance conditions; and real-analytic first integrals with
Poisson brackets on that quotient. An explicit coordinate version (as done for N-622) would be
possible only after G is constructed and verified, which is a substantial development.
Proving `Claim` means non-integrability for N = 3; `¬Claim` means an extra analytic integral
exists.
-/
namespace OpenProblems.N651
def Claim : Prop := sorry
end OpenProblems.N651
