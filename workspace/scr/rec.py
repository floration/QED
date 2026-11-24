from sympy import factorint
from functools import lru_cache
@lru_cache(None)
def P(n): return max(factorint(n)) if n>1 else 1
import itertools,time
t=time.time()
# fib
mx=0;cyc=set()
for a in range(2,120):
  for b in range(2,120):
    seen={};x=(a,b);k=0
    while x not in seen and k<5000:
        seen[x]=k;x=(x[1],P(x[0])+P(x[1]));k+=1;mx=max(mx,x[1])
    if k>=5000: print('fib nonper',a,b)
    else: cyc.add(min(seen,key=lambda z:0) if False else len(seen)-seen[x])
print('fib max',mx,'cycle lengths',sorted(cyc)[:20],time.time()-t)
mx=0;cl=set();t=time.time()
for a in range(2,30):
 for b in range(2,30):
  for c in range(2,30):
    seen={};x=(a,b,c);k=0
    while x not in seen and k<5000:
        seen[x]=k;x=(x[1],x[2],P(x[0])+P(x[1])+P(x[2]));k+=1;mx=max(mx,x[2])
    if k>=5000: print('trib nonper',a,b,c)
    else: cl.add(len(seen)-seen[x])
print('trib max',mx,sorted(cl),time.time()-t)
mx=0;t=time.time()
for a in range(2,60):
  for b in range(2,60):
    seen=set();x=(a,b);k=0
    while x not in seen and k<3000:
        seen.add(x);x=(x[1],P(x[0]*x[1]+1));k+=1;mx=max(mx,x[1])
    if k>=3000: print('prod nonper',a,b)
print('prod max',mx,time.time()-t)
s={1:2,2:2}
def S(n):
    if n in s:return s[n]
    v=S(n//2) if n%2==0 else P(S(n//2)+S(n//2+1))
    s[n]=v;return v
vals=[S(n) for n in range(1,200000)]
print('stern max',max(vals),len(set(vals)))
