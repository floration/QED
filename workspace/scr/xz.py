import numpy as np, scipy.sparse as sp, scipy.sparse.linalg as sla, sys, time
X=sp.csr_matrix([[0,1],[1,0]]); Z=sp.csr_matrix([[1,0],[0,-1]]); I=sp.identity(2,format='csr')
def op(N,d):
    m=None
    for i in range(N):
        a=d.get(i,I)
        m=a if m is None else sp.kron(m,a,format='csr')
    return m
for N in [int(a) for a in sys.argv[1:]]:
    t=time.time()
    H=sum(op(N,{i:X,(i+1)%N:X})+op(N,{i:Z,(i+2)%N:Z}) for i in range(N))
    w=sla.eigsh(H,k=6,which='SA',return_eigenvectors=False)
    w=np.sort(w)
    print(N,np.round(w,5),round(time.time()-t,1))
