import Mathlib
/-! QED-Q7: Erdős–Szekeres monotone subsequences
Any list of rs + 1 distinct real numbers has an increasing run of r + 1 of them or a decreasing run of s + 1 of them (not necessarily consecutive).
Informal statement: For $f:\{0,\dots,rs\}\to\mathbb R$ injective there is a set of $r+1$ indices on which $f$ is strictly increasing, or a set of $s+1$ indices on which it is strictly decreasing.
Formalization notes: Indices are `Fin (r * s + 1)`; subsequences are finite sets of indices with `StrictMonoOn`/`StrictAntiOn`.
This is a submission-system test problem with a known solution; prove `Claim`.
-/
namespace OpenProblems.QEDQ7
def Claim : Prop :=
  ∀ (r s : ℕ) (f : Fin (r * s + 1) → ℝ), Function.Injective f →
    (∃ t : Finset (Fin (r * s + 1)), t.card = r + 1 ∧ StrictMonoOn f (t : Set (Fin (r * s + 1)))) ∨
    (∃ t : Finset (Fin (r * s + 1)), t.card = s + 1 ∧ StrictAntiOn f (t : Set (Fin (r * s + 1))))

end OpenProblems.QEDQ7
