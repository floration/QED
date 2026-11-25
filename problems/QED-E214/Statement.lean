import Mathlib
/-! QED-E214: Cyclic perfect difference sets exist only for prime-power orders
A perfect (planar) difference set of order n is a set of n+1 residues modulo n^2+n+1 such that every nonzero
residue is the difference of exactly one ordered pair of its elements. Singer showed that one exists whenever n is
a prime power, and each one gives a projective plane of order n with a cyclic symmetry. Prove that if such a set
exists then n is a prime power.
Informal statement: Let $n\ge2$. Suppose $D\subseteq\mathbb{Z}/(n^2+n+1)\mathbb{Z}$ has $|D|=n+1$ and that for
every $x\neq0$ there is exactly one pair $(a,b)\in D\times D$ with $a-b=x$. Prove that $n$ is a prime power.
Formalization notes: D is a Finset of ZMod (n²+n+1); the difference condition counts ordered pairs in D ×ˢ D with
p.1 − p.2 = x and requires exactly one for each nonzero residue x. "Prime power" is Mathlib's `IsPrimePow`
(p^k with p prime, k ≥ 1). `Claim` = the prime power conjecture for cyclic planar difference sets;
`¬Claim` = a perfect difference set of some non-prime-power order n ≥ 2 exists.
-/
namespace OpenProblems.QEDE214

noncomputable section

open Classical

/-- D is a planar (perfect) difference set of order n in ℤ/(n²+n+1). -/
def IsPerfectDiffSet (n : ℕ) (D : Finset (ZMod (n ^ 2 + n + 1))) : Prop :=
  D.card = n + 1 ∧
    ∀ x : ZMod (n ^ 2 + n + 1), x ≠ 0 →
      ((D ×ˢ D).filter (fun p : ZMod (n ^ 2 + n + 1) × ZMod (n ^ 2 + n + 1) => p.1 - p.2 = x)).card = 1

def Claim : Prop :=
  ∀ n : ℕ, 2 ≤ n → ∀ D : Finset (ZMod (n ^ 2 + n + 1)), IsPerfectDiffSet n D → IsPrimePow n

end

end OpenProblems.QEDE214
