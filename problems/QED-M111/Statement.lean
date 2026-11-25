import Mathlib
/-! QED-M111: An APN permutation of GF(2^8)
A function f on the field with 256 elements is almost perfect nonlinear (APN) if, for every nonzero shift a, the difference f(x+a)+f(x) takes each value at most twice. APN bijections would be ideal S-boxes against differential attacks. In even dimension the only APN bijections known live on 64 elements (found in 2009). Does an APN bijection of GF(2^8) exist?
Informal statement: Does there exist a bijection $f:\mathbb F_{2^8}\to\mathbb F_{2^8}$ such that for all $a\in\mathbb F_{2^8}^{\times}$ and all $b\in\mathbb F_{2^8}$, $\#\{x\in\mathbb F_{2^8}: f(x+a)+f(x)=b\}\le 2$?
Formalization notes: `𝔽_{2^8}` is Mathlib's `GaloisField 2 8` (the splitting field of
`X^(2^8) - X` over `ZMod 2`, a field with exactly 256 elements, unique up to isomorphism;
`Fact (Nat.Prime 2)` is a global instance). Only its additive group (≅ (ZMod 2)^8) is
actually used, so the choice of model is immaterial. A bijection is an
`Equiv`. The count `#{x | f(x+a) + f(x) = b}` is `Set.ncard` of a subset of a finite
type, hence the true cardinality. In characteristic 2, `+` equals `-`, matching the usual
derivative `f(x+a) - f(x)`. Claim is the existence statement; ¬Claim says no APN
permutation of `GF(2^8)` exists. Either is a resolution.
-/
namespace OpenProblems.QEDM111
noncomputable section

/-- `f` is almost perfect nonlinear on `GF(2^8)`. -/
def IsAPN (f : GaloisField 2 8 → GaloisField 2 8) : Prop :=
  ∀ a : GaloisField 2 8, a ≠ 0 → ∀ b : GaloisField 2 8,
    {x : GaloisField 2 8 | f (x + a) + f x = b}.ncard ≤ 2

def Claim : Prop :=
  ∃ f : GaloisField 2 8 ≃ GaloisField 2 8, IsAPN f

end
end OpenProblems.QEDM111
