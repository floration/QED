import Mathlib
/-! QED-E182: Can 3x3 matrices be multiplied with 22 multiplications over the complex numbers?
Laderman (1976) multiplies two 3x3 matrices with 23 scalar multiplications in a bilinear algorithm, and nobody has beaten 23. Over the two-element field (and hence for integer coefficients) 23 has now been claimed optimal, but over the complex or rational numbers the best lower bound is still 19. Is there a 22-multiplication algorithm with complex coefficients, or is 23 optimal?
Informal statement: Let $T=\langle3,3,3\rangle\in(\mathbb C^9)^{\otimes3}$ be the $3\times3$ matrix multiplication tensor and $R_{\mathbb C}(T)$ its tensor rank; known $19\le R_{\mathbb C}(T)\le23$. Is $R_{\mathbb C}(T)\le22$, i.e. do there exist $A_i,B_i,C_i\in M_3(\mathbb C)$, $i=1,\dots,22$, with $XY=\sum_{i=1}^{22}\operatorname{tr}(A_iX)\operatorname{tr}(B_iY)\,C_i$ for all $X,Y\in M_3(\mathbb C)$? (Partial target: prove $R_{\mathbb C}(T)\ge20$.)
Formalization notes:
* Tensor rank of ⟨3,3,3⟩ over ℂ is the least r such that the bilinear map (X,Y) ↦ XY is a sum
  of r terms f_i(X) g_i(Y) C_i with linear functionals f_i, g_i on M₃(ℂ) and C_i ∈ M₃(ℂ).
  Every linear functional on M₃(ℂ) is X ↦ tr(AX) for a unique A (trace form is
  nondegenerate), so Claim is exactly R_ℂ(⟨3,3,3⟩) ≤ 22 (zero terms are allowed, so "≤").
* Proving Claim = a 22-multiplication bilinear algorithm over ℂ; ¬Claim = R_ℂ(⟨3,3,3⟩) = 23
  (with Laderman's upper bound). The partial target (rank ≥ 20) is not formalized.
-/
namespace OpenProblems.QEDE182
noncomputable section

def Claim : Prop :=
  ∃ A B C : Fin 22 → Matrix (Fin 3) (Fin 3) ℂ,
    ∀ X Y : Matrix (Fin 3) (Fin 3) ℂ,
      X * Y = ∑ i : Fin 22, ((A i * X).trace * (B i * Y).trace) • C i

end
end OpenProblems.QEDE182
