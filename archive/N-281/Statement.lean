import Mathlib
open Filter Topology
/-! N-281: A mixed Fermat equation
Informal: Prove $x^2+y^4=z^7+7$ has finitely many solutions in integers. -/
namespace OpenProblems.N281

def Claim : Prop :=
  Set.Finite {t : ℤ × ℤ × ℤ | t.1 ^ 2 + t.2.1 ^ 4 = t.2.2 ^ 7 + 7}
end OpenProblems.N281
