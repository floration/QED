import sys; sys.argv=['x','0','0']
exec(open('lor.py').read().split('for n in range')[0])
import snappy
K=snappy.Link(braid_closure=lorenz_braid(tm(3))[0]); K.simplify('global'); M=K.exterior()
print(len(K.crossings), M.fundamental_group(), M.identify())
K=snappy.Link(braid_closure=lorenz_braid(tm(8))[0]); K.simplify('basic'); M=K.exterior()
for i in range(3):
    M.randomize(); print(M.solution_type(), M.volume())
