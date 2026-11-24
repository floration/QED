import numpy as np, scipy.sparse as sp, scipy.sparse.linalg as sla
for n in [1000,4000,16000,64000,256000]:
    r=[];c=[]
    for i in range(1,n+1):
        for j in range(2*i,n+1,i):
            r.append(i-1);c.append(j-1)
    A=sp.coo_matrix((np.ones(len(r)),(r,c)),shape=(n,n)).tocsr(); A=A+A.T
    w=sla.eigsh(A,k=1,which='LA',return_eigenvectors=False)[0]
    print(n,w,w/np.sqrt(n),w/np.sqrt(n*np.log(n)))
