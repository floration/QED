import numpy as np, time
rng=np.random.default_rng(1)
def leg(p):
    q=np.zeros(p,int); 
    for a in range(1,p): q[a*a%p]=1
    c=np.where(q==1,1,-1); c[0]=0; return c
for p in [101,197,401,797]:
    c=leg(p); J=np.array([[c[(j-i)%p] for j in range(p)] for i in range(p)])
    best=-1e9; t=time.time()
    for trial in range(30):
        s=rng.choice([-1,1],p); f=J@s
        while True:
            gain=-2*s*f  # change in s^T J s when flipping i: -4 s_i f_i ; use sign
            i=np.argmax(-s*f)
            if -s[i]*f[i]<=0: break
            f-=2*s[i]*J[:,i]; s[i]=-s[i]
        E=s@J@s/2
        best=max(best,E)
        if time.time()-t>4: break
    print(p,best,best/p**1.5)
