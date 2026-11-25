import itertools, sys
from fractions import Fraction
from functools import lru_cache
def comps(t,n):
    if n==1: yield (t,); return
    for i in range(t+1):
        for c in comps(t-i,n-1): yield (i,)+c
def H(n,t):
    rows=list(comps(t,n))
    st={tuple([0]*n):1}
    for r in range(n):
        ns={}
        for s,v in st.items():
            for c in rows:
                s2=tuple(a+b for a,b in zip(s,c))
                if max(s2)<=t: ns[s2]=ns.get(s2,0)+v
        st=ns
    return st.get(tuple([t]*n),0)
def interp(xs,ys):
    # Lagrange -> coefficients
    m=len(xs); coef=[Fraction(0)]*m
    for i in range(m):
        p=[Fraction(1)]; den=Fraction(1)
        for j in range(m):
            if j==i: continue
            p=[Fraction(0)]+p
            for k in range(len(p)-1): p[k]-=xs[j]*p[k+1]
            den*=xs[i]-xs[j]
        for k in range(m): coef[k]+=ys[i]*p[k]/den
    return coef
n=int(sys.argv[1]); d=(n-1)**2
ys=[H(n,t) for t in range(d+1)]
c=interp(list(range(d+1)),ys)
print([float(x) for x in c]); print(all(x>0 for x in c))
