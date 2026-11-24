import numpy as np
def takagi(x,K=45):
    s=np.zeros_like(x)
    for n in range(K):
        y=(2.0**n)*x; s+= np.abs(y-np.round(y))/2.0**n
    return s
for M in [2**14,2**16]:
  y=np.arange(-M,2*M)/M
  u0=takagi(y)
  U=np.concatenate([[0],np.cumsum((u0[1:]+u0[:-1])/2)/M])
  for t in [0.1,0.5,2.0]:
    NX=2**13; xs=np.arange(NX)/NX; am=np.empty(NX); lo=0
    for i,x in enumerate(xs):
      v=U[lo:lo+2*M]+(x-y[lo:lo+2*M])**2/(2*t); lo+=int(np.argmin(v)); am[i]=y[lo]
    j=np.diff(am); h=1/NX
    # regular increments are about h*(dy/dx) ; dy/dx<=1 for rarefaction? count gap mass beyond 2h
    print(M,t,'gap mass >4h:',round(j[j>4*h].sum(),4),'count',int((j>4*h).sum()), 'gap mass>1e-2', round(j[j>1e-2].sum(),4))
