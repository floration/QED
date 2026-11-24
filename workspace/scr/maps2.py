import time,math
LIM=4_000_000
lpf=[0]*(LIM+1)
for i in range(2,LIM+1):
    if lpf[i]==0:
        for j in range(i,LIM+1,i): lpf[j]=i
def P(n): return lpf[n]
def nextp(n):
    m=n+1
    while lpf[m]!=m: m+=1
    return m
def prevp(n):
    m=n-1
    while m>1 and lpf[m]!=m: m-=1
    return m
def ds(n): return sum(map(int,str(n)))
maps={
 'P(n)+P(n+3)':lambda n:P(n)+P(n+3),
 'P(n)+P(n+4)':lambda n:P(n)+P(n+4),
 'P(n)*2+P(n+1)':lambda n:2*P(n)+P(n+1),
 'P(n)+ds(n)':lambda n:P(n)+ds(n),
 'P(n^2+n+1)':lambda n:P(n*n+n+1) if n*n+n+1<=LIM else None,
 'P(n)+nextprime(n)-n':lambda n:P(n)+nextp(n)-n,
 'P(n+1)+P(n-1)+1':lambda n:P(n+1)+P(n-1)+1 if n>2 else n+1,
 'nextp(P(n))+1':lambda n:nextp(P(n))+1,
 'P(n)+P(n+1)+1':lambda n:P(n)+P(n+1)+1,
 'P(2n-1)+P(2n+1)':lambda n:P(2*n-1)+P(2*n+1),
 'P(n)+P(3n+1)? (have)':None,
 '(P(n)+P(n+1))/2 ceil':lambda n:(P(n)+P(n+1)+1)//2,
 'P(n)+n mod 10 stuff':lambda n:P(n)+(n%10),
 'P(n)+tau':lambda n:P(n)+len([d for d in range(1,int(n**.5)+1) if n%d==0]) ,
 'P(n+P(n))+P(n)':lambda n:P(n+P(n))+P(n),
 'P(n)+P(n+1)+P(n+2)-2':lambda n:P(n)+P(n+1)+P(n+2)-2,
 '3P(n)+1 /2 if even':lambda n:(3*P(n)+1)//2 if (3*P(n)+1)%2==0 else 3*P(n)+1,
 'P(n)^2 -> P(P(n)^2+1)+1':lambda n:P(P(n)**2+1)+1 if P(n)**2+1<=LIM else None,
 'P(n)+prevp(n)':lambda n:(P(n)+prevp(n)) if n>2 else 5,
 'P(n)+P(n+1)-P(n+2)abs':lambda n:abs(P(n)+P(n+1)-P(n+2)) or 1,
}
for name,f in maps.items():
    if f is None: continue
    t0=time.time();cyc={};bad=0;maxv=0
    for s in range(3,20001):
        seen={};x=s;k=0
        while x not in seen and k<500:
            seen[x]=k; x=f(x); k+=1
            if x is None or x>LIM-10 or x<2: bad+=1;break
            maxv=max(maxv,x)
        else:
            if k>=500: bad+=1;continue
            # cycle
            c=[x];y=f(x)
            while y!=x: c.append(y);y=f(y)
            m=min(c);i=c.index(m);c=tuple(c[i:]+c[:i]);cyc[c]=cyc.get(c,0)+1
            continue
    print(name,'bad',bad,'max',maxv,'cycles',{k[:8] if len(k)<=8 else (k[:4],len(k)):v for k,v in cyc.items()},round(time.time()-t0,1))
