import numpy as np
def takagi(x,K=40):
    s=np.zeros_like(x)
    for n in range(K):
        y=(2.0**n)*x; s+= np.abs(y-np.round(y))/2.0**n
    return s
M=2**16
y=np.arange(-M,2*M)/M
u0=takagi(y)
U=np.concatenate([[0],np.cumsum((u0[1:]+u0[:-1])/2)/M])
for t in [0.5,2.0]:
  NX=2**14
  xs=np.arange(NX)/NX
  am=np.empty(NX)
  # use monotonicity: argmin nondecreasing in x
  lo=0
  for i,x in enumerate(xs):
      v=U[lo:]+(x-y[lo:])**2/(2*t)
      # restrict window
      j=np.argmin(v[:M]) if len(v)>M else np.argmin(v)
      lo=lo+j; am[i]=y[lo]
  j=np.diff(am)
  js=np.sort(j)[::-1]
  print(t, 'jumps >1e-3:',int((j>1e-3).sum()),' >1e-4:',int((j>1e-4).sum()),'top',np.round(js[:6],4))
  idx=np.where(j>2e-4)[0]
  print('  locations', [(round(xs[i],5), round(j[i],5)) for i in idx][:40])
