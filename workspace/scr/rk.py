import numpy as np
L=400.0; N=4000; dx=L/N; x=(np.arange(N)-N//2+0.5)*dx  # symmetric grid, reflection = reverse
def run(u,T):
    dt=0.2*dx*dx; t=0; out=[]
    nxt=1
    while t<T:
        lap=(np.roll(u,1)-2*u+np.roll(u,-1))/dx**2
        lap[0]=lap[-1]=0
        u=u+dt*(lap+u*(1-u[::-1]))
        t+=dt
        if t>=nxt:
            out.append((nxt,round(u.max(),3),round(u[x>0].max(),3),round(u[x<0].max(),3))); nxt*=2
    return out
u0=np.exp(-(x-3)**2)+0.5*np.exp(-(x+3)**2)
for r in run(u0,64): print(r)
