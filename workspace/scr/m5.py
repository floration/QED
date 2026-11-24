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
'A':lambda n:P(n)+p_(n+1),
'B':lambda n:sopf(n)+sopf(n+1),
'C':lambda n:sopf(n)+P(n+1),
'D':lambda n:P(n)+2*P(n+1),
'E':lambda n:P(n)+P(n+1) if n%2==0 else P(n)+P(n-1),
'F':lambda n:P(n)+P(n+6),
'G':lambda n:P(n)+sopf(n+1),
}
for name,f in maps.items():
    cyc={};bad=0;mx=0
    for s in range(3,150001):
        seen=set();x=s
        while x not in seen:
            seen.add(x);x=f(x)
            if x<2 or x>LIM//6: bad+=1;break
            if x>mx:mx=x
        else:
            c=[x];y=f(x)
            while y!=x:c.append(y);y=f(y)
            i=c.index(min(c));c=tuple(c[i:]+c[:i]);cyc[c]=cyc.get(c,0)+1
    print(name,bad,mx,cyc,flush=True)
