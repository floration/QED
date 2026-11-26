> Partial-work submission. The mathematical argument below is complete on paper. The accompanying Lean file formalizes supporting lemmas, and the full claim still awaits formal verification.

# QED-E019 — Volume density for period-doubling torus bundles

This is a mathematical proof of both parts of the [official Lean statement](https://github.com/floration/QED/blob/main/problems/QED-E019/Statement.lean). The proof uses the angle-volume formula as defined in that statement.

## A uniformly strict angle structure

Use cyclic indices, and call index \(i\) a hinge when letters \(i\) and \(i+1\) differ. Consider any cyclic word with no cyclic occurrence of \(bb\) or \(aaaa\). Every non-hinge is an \(aa\) pair, and at least one of its two adjacent indices must be a hinge.

Set \(u_i=1/2\) at hinges and \(u_i=3/4\) at non-hinges. At a hinge the two angles \(u_i\pm(u_{i-1}-u_{i+1})\) are at least \(1/4\). At a non-hinge, \(u_{i-1}+u_{i+1}\ge1\) and \(2u_i-u_{i-1}-u_{i+1}\ge1/4\), since at least one neighbor has value \(1/2\). The remaining angle is at least \(\pi-3/2\). Thus every positivity constraint in the definition of an angle structure has margin at least \(1/4\).

The word \(W_1=ab\) has this cyclic avoidance property. Every substituted pair starts with \(a\), so the image has no \(bb\). Any four consecutive cyclic letters in the image include the second letters of two consecutive substituted pairs. If all four letters were \(a\), those two pairs would both be \(aa\), so their parents would be consecutive \(b\)'s. Induction proves the avoidance property for all \(W_n\) with \(n\ge1\). The same holds for \(W_nW_n\), because repeating a cyclic pattern adds no new cyclic windows. In particular, the angle structures required by the first part of the claim exist.

## Volume on a doubled word

Write \(F(U)\) for the supremum of the volume functional of a cyclic word \(U\). All angle triples in the feasible region are positive and sum to \(\pi\). The Lobachevsky function \(\Lambda\) is continuous on \([0,\pi]\) since the endpoint logarithmic singularities are integrable. The tetrahedron volume \(V(x,y,z)=\Lambda(x)+\Lambda(y)+\Lambda(z)\) is therefore bounded in absolute value by some \(M\) on the closed angle simplex.

On the open simplex, with \(z=\pi-x-y\), the Hessian of \(V\) in coordinates \((x,y)\) is
\[
-\begin{pmatrix}
\cot x+\cot z & \cot z\\
\cot z & \cot y+\cot z
\end{pmatrix}.
\]
Its first diagonal entry is negative since \(\cot x+\cot z=\sin y/(\sin x\sin z)>0\). Its determinant is \(\cot x\cot y+\cot x\cot z+\cot y\cot z=1\), by the angle-sum identity. This proves concavity.

Repeating any feasible vector from \(U\) on \(UU\) doubles its volume. Conversely, for a feasible vector on \(UU\), average the weights at indices that differ by \(|U|\). The angle formulas are affine and agree at the paired indices. The averaged vector descends to a feasible vector on \(U\), and concavity gives it volume at least half of the original volume. Taking suprema in both directions gives \(F(UU)=2F(U)\).

## Changing one letter

Let \(U,U'\) be two cyclic words of the same length \(m\ge4\) that differ at one index \(j\) and satisfy the avoidance property above. Their hinge tests can differ only at \(j-1,j\). Let \(B\) be the union of these two indices and their immediate neighbors, so \(|B|\le4\). For \(0<\delta<1\), with \(d(i,B)\) denoting cyclic graph distance, put
\[
t_i=\min(1-\delta,\,\delta d(i,B)/16).
\]
Take any feasible vector \(w\) on \(U\), let \(u\) be the strict angle structure on \(U'\) constructed above, and set \(w'_i=t_iw_i+(1-t_i)u_i\).

At \(j-1,j\), all three weights entering the angle formulas come from \(u\). At every other index \(i\), first compare to the angle triple obtained by using the same coefficient \(t_i\) at all three positions. Since the hinge tests agree, this is a convex combination of the angle triples of \(w\) and \(u\). It has margin at least \(\delta/4\). The actual middle weight stays the same. Each neighbor weight differs by at most \((\pi/2)\delta/16\), since all weights lie in \((0,\pi/2)\) and \(|t_{i\pm1}-t_i|\le\delta/16\). The neighbor coefficients in each angle have absolute value at most one, so the perturbation in each angle is at most \(\pi\delta/16<\delta/4\). The individual weights also remain positive. Hence \(w'\) is feasible on \(U'\).

Let \(R=1+\lceil16/\delta\rceil\). At every index with \(d(i,B)\ge R\), the three mixing coefficients all equal \(1-\delta\). By concavity, the volume at such an index is at least its old value minus \(2M\delta\). There are at most \(4(2R+1)\) remaining indices, since the cyclic ball of radius \(R\) about any point has size at most \(2R+1\). At each remaining index the loss is at most \(2M\). This construction is uniform in \(w\). Taking suprema and then exchanging the roles of the two words gives
\[
|F(U')-F(U)|\le 2M\delta m+8M(2R+1).
\]
In particular, \(\delta=m^{-1/2}\) gives \(|F(U')-F(U)|\le C\sqrt m\) for an absolute constant \(C\).

## Convergence

Let \(V_n=\sigma^n(b)\), where \(\sigma(a)=ab\), \(\sigma(b)=aa\). Then \(W_{n+1}=W_nV_n\) and \(V_{n+1}=W_nW_n\). Starting with \(W_0=a\), \(V_0=b\), induction shows that \(W_n,V_n\) differ only at their last letter. Thus \(W_{n+1}\) differs from \(W_nW_n\) at one letter, and the bound above applies with \(m=2^{n+1}\). Using the exact doubling identity,
\[
\left|\frac{F(W_{n+1})}{2^{n+1}}-\frac{F(W_n)}{2^n}\right|
\le C\,2^{-(n+1)/2}
\qquad(n\ge1).
\]
The right side is summable. The sequence is Cauchy and converges in \(\mathbb R\), proving the second part of the claim.
