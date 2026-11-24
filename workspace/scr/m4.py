import numpy as np,time
LIM=30_000_000
lpf=np.zeros(LIM+1,dtype=np.int32)
for p in range(2,int(LIM**.5)+1):
    if lpf[p]==0:
        s=lpf[p*p::p]; m=(s==0); s[m]=p; lpf[p*p::p]=s
idx=np.nonzero(lpf==0)[0]; lpf[idx]=idx
lp=lpf.tolist()
def P(n):
    b=1
    while n>1:
        p=lp[n]; b=p
        while n%p==0: n//=p
    return b
def p_(n): return lp[n]
def rev(n): return int(str(n)[::-1])
def omega(n):
    c=0
    while n>1:
        p=lp[n];c+=1
        while n%p==0:n//=p
    return c
def sopf(n):
    s=0
    while n>1:
        p=lp[n];s+=p
        while n%p==0:n//=p
    return s
maps={
'P(n)+p(n+1)':lambda n:P(n)+p_(n+1),
'sopf(n)+sopf(n+1)':lambda n:sopf(n)+sopf(n+1),
'sopf(n)+P(n+1)':lambda n:sopf(n)+P(n+1),
'P(n)+rev(n)%...':lambda n:P(n)+P(rev(n)) if rev(n)>1 else 7,
'P(n)P(n+1) -> P(that+1)':lambda n:P(P(n)*P(n+1)+1) if P(n)*P(n+1)+1<LIM else -1,
'P(n)+P(n+1)+P(n+2)+P(n+3)':lambda n:P(n)+P(n+1)+P(n+2)+P(n+3),
'P(n^2+1)+1 small':lambda n:P(n*n+1)+1 if n*n+1<LIM else -1,
'P(n)+2P(n+1)':lambda n:P(n)+2*P(n+1),
'P(n)+P(n+1) if even else P(n)+P(n-1)':lambda n:P(n)+P(n+1) if n%2==0 else P(n)+P(n-1),
'P(5n+1)+P(n)':lambda n:P(5*n+1)+P(n),
'P(n)+P(n+6)':lambda n:P(n)+P(n+6),
'P(n)+sopf(n+1)':lambda n:P(n)+sopf(n+1),
}
for name,f in maps.items():
    t=time.time();cyc={};bad=0;mx=0
    for s in range(3,60001):
        seen=set();x=s
        while x not in seen:
            seen.add(x);x=f(x)
            if x<2 or x>LIM//6: bad+=1;break
            if x>mx:mx=x
        else:
            c=[x];y=f(x)
            while y!=x:c.append(y);y=f(y)
            k=(min(c),len(c));cyc[k]=cyc.get(k,0)+1
    items=sorted(cyc.items(),key=lambda z:-z[1])
    print(name,'bad',bad,'mx',mx,'ncyc',len(cyc),items[:8],round(time.time()-t,1),flush=True)
