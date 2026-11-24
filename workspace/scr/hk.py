import math
from collections import defaultdict
for K in range(5,7):
    W=2**K
    masks=[1<<(2**k-1) for k in range(K+1)]  # bit j-1 means position i-j
    st={0:1}; logs=[]
    n=0; tot_prev=None
    for n in range(1,260):
        ns=defaultdict(int)
        for s,c in st.items():
            # place 0
            ns[(s<<1)&((1<<W)-1)]+=c
            ok=all(not(s&m) for m in masks)
            if ok: ns[((s<<1)|1)&((1<<W)-1)]+=c
        tot=sum(ns.values())
        # normalize
        st=dict((k,v/tot) for k,v in ns.items())
        logs.append(math.log2(tot))
    print(K, 'states',len(st),'h_K(bits)=%.5f'%(sum(logs[-60:])/60))
