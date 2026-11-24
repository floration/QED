import sys
from sympy import primerange, factorint
N=200000
P=[0]*(N+2)
for i in range(2,N+2):
    if P[i]==0:
        for j in range(i,N+2,i): P[j]=i
# problem 0 contraction check
bad=0
def g(n): return n//2 if n%2==0 else n+P[n+1]
# Prime Nim grundy
M=3000
pr=list(primerange(2,M))
G=[0]*M
for n in range(M):
    s={G[n-p] for p in pr if p<=n}
    k=0
    while k in s:k+=1
    G[n]=k
print('G',G[:80])
print('maxG',max(G))
L=[n for n in range(M) if G[n]==0];print('L',L[:40])
# Fib chains
fib=[1,2]
while fib[-1]<10**5: fib.append(fib[-1]+fib[-2])
fs=set(fib)
import itertools
def ham(N):
    adj={a:[b for b in range(1,N+1) if b!=a and a+b in fs] for a in range(1,N+1)}
    if any(len(adj[a])==0 for a in adj): return False
    sys.setrecursionlimit(10000)
    def dfs(v,vis):
        if len(vis)==N: return True
        for w in adj[v]:
            if w not in vis:
                vis.add(w)
                if dfs(w,vis): return True
                vis.remove(w)
        return False
    return any(dfs(s,{s}) for s in range(1,N+1))
print('fib ham',[N for N in range(1,40) if ham(N)])
