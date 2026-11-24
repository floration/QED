import random
from collections import defaultdict
random.seed(5)
# local-time jump walk
def ltw(N):
    c=defaultdict(int); x=0; ret=0; maxabs=0
    for n in range(N):
        c[x]+=1
        x+= c[x]*random.choice((-1,1))
        if x==0: ret+=1
        maxabs=max(maxabs,abs(x))
    return ret,maxabs,len(c)
for N in [10**4,10**5,10**6]:
    print(N,[ltw(N) for _ in range(3)])
