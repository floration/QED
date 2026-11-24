import numpy as np
from sympy import primerange
pr=np.array(list(primerange(2,20000)),float)
m=20
# Chebyshev nodes on [0,0.5]
k=np.arange(m); t=np.cos(np.pi*(k+0.5)/m); xs=0.25+0.25*t
def interp_matrix(ys):
    # Lagrange basis on xs evaluated at ys
    M=np.ones((len(ys),m))
    for j in range(m):
        for l in range(m):
            if l!=j: M[:,j]*= (ys-xs[l])/(xs[j]-xs[l])
    return M
def rho(s,P):
    L=np.zeros((m,m))
    for i,x in enumerate(xs):
        y=1/(P+x); w=(P+x)**(-2*s)
        L[i]=w@interp_matrix(y)
    return max(abs(np.linalg.eigvals(L)))
for A in (7,50,20000):
    P=pr[pr<=A]
    lo,hi=0.0,1.0
    for _ in range(40):
        mid=(lo+hi)/2
        if rho(mid,P)>1: lo=mid
        else: hi=mid
    print(A,lo)
# sanity: digits >=2 up to 20000
P=np.arange(2,20000,dtype=float);lo,hi=0,1
for _ in range(40):
    mid=(lo+hi)/2
    if rho(mid,P)>1: lo=mid
    else: hi=mid
print('>=2',lo)
