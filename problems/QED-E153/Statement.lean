import Mathlib
/-! QED-E153: Area of the boundary of the Mandelbrot set
The Mandelbrot set M is the set of complex numbers c for which the orbit of 0 under z -> z^2 + c stays bounded. Its boundary is a fractal of Hausdorff dimension 2, as large as possible for a plane set. Does the boundary of M have zero area?
Informal statement: Let $M=\{c\in\mathbb C:\sup_n|f_c^{n}(0)|<\infty\}$ with $f_c(z)=z^2+c$. Decide whether the two-dimensional Lebesgue measure of $\partial M$ is $0$.
Formalization notes:
* `mandelbrot` = {c : ℂ | the sequence ‖f_c^[n] 0‖ (n : ℕ) is bounded above}, with
  `f_c z = z^2 + c` and `^[n]` the n-fold iterate (`Nat.iterate`).
* `frontier` is the topological boundary in ℂ.
* `MeasureTheory.volume` on ℂ is Mathlib's standard measure, which corresponds to Lebesgue
  measure on ℝ² under the real/imaginary-part identification (`Complex.measurableEquivRealProd`
  is measure preserving), so this is two-dimensional Lebesgue measure.
* Claim = the boundary has zero area; ¬Claim = it has positive area (∂M is compact, so its
  measure is finite and the dichotomy is exactly 0 vs positive).
-/
namespace OpenProblems.QEDE153
noncomputable section

def mandelbrot : Set ℂ :=
  {c : ℂ | BddAbove (Set.range (fun n : ℕ => ‖(fun z : ℂ => z ^ 2 + c)^[n] 0‖))}

def Claim : Prop :=
  MeasureTheory.volume (frontier mandelbrot) = 0

end
end OpenProblems.QEDE153
