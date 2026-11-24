import json
d=json.load(open('/home/claude/rate/a750_3.json'))
R=[
(5.4,'ok','Collatz-like; growth via Sophie Germain chains unbounded locally; cycle verified, no proof route.'),
(5.3,'ok','Collatz-like 3p/2 growth on primes; no contraction argument; cycle (3,5,8) verified.'),
(0.5,'easy','From prime p>=7, (p+p\')/2 is composite between consecutive primes so P(p+p\')<=(p+p\')/4<p; strictly decreasing.'),
(4.8,'ok','Spiegelhofer proved s2=s3 collisions for integers (2021); prime version needs joint two-base Mauduit-Rivat, open.'),
(0.3,'false','x_18=x_19=0 (computed), so sequence is identically zero afterward; limit is -infinity.'),
(4.0,'ok','Needs Gallagher method with Maynard missing-digit primes; plausible but nontrivial; existing list has related seven-free items.'),
(4.0,'ok','F not 3-partite (forces 1,2 same part), so pi(F)>0; specific Turan density likely open, flag-algebra territory.'),
(0.8,'easy','Only ~sqrt(n) allowed distances; Delsarte s-distance bound gives |C|<=sum_{i<=sqrt n}C(n,i)=2^{o(n)}, limit 0.'),
(5.0,'famous-equiv','If finitely many twin primes, move set finite so P-positions periodic with positive density; density 0 implies twin primes infinite.'),
(7.0,'ok','Undecidability-type question on prime-factor dynamics; minor issue P(0),P(1) undefined when f(n) in {0,+-1}.'),
(6.0,'ok','chi(S_N) itself unknown; proof-complexity lower bound for structured number-theoretic graph, hard but well-posed.'),
(3.0,'ok','Kneser upper bound N-2k+2 trivial; lower bound via alternation number/topological method likely tractable.'),
(3.6,'ok','Upper O(N^{3/2}) trivial; S_N has ~N^2 log N C4s; Sidon subsets of squares give C4-free subgraphs; gap real.'),
(4.0,'ok','Base Hamiltonian path problem treated as known; AP-avoidance constraint adds genuine difficulty.'),
(0.5,'easy','Apply Hindman directly to colouring d(n)=c(P(n)); monochromatic IP set gives the claim.'),
(3.0,'ill-posed','Computation: doubling changes almost nothing (only 155 below 200); "characterise" reduces to unstructured Prime Nim P-positions.'),
(4.5,'duplicate','Special case of existing "Sofa for every angle" and overlaps "Obtuse sofa" (120 degree corridor).'),
(3.5,'ok','Centres in finite-rank Z-module; distinct squared distances count via quadratic form values; doable but messy.'),
(6.5,'ok','Open-ended construction; isospectrality via transplantation unlikely to fit aperiodic monotiles; very hard either way.'),
(6.5,'famous-equiv','Prime digits <=A imply Zaremba with constant A; also prime-alphabet dimension ~0.67 <5/6, beyond Bourgain-Kontorovich/Huang.'),
(5.0,'ok','Minimal dissection lower bounds are notoriously hard to prove; well-defined but likely intractable to certify.'),
(8.0,'duplicate','p_c part duplicates existing "Percolation on the hat tiling"; Cardy for non-triangular lattice is famous universality problem.'),
(3.8,'ok','Expected alpha=1/2 via expander UST results (Michaeli-Nachmias-Shalev); needs spectral gap of S_N, itself in existing list.'),
(0.5,'ill-posed','n+-P(n) is divisible by P(n), so walk never reaches 1 (and hits 0 where P undefined); "chain above" undefined.'),
(2.5,'known','Yadin-Yehudayoff (2011) give LERW->SLE2 on planar graphs once RW converges to BM; ergodic invariance principle covers spectre.'),
(6.0,'ok','Recurrence needs control of P(2p+-1) distribution, like Elliott-Halberstam-level input; simulations hit 5 often.'),
(5.6,'ok','Collatz-like; twin-prime-like pairs n,n+3 make orbits grow; cycles verified to 20000.'),
(5.6,'ok','Collatz-like; four fates verified to 20000; no contraction mechanism.'),
(1.0,'known','Degree-2 field extension is Galois; Campbell (1973): Keller maps with Galois extension are invertible. Also duplicates "Two-to-one Keller maps".'),
(4.5,'duplicate','Same as existing "Unbounded Prime Nim".'),
(5.5,'duplicate','Same as existing "Seven-free Carmichael numbers".'),
(3.5,'ok','Heuristically exceptional set infinite (reps r(n) small vs 0.81^digits); proving it still needs constructing explicit families.'),
(3.0,'ok','Easy if S_N is K_{t,t}-free (bounded tww + K_tt-free => bounded degeneracy), but K_{t,t} in squares is open.'),
(6.0,'ok','n/sqrt(log n) is trivial edge-count upper bound; random heuristic gives n/log n, so claimed lower bound likely false/very hard.'),
]
assert len(R)==len(d)
out=[{'title':p['title'],'r':r,'flag':f,'why':w} for p,(r,f,w) in zip(d,R)]
json.dump(out,open('/home/claude/rate/aout_3.json','w'),indent=1)
from collections import Counter
print(Counter(f for _,f,_ in R), round(sum(r for r,_,_ in R)/len(R),2))
