import numpy as np, math, random
def angles(P):
    a=[]
    for i in range(3):
        u=P[(i+1)%3]-P[i]; v=P[(i+2)%3]-P[i]
        a.append(math.degrees(math.acos(max(-1,min(1,np.dot(u,v)/np.linalg.norm(u)/np.linalg.norm(v))))))
    return a
np.random.seed(0)
for trial in range(5):
    P=np.random.rand(3,2); hist=[]
    for it in range(3000):
        L=[np.linalg.norm(P[(i+1)%3]-P[(i+2)%3]) for i in range(3)]
        i=int(np.argmax(L)); P[i]=P.mean(0)
        P=(P-P.mean(0)); P/=np.abs(P).max()
        hist.append(tuple(sorted(round(a,6) for a in angles(P))))
    print(trial, hist[-1], hist[-2], hist[-3], len(set(hist[-500:])))
