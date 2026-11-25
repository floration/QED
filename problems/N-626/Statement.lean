import Mathlib
/-! N-626: Maximal eigenfunction growth beyond surfaces of revolution
STATUS: NOT YET FORMALIZED
Sogge and Zelditch proved that a real-analytic surface with maximally peaked eigenfunctions must have
a pole (a point from which all geodesics return smoothly closed). Must such a surface in fact be a
surface of revolution?
Informal statement: Let (M,g) be a compact boundaryless real-analytic Riemannian surface with
Δ_g e_j = −λ_j² e_j, ‖e_j‖_{L²} = 1. Say g has maximal eigenfunction growth if
limsup_j ‖e_j‖_{L^∞} / λ_j^{1/2} > 0 for some orthonormal eigenbasis. Decide whether every such (M,g)
admits a nontrivial isometric S¹-action, i.e. is a surface of revolution.
Formalization notes: Not formalized. Missing pieces: (1) real-analytic Riemannian metrics on compact
2-manifolds (Mathlib has smooth manifolds and some Riemannian-metric infrastructure, but not
real-analytic structures in usable form); (2) the Laplace–Beltrami operator, its L² spectral theory
on a compact manifold (discrete spectrum, orthonormal eigenbases), and the Riemannian volume measure;
(3) isometric S¹-actions (continuous homomorphisms from the circle to the isometry group, nontrivial).
Building (2) alone is hundreds of lines. Proving Claim means every real-analytic surface with maximal
growth is a surface of revolution; proving ¬Claim means a real-analytic non-rotational surface with
maximal growth.
-/
namespace OpenProblems.N626

def Claim : Prop := sorry

end OpenProblems.N626
