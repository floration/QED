import networkx as nx, itertools, sys, time
from itertools import combinations_with_replacement as cwr
def trees(n):
    if n==1: g=nx.Graph(); g.add_node(0); return [g]
    return list(nx.nonisomorphic_trees(n))
T={n:trees(n) for n in range(1,13)}
def label(F):
    n=F.number_of_nodes(); m=F.number_of_edges()
    order=list(nx.dfs_preorder_nodes(F)) if nx.is_connected(F) else [v for comp in nx.connected_components(F) for v in nx.dfs_preorder_nodes(F.subgraph(comp))]
    # order by degree desc within? keep simple
    adj={v:set(F[v]) for v in F}
    lab={}; used=set(); diffs=set()
    def bt(i):
        if i==n: return True
        v=order[i]
        for L in range(n):
            if L in used: continue
            nd=[abs(L-lab[u]) for u in adj[v] if u in lab]
            if len(set(nd))<len(nd) or any(d in diffs for d in nd): continue
            lab[v]=L; used.add(L); diffs.update(nd)
            if bt(i+1): return True
            del lab[v]; used.discard(L); diffs.difference_update(nd)
        return False
    return bt(0)
def parts(n,maxp=None):
    if maxp is None: maxp=n
    if n==0: yield []; return
    for k in range(min(n,maxp),0,-1):
        for r in parts(n-k,k): yield [k]+r
t0=time.time()
NMAX=int(sys.argv[1])
for N in range(2,NMAX+1):
    cnt=0;bad=[]
    for P in parts(N):
        if len(P)<2: continue
        # choose trees per part size
        from collections import Counter
        C=Counter(P); choices=[list(cwr(range(len(T[s])),k)) for s,k in C.items()]
        sizes=list(C.keys())
        for combo in itertools.product(*choices):
            gs=[T[s][i] for s,ch in zip(sizes,combo) for i in ch]
            F=nx.disjoint_union_all(gs); m=F.number_of_edges()
            big=max(g.number_of_edges() for g in gs)>m/2
            cnt+=1
            if not label(F): bad.append((P,big,[sorted(d for _,d in g.degree()) for g in gs]))
    print(N,cnt,'fail:',len(bad),[b for b in bad][:8],time.time()-t0,flush=True)
