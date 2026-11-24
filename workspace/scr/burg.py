import numpy as np
def takagi(x,K=40):
    s=np.zeros_like(x)
    for n in range(K):
        y=(2.0**n)*x; s+= np.abs(y-np.round(y))/2.0**n
    return s
M=2**15
for M in [2**12,2**14,2**16]:
  y=np.arange(-M,2*M)/M   # 3 periods
  u0=takagi(y)
  U=np.concatenate([[0],np.cumsum((u0[1:]+u0[:-1])/2)/M])
  for t in [0.05,0.2,1.0]:
    xs=np.arange(0,M,max(1,M//4096))/M
    # Lax-Oleinik: minimize U(y)+(x-y)^2/(2t); use chunked
    am=[]
    for x in xs:
        v=U+(x-y)**2/(2*t)
        am.append(y[np.argmin(v)])
    am=np.array(am); jumps=np.diff(am)
    h=1.0/len(xs)
    print(M,t,'shocks', int(np.sum(jumps>5*max(h,1.0/M)+ (np.abs(1.0)*0))) )
