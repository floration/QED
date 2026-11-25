import itertools, networkx as nx, sys, time
n=int(sys.argv[1]); E=list(itertools.combinations(range(n),2)); m=len(E)
t=time.time()
faces={}
for mask in range(1<<m):
    G=nx.Graph(); G.add_nodes_from(range(n)); G.add_edges_from(E[i] for i in range(m) if mask>>i&1)
    if bin(mask).count('1')<=8 or nx.check_planarity(G)[0]:
        faces.setdefault(bin(mask).count('1'),[]).append(mask)
print({k:len(v) for k,v in sorted(faces.items())}, time.time()-t)
chi=sum((-1)**(k-1)*len(v) for k,v in faces.items())  # empty set k=0 gives -1
print("reduced chi",chi)
# GF2 ranks of boundary maps d_k: C_k (k edges) -> C_{k-1}
idx={k:{f:i for i,f in enumerate(v)} for k,v in faces.items()}
def rank(k):
    if k-1 not in faces: return 0
    rows=[]
    for f in faces[k]:
        r=0; x=f
        while x:
            b=x&-x; r|=1<<idx[k-1][f^b]; x^=b
        rows.append(r)
    piv={}
    rk=0
    for r in rows:
        while r:
            h=r.bit_length()-1
            if h in piv: r^=piv[h]
            else: piv[h]=r; rk+=1; break
    return rk
K=max(faces); R={k:rank(k) for k in range(1,K+1)}; R[K+1]=0
for k in range(0,K+1):
    b=len(faces[k])-R.get(k,0)-R[k+1]
    if b: print("reduced H_dim",k-1,"=",b)
