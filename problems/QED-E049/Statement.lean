import Mathlib
/-! QED-E049: Ropelength lower bound for the trefoil
Tie a knot in a rope of thickness 1 using as little rope as possible. For the simplest knot, the trefoil, computer experiments find tight knots using about 16.37 units of rope. The last refereed proof shows that every knotted rope needs at least 15.66 units, and a 2026 computer-assisted preprint claims 15.76. Raise the proven lower bound for the trefoil substantially, ideally to 16.
Informal statement: For a $C^{1,1}$ simple closed curve $\gamma\subset\mathbb R^3$ let $\mathrm{Rop}(\gamma)=\mathrm{length}(\gamma)/(2\,\mathrm{reach}(\gamma))$ (length over tube diameter), and $R(3_1)=\inf\{\mathrm{Rop}(\gamma):\gamma\text{ a trefoil}\}$ (attained). Known: $15.66\le R(3_1)\lesssim16.372$ (refereed lower bound; numerical upper value), with an unrefereed claim $R(K)>15.7561$ for all nontrivial $K$. Improve the lower bound for $R(3_1)$ beyond $15.7561$ with a verifiable proof, ideally to $R(3_1)\ge16$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E049`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE049
def Claim : Prop := sorry
end OpenProblems.QEDE049
