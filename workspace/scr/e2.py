from collections import defaultdict
def run(N, rule):
    c=defaultdict(int); x=0; mn=mx=0; seen=set([0])
    for n in range(N):
        c[x]+=1; k=c[x]
        x = rule(x,k)
        seen.add(x); mn=min(mn,x); mx=max(mx,x)
    # smallest nonneg not visited
    m=0
    while m in seen: m+=1
    m2=0
    while -m2 in seen: m2+=1
    return x,mn,mx,m,m2,len(seen)
for name,rule in [('odd+',lambda x,k: x+k if k%2 else x-k)]:
    for N in [10**4,10**5,10**6]:
        print(name,N,run(N,rule))
