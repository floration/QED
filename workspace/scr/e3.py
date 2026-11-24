import numpy as np, random, math
def pedal(P,Q):
    # feet of perpendiculars from Q to sides of triangle P
    out=[]
    for i in range(3):
        A=P[(i+1)%3]; B=P[(i+2)%3]
        d=B-A; t=np.dot(Q-A,d)/np.dot(d,d)
        out.append(A+t*d)
    return np.array(out)
def angles(P):
    a=[]
    for i in range(3):
        u=P[(i+1)%3]-P[i]; v=P[(i+2)%3]-P[i]
        a.append(math.degrees(math.acos(np.dot(u,v)/np.linalg.norm(u)/np.linalg.norm(v))))
    return sorted(a)
random.seed(2)
for trial in range(8):
    P=np.random.rand(3,2)
    for it in range(400):
        P=pedal(P,P.mean(0)); P=(P-P.mean(0)); P/=np.abs(P).max()
        if it in (50,399): print(trial,it,[round(x,4) for x in angles(P)])
