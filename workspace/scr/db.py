import numpy as np
L=200.0; N=4000; dx=L/N; x=np.arange(N)*dx-L/2
s=int(round(1/dx))
def run(A,T=20):
    u=A*np.exp(-x**2)
    dt=0.2*dx*dx; t=0
    while t<T:
        lap=(np.roll(u,1)-2*u+np.roll(u,-1))/dx**2
        u=u+dt*(lap+u**2-np.roll(u,s)**2)
        t+=dt
        if not np.isfinite(u).all() or np.abs(u).max()>1e6: return ('blow',round(t,3))
    return ('ok',float(np.abs(u).max()))
for A in []:
    print(A,run(A,T=5))
print('---')
for A in [-100,-400]:
    print(A,run(A,T=3))
