from sympy import factorint
def P(n): return max(factorint(n))
f=lambda n:P(2*n+3)+P(n)
import sys
# find bad start: run with sympy for starts up to 150000 only on those reaching >5e6
lp=None
for s in range(3,150001):
    x=s;seen=set();big=False
    while x not in seen:
        seen.add(x)
        if x>5_000_000: big=True;break
        x=f(x)
    if big:
        print('start',s);break
x=s;seen={}
k=0
while x not in seen and k<400:
    seen[x]=k;x=f(x);k+=1
print(k,x,max(seen))
