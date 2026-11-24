import random
# x_i <- |x_{i-1}-x_{i+1}| on Z, finitely supported
def run(init,T):
    x=dict(enumerate(init))
    for t in range(T):
        keys=set()
        for k in x: keys|={k-1,k+1}
        y={}
        for k in keys:
            v=abs(x.get(k-1,0)-x.get(k+1,0))
            if v: y[k]=v
        x=y
        if not x: return t,'dies',set()
    return T,'alive',set(x.values())
random.seed(1)
bad=0
for trial in range(300):
    L=random.randint(1,6); init=[random.randint(0,9) for _ in range(L)]
    t,s,vals=run(init,600)
    if len(vals)>1: bad+=1; print(init,s,sorted(vals)[:10])
print('bad',bad)
