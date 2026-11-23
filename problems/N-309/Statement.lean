import Mathlib
/-! N-309: Random digit deletion
Repeatedly delete a random decimal digit of a number until it is prime or has one digit. Find the probability of ending at a prime from a typical large start.
Informal statement: For uniform $n\le x$ and random single-digit deletions, prove $\Pr(\text{the process meets a prime})\to c$ and determine whether $c<1$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N309
def Claim : Prop := sorry
end OpenProblems.N309
