import math
for e in [8,10,12,14]:
    X=int(10**(e/2)); c=sum(1 for m in range(1,X+1) if '7' not in str(m*m))
    x=10**e
    print(e,c, 'emp exp',math.log(c)/math.log(x),'claim',0.5*math.log10(9),'heur',math.log10(9)-0.5)
