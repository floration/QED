import numpy as np
def count_neg(lam,L,dx):
    x=np.arange(-L+dx,L,dx); N=len(x)
    d=2/dx**2+lam*np.sin(x**2); o=-1/dx**2
    # Sturm count of eigenvalues < 0 : number of negative pivots in LDL^T of (T - 0)
    cnt=0; q=d[0]
    if q<0: cnt+=1
    for i in range(1,N):
        q=d[i]-o*o/q
        if q<0: cnt+=1
    return cnt
for lam in [6.0,10.0]:
    print(lam,[count_neg(lam,L,0.004) for L in [10,20,40,80]])
