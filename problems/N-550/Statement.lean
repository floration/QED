import Mathlib
/-! N-550: Longest increasing run of prime gaps
Among the first N prime gaps, find the longest subsequence that strictly increases. Show it grows like a power of N and find the power.
Informal statement: Let $L(N)$ be the length of the longest strictly increasing subsequence of $(p_{n+1}-p_n)_{n\le N}$. Prove $L(N)=N^{\theta+o(1)}$ and determine $\theta$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N550
def Claim : Prop := sorry
end OpenProblems.N550
