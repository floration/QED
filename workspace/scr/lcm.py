import numpy as np, math
for N in [500,1000,2000,4000]:
    a=np.arange(1,N+1)
    G=np.gcd.outer(a,a)
    L=G/np.outer(a,a)
    w=np.linalg.eigvalsh(L)[-1]
    print(N,w,math.sqrt(w))
