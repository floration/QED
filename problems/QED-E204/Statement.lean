import Mathlib
/-! QED-E204: Solve x^2 + y^5 = z^7, the smallest open generalized Fermat equation
Equations x^p + y^q = z^r with 1/p+1/q+1/r < 1 are expected to have only finitely many solutions in coprime integers, and many individual exponent triples have been solved. A 2024 survey identifies (2,5,7) as the unsolved triple with the smallest exponent sum. Show that x^2 + y^5 = z^7 has no solution in nonzero coprime integers.
Informal statement: Prove that there are no $x,y,z\in\mathbb Z$ with $xyz\neq0$, $\gcd(x,y,z)=1$ and $x^2+y^5=z^7$. (Since 5 and 7 are odd and signs are allowed, this covers every arrangement of the exponents, e.g. $x^5+y^7=z^2$.)
Formalization notes: Integers ℤ; gcd(x,y,z) = 1 is written as `Int.gcd (Int.gcd x y) z = 1` (the inner gcd is
a natural number, cast back to ℤ). For a solution of x²+y⁵=z⁷ this is equivalent to pairwise coprimality.
The gcd condition is essential: non-primitive solutions exist, e.g. (2^10, 2^4, 2^3). Claim true means no
primitive nontrivial solution exists; ¬Claim exhibits one.
-/
namespace OpenProblems.QEDE204
noncomputable section

def Claim : Prop :=
  ∀ x y z : ℤ, x ≠ 0 → y ≠ 0 → z ≠ 0 → Int.gcd ((Int.gcd x y : ℕ) : ℤ) z = 1 →
    x ^ 2 + y ^ 5 ≠ z ^ 7

end
end OpenProblems.QEDE204
