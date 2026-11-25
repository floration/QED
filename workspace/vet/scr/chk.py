import itertools, networkx as nx, collections
n=6; E=list(itertools.combinations(range(n),2)); m=len(E)
def pl(mask):
    G=nx.Graph(); G.add_nodes_from(range(n)); G.add_edges_from(E[i] for i in range(m) if mask>>i&1); return nx.check_planarity(G)[0]
F12=[x for c in itertools.combinations(range(m),12) for x in [sum(1<<i for i in c)] if pl(x)]
cnt=collections.Counter()
for f in F12:
    for j in range(m):
        if f>>j&1: cnt[f^(1<<j)]+=1
print(len(F12), collections.Counter(cnt.values()))
