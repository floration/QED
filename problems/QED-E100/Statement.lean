import Mathlib
/-! QED-E100: Improve H_1 ≤ 12 under EH alone
Assuming the Elliott–Halberstam conjecture, Maynard's sieve gives infinitely many pairs of primes at
distance at most 12 (GEH gives 6). Lower 12 using EH alone.
Informal statement: Let H₁ = liminf_n (p_{n+1} − p_n). Assuming EH (level θ = 1 − ε for every ε > 0,
for the von Mangoldt function only, not GEH), prove H₁ ≤ 10. (The alternative "prove that no
Selberg/Maynard-type sieve weight using EH alone can give H₁ < 12" concerns a class of methods and is
not formalized.)
Formalization notes: ψ(x; q, a) = ∑_{n ≤ x, n ≡ a (q)} Λ(n), ψ(x) = ∑_{n ≤ x} Λ(n). EH: for all ε, A > 0
there is C with ∑_{q ≤ x^{1−ε}} max_{(a,q)=1} |ψ(x;q,a) − ψ(x)/φ(q)| ≤ C x / (log x)^A for x ≥ 2; the
max is encoded by quantifying over every choice function a(q) of residues coprime to q (equivalent).
H₁ ≤ 10 ⇔ infinitely many primes p with another prime in (p, p+10].
Claim is the implication EH → H₁ ≤ 10. Proving `Claim` = deriving H₁ ≤ 10 from EH (unconditionally
proving H₁ ≤ 10 also proves Claim). Proving `¬Claim` would require proving EH and H₁ > 10, i.e. is
not a realistic route. Caution for reviewers: if `EH` were mis-stated so as to be false, Claim would
be vacuous; the statement here is the standard one (θ < 1/2 is Bombieri–Vinogradov).
-/
namespace OpenProblems.QEDE100

/-- ψ(x; q, a). -/
noncomputable def psiAP (x : ℝ) (q a : ℕ) : ℝ :=
  ∑ n ∈ (Finset.Icc 1 ⌊x⌋₊).filter (fun n => n % q = a % q), ArithmeticFunction.vonMangoldt n

/-- ψ(x). -/
noncomputable def psi (x : ℝ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 ⌊x⌋₊, ArithmeticFunction.vonMangoldt n

/-- The Elliott–Halberstam conjecture. -/
def EH : Prop :=
  ∀ ε : ℝ, 0 < ε → ∀ A : ℝ, 0 < A → ∃ C : ℝ, ∀ x : ℝ, 2 ≤ x →
    ∀ a : ℕ → ℕ, (∀ q, Nat.Coprime (a q) q) →
      ∑ q ∈ Finset.Icc 1 ⌊x ^ (1 - ε)⌋₊,
          |psiAP x q (a q) - psi x / (Nat.totient q : ℝ)| ≤ C * x / Real.log x ^ A

def Claim : Prop :=
  EH → ∀ N : ℕ, ∃ p q : ℕ, N < p ∧ p.Prime ∧ q.Prime ∧ p < q ∧ q ≤ p + 10

end OpenProblems.QEDE100
