import itertools,sys
def grid(n):
    N=n*n
    colj=[ (c%n)*n + c//n for c in range(N)]
    return [[(i+colj[c])%N for c in range(N)] for i in range(N)]
def is_sudoku(g,n):
    N=n*n
    ok=all(len(set(r))==N for r in g) and all(len({g[i][j] for i in range(N)})==N for j in range(N))
    for a in range(n):
        for b in range(n):
            ok&=len({g[a*n+i][b*n+j] for i in range(n) for j in range(n)})==N
    return ok
def has_trans(g):
    N=len(g); usedc=set(); useds=set()
    def bt(r):
        if r==N: return True
        for c in range(N):
            if c in usedc or g[r][c] in useds: continue
            usedc.add(c); useds.add(g[r][c])
            if bt(r+1): return True
            usedc.discard(c); useds.discard(g[r][c])
        return False
    return bt(0)
for n in [2,3,4]:
    g=grid(n); print(n,is_sudoku(g,n),has_trans(g) if n<4 else 'skip(Hall-Paige: Z_16 none)')
