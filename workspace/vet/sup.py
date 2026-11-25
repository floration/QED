import numpy as np
from scipy.special import jv
from scipy.optimize import minimize_scalar
from math import gamma
def area(p): return 4*gamma(1+1/p)**2/gamma(1+2/p)
def lam(p,N=14,M=200):
    th=np.linspace(0,np.pi/4,M)
    rb=(np.abs(np.cos(th))**p+np.abs(np.sin(th))**p)**(-1/p)
    # interior points
    rng=np.random.default_rng(0); ti=rng.uniform(0,np.pi/4,M); si=rng.uniform(0,1,M)*rb.min()*0.9
    def sig(k):
        A=np.array([jv(4*j,k*rb)*np.cos(4*j*th) for j in range(N)]).T
        B=np.array([jv(4*j,k*si)*np.cos(4*j*ti) for j in range(N)]).T
        Q,R=np.linalg.qr(np.vstack([A,B]))
        s=np.linalg.svd(Q[:M],compute_uv=False)
        return s[-1]
    ks=np.linspace(1.8,3.0,121); v=[sig(k) for k in ks]; i=int(np.argmin(v))
    r=minimize_scalar(sig,bracket=(ks[i-1],ks[i],ks[i+1]),tol=1e-12)
    return r.x**2*area(p), r.fun
for p in [2,2.5,3,3.5,4,5,6,8,10,15,20,30,50]:
    print(p,lam(p))
print('square',2*np.pi**2)
