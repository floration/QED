import Mathlib
/-! N-492: Largest-factor tribonacci
Repeatedly add the largest prime factors of the last three terms. Show the sequence is always eventually periodic.
Informal statement: For $a_{n+3}=P(a_{n+2})+P(a_{n+1})+P(a_n)$, prove eventual periodicity for every start in $\mathbb{N}_{\ge2}^3$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N492
def Claim : Prop := sorry
end OpenProblems.N492
