from sympy import factorint, isprime
from functools import lru_cache
import sys
@lru_cache(None)
def fac(n): return factorint(n)
def P(n): return n if n<=1 else max(fac(n))
def p(n): return n if n<=1 else min(fac(n))
def sopf(n): return 0 if n<=1 else sum(fac(n))
def s10(n): return sum(map(int,str(n)))
PDEF={'P':"/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/\ndef P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id",
 'p':"/-- least prime factor (`Nat.minFac`, so `p 1 = 1`) -/\ndef p (n : ℕ) : ℕ := n.minFac",
 'sopf':"/-- sum of the distinct prime factors -/\ndef sopf (n : ℕ) : ℕ := n.primeFactors.sum id",
 's10':"/-- decimal digit sum -/\ndef s10 (n : ℕ) : ℕ := (Nat.digits 10 n).sum"}
M=[ # id, pyf, leanf, uses, lo, exclude
('N-128',lambda n:P(n)+s10(n),'P n + s10 n','P s10',2,()),
('N-271',lambda n:P(n)+P(n+1),'P n + P (n+1)','P',2,()),
('N-272',lambda n:P(n)+P(n+2),'P n + P (n+2)','P',2,()),
('N-273',lambda n:2*P(n)+1,'2 * P n + 1','P',2,()),
('N-274',lambda n:2*P(n)-1,'2 * P n - 1','P',2,()),
('N-275',lambda n:P(n)+P(n+1)+P(n+2),'P n + P (n+1) + P (n+2)','P',2,()),
('N-276',lambda n:P(n)+P(n+1)-1,'P n + P (n+1) - 1','P',2,()),
('N-277',lambda n:(3*P(n)+1)//2,'(3 * P n + 1) / 2','P',2,()),
('N-278',lambda n:P(n)+P(2*n+1),'P n + P (2*n+1)','P',2,()),
('N-312',lambda n:P(n)+P(n+3),'P n + P (n+3)','P',3,()),
('N-313',lambda n:P(n-1)+P(n+1)+1,'P (n-1) + P (n+1) + 1','P',3,()),
('N-314',lambda n:P(n)+P(n+1)+1,'P n + P (n+1) + 1','P',2,()),
('N-315',lambda n:P(n)+P(n+1)+P(n+2)-2,'P n + P (n+1) + P (n+2) - 2','P',2,()),
('N-322',lambda n:P(n)+p(n+1),'P n + p (n+1)','P p',3,()),
('N-323',lambda n:sopf(n)+sopf(n+1),'sopf n + sopf (n+1)','sopf',2,()),
('N-324',lambda n:sopf(n)+P(n+1),'sopf n + P (n+1)','P sopf',2,()),
('N-325',lambda n:P(n)+2*P(n+1),'P n + 2 * P (n+1)','P',3,(8,)),
('N-326',lambda n:P(n)+P(n+1) if n%2==0 else P(n)+P(n-1),'if Even n then P n + P (n+1) else P n + P (n-1)','P',3,()),
('N-327',lambda n:P(n)+P(n+6),'P n + P (n+6)','P',3,()),
('N-328',lambda n:P(n)+sopf(n+1),'P n + sopf (n+1)','P sopf',2,()),
('N-332',lambda n:p(n)+p(n+1)+P(n+2),'p n + p (n+1) + P (n+2)','P p',2,()),
('N-333',lambda n:P(n)+P(n+2)+1,'P n + P (n+2) + 1','P',2,()),
('N-334',lambda n:P(n)+P(n+2)-1,'P n + P (n+2) - 1','P',2,()),
('N-471',lambda n:P(3*n+1)+P(n),'P (3*n+1) + P n','P',2,()),
('N-472',lambda n:P(n-1)+P(n+1),'P (n-1) + P (n+1)','P',3,()),
('N-483',lambda n:2*P(n)+P(n+1),'2 * P n + P (n+1)','P',2,()),
('N-489',lambda n:P(n)+P(n+1)+p(n+2),'P n + P (n+1) + p (n+2)','P p',2,()),
('N-490',lambda n:P(2*n+3)+P(n),'P (2*n+3) + P n','P',3,()),
]
PR=[('N-541',4,1),('N-542',2,3),('N-549',7,4),('N-559',3,4),('N-560',5,4)]
def cycles(f,starts):
    S=set();bad=[]
    for s in starts:
        seen=set();x=s
        while x not in seen and x<10**12: seen.add(x);x=f(x)
        c=[x];y=f(x)
        while y!=x:c.append(y);y=f(y)
        S|=set(c)
    return S
def cyc_list(f,S):
    out=[];left=set(S)
    while left:
        x=min(left);c=[x];y=f(x)
        while y!=x:c.append(y);y=f(y)
        out.append(c);left-=set(c)
    return out
out={}
for pid,f,lf,uses,lo,ex in M:
    starts=[n for n in range(lo,3001) if n not in ex]
    S=cycles(f,starts); cs=cyc_list(f,S)
    defs='\n'.join(PDEF[u] for u in uses.split())
    exs=''.join(f' → n ≠ {e}' for e in ex)
    cyc_doc='; '.join('('+', '.join(map(str,c))+')' for c in cs)
    lean=f"""import Mathlib
/-! {pid}. Cycles of the map (as observed numerically): {cyc_doc}.
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.{pid.replace('-','')}
{defs}
def f (n : ℕ) : ℕ := {lf}
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {{{', '.join(map(str,sorted(S)))}}}
def Claim : Prop := ∀ n : ℕ, {lo} ≤ n{exs} → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.{pid.replace('-','')}
"""
    out[pid]=lean; print(pid,len(cs),[len(c) for c in cs])
for pid,a,b in PR:
    f=lambda q,a=a,b=b:P(a*q+b)
    from sympy import primerange
    S=cycles(f,list(primerange(2,3000))); cs=cyc_list(f,S)
    cyc_doc='; '.join('('+', '.join(map(str,c))+')' for c in cs)
    out[pid]=f"""import Mathlib
/-! {pid}. Cycles of `q ↦ P({a}q+{b})` on primes (as observed numerically): {cyc_doc}. -/
namespace OpenProblems.{pid.replace('-','')}
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def g (q : ℕ) : ℕ := P ({a} * q + {b})
def cycleSet : Finset ℕ := {{{', '.join(map(str,sorted(S)))}}}
def Claim : Prop := ∀ q : ℕ, q.Prime → ∃ k : ℕ, g^[k] q ∈ cycleSet
end OpenProblems.{pid.replace('-','')}
"""
    print(pid,len(cs),cs)
import json; json.dump(out,open('maps_lean.json','w'),ensure_ascii=False)
