import numpy as np,time,sys
LIM=30_000_000
t=time.time()
lpf=np.zeros(LIM+1,dtype=np.int32)
for p in range(2,int(LIM**.5)+1):
    if lpf[p]==0:
        s=lpf[p*p::p]; m=(s==0); s[m]=p; lpf[p*p::p]=s
idx=np.nonzero(lpf==0)[0]; lpf[idx]=idx
# lpf holds smallest pf; need largest: compute by dividing
lp=lpf.tolist()
def P(n):
    b=1
    while n>1:
        p=lp[n]; b=p
        while n%p==0: n//=p
    return b
def ds(n): return sum(map(int,str(n)))
maps={
'a':lambda n:P(n)+P(n+3),
'b':lambda n:2*P(n)+P(n+1),
'c':lambda n:P(n)+ds(n),
'd':lambda n:P(n+1)+P(n-1)+1,
'e':lambda n:P(n)+P(n+1)+1,
'f':lambda n:P(n)+P(n+1)+P(n+2)-2,
}
print('sieve',time.time()-t,flush=True)
for name,f in maps.items():
    t=time.time();cyc={};bad=0;mx=0
    for s in range(3,150001):
        seen=set();x=s
        while x not in seen:
            seen.add(x);x=f(x)
            if x>LIM-5: bad+=1;break
            if x>mx:mx=x
        else:
            c=[x];y=f(x)
            while y!=x:c.append(y);y=f(y)
            cyc[min(c),len(c)]=cyc.get((min(c),len(c)),0)+1
    print(name,bad,mx,cyc,round(time.time()-t,1),flush=True)
