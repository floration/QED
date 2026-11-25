import snappy, sys, time
def tm(n): 
    w='0'
    for _ in range(n): w=w+''.join('1' if c=='0' else '0' for c in w)
    return w
def lorenz_braid(w):
    L=len(w); rots=[(w[i:]+w[:i])*3 for i in range(L)]
    order=sorted(range(L),key=lambda i:rots[i]); rank={i:r for r,i in enumerate(order)}
    perm=[rank[(i+1)%L] for i in order]  # strand at position r goes to perm[r]
    # reduced positive word for permutation via bubble sort on target positions
    arr=perm[:]; gens=[]
    changed=True
    while changed:
        changed=False
        for j in range(L-1):
            if arr[j]>arr[j+1]:
                arr[j],arr[j+1]=arr[j+1],arr[j]; gens.append(j+1); changed=True
    return gens,L
for n in range(int(sys.argv[2]),int(sys.argv[1])+1):
    t=time.time(); g,L=lorenz_braid(tm(n))
    K=snappy.Link(braid_closure=g); K.simplify('basic')
    M=K.exterior(); 
    print(n,2**n,'comps',len(K.link_components),'crossings',len(K.crossings),M.solution_type(),M.volume(), M.volume()/2**n, round(time.time()-t,1),flush=True)
