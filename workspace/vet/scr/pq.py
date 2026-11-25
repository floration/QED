import itertools, networkx as nx, numpy as np, time
n=6; E=list(itertools.combinations(range(n),2)); m=len(E)
faces={}
for mask in range(1<<m):
    k=bin(mask).count('1')
    if k<=8: ok=True
    else:
        G=nx.Graph(); G.add_nodes_from(range(n)); G.add_edges_from(E[i] for i in range(m) if mask>>i&1); ok=nx.check_planarity(G)[0]
    if ok: faces.setdefault(k,[]).append(mask)
idx={k:{f:i for i,f in enumerate(v)} for k,v in faces.items()}
def rank(k):
    M=np.zeros((len(faces[k]),len(faces[k-1])))
    for i,f in enumerate(faces[k]):
        bits=[j for j in range(m) if f>>j&1]
        for s,j in enumerate(bits): M[i,idx[k-1][f^(1<<j)]]=(-1)**s
    return np.linalg.matrix_rank(M)
t=time.time()
R={k:rank(k) for k in [11,12]}; R[13]=0
print("H11",195-R[12],"H10",1125-R[11]-R[12])
print(time.time()-t)
