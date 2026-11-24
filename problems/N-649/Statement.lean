import Mathlib
/-! N-649: Paley spin glass
Spins on F_p interact through Legendre symbols of their differences. The spectral bound caps the ground-state energy at one half times p^{3/2}, and local search gets to about 0.46. Is the bound sharp?
Informal statement: For primes $p\equiv1\pmod4$ let $E_p=\max_{\sigma\in\{\pm1\}^{\mathbb F_p}}\sum_{i<j}\left(\frac{j-i}{p}\right)\sigma_i\sigma_j\le\frac12p^{3/2}$. Decide whether $E_p/p^{3/2}\to\frac12$. (Greedy local search from 30 random starts gave ratios $0.461,0.461,0.461,0.456$ for $p=101,197,401,797$.)
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N649
def Claim : Prop := sorry
end OpenProblems.N649
