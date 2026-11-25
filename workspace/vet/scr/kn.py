import itertools, sys
from sympy.combinatorics import Permutation, PermutationGroup
from sympy.combinatorics.named_groups import AlternatingGroup
def mul(a,b): return tuple(b[a[i]] for i in range(len(a)))  # a then b
def inv(a):
    r=[0]*len(a)
    for i,v in enumerate(a): r[v]=i
    return tuple(r)
def cyc(p):
    n=len(p);seen=[0]*n;t=[]
    for i in range(n):
        if not seen[i]:
            l=0;j=i
            while not seen[j]: seen[j]=1;j=p[j];l+=1
            t.append(l)
    return tuple(sorted(t))
def even(p): return sum(l-1 for l in cyc(p))%2==0
def W(knot,x,y):
    xi,yi=inv(x),inv(y)
    if knot=='3_1': return mul(x,y)
    if knot=='4_1': return mul(mul(mul(xi,y),x),yi)
n=int(sys.argv[1]); knot=sys.argv[2]
els=[p for p in itertools.permutations(range(n)) if even(p)]
classes={}
for p in els: classes.setdefault(cyc(p),[]).append(p)
found=False
for ct,cl in classes.items():
    if ct==(1,)*n: continue
    x=cl[0]
    for y in cl:
        w=W(knot,x,y)
        if mul(w,x)==mul(y,w):
            G=PermutationGroup([Permutation(list(x)),Permutation(list(y))])
            if G.order()*2==len(els)*2 and G.order()==len(els):
                print(n,knot,"surj via class",ct); found=True; break
    if found: break
if not found: print(n,knot,"no surjection")
