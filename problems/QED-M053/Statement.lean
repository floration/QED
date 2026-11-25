import Mathlib
/-! QED-M053: Positive metric entropy for the x^4+y^4 billiard
STATUS: NOT YET FORMALIZED
The billiard table x⁴ + y⁴ ≤ 1 is analytic and convex, with curvature vanishing at four points,
so it has no caustics (Mather). Its phase space mixes elliptic islands with apparently chaotic
regions. Prove that the chaos has positive measure: positive Kolmogorov-Sinai entropy.
Informal statement: Let Φ be the billiard map of Ω = {x⁴ + y⁴ ≤ 1}, preserving the Liouville
measure ν = sin θ ds dθ. Prove that h_ν(Φ) > 0; equivalently, by Pesin's formula, that Φ has a
nonzero Lyapunov exponent on a set of positive ν-measure.
Formalization notes: Not formalized. A faithful statement needs: the billiard map on the
phase space (arc-length s on ∂Ω, angle θ ∈ (0,π)), i.e. the next-collision map defined via the
second intersection of a chord with the quartic curve, with a proof it is a C^ω diffeomorphism
of the open annulus; the invariant measure ν; and either Kolmogorov-Sinai metric entropy
(absent from Mathlib) or Lyapunov exponents via Oseledets/Pesin (also absent). A Lyapunov
formulation could be written by hand (ν{x : limsup (1/n) log ‖DΦⁿ(x)‖ > 0} > 0) once Φ is
defined, and this is equivalent to h_ν > 0 by Pesin's formula plus Ruelle's inequality for C²
area-preserving maps; but constructing Φ and its derivative with arc-length coordinates on the
quartic curve is a substantial (hundreds of lines) development. Proving `Claim` means positive
metric entropy; `¬Claim` means all Lyapunov exponents vanish ν-a.e.
-/
namespace OpenProblems.QEDM053
def Claim : Prop := sorry
end OpenProblems.QEDM053
