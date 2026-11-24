import re,glob,json
items=[]
for f in sorted(glob.glob('/home/claude/probs/p*.txt'),key=lambda s:int(re.search(r'p(\d+)',s).group(1))):
    for blk in re.split(r'(?m)^(?=## )',open(f).read()):
        if not blk.startswith('## '):continue
        l=blk.strip().split('\n'); h=[x.strip() for x in l[0][3:].split('|')]
        w=next(x[2:].strip() for x in l if x.startswith('W:')); m=next(x[2:].strip() for x in l if x.startswith('M:'))
        items.append([h[0],int(h[1]),h[2],w,m])
items.sort(key=lambda x:x[1])
NT=int(__import__('os').environ.get('NT','750'))
assert len(items)==NT, len(items)
assert len({i[0].lower() for i in items})==NT, [t for t in {i[0] for i in items} if sum(1 for j in items if j[0]==t)>1]
LT=json.load(open('/home/claude/lit_by_title.json')); AT=json.load(open('/home/claude/adv_by_title.json'))
for f in glob.glob('/home/claude/rate/newout*.json')+sorted(glob.glob('/home/claude/rate/aout*.json')):
    for o in json.load(open(f)):
        if 'aout' in f and o.get('flag')!='ok': continue
        AT[o['title']]=[round(float(o['r']),1),o.get('flag','ok'),o.get('why','')]
import os
if os.path.exists('/home/claude/refined.json'):
    for k,v in json.load(open('/home/claude/refined.json')).items():
        if k in AT: AT[k]=[v]+AT[k][1:]
P='prior'
RULES=[ # (regex on title+math, note, url) for problems with no tag yet
 (r'Q\(n\)|P\(n\^2\+1\)|square-plus-one|Square-plus-one|89',"Prior work: iterating n ↦ P(n²+1) is OEIS A031439, which asks whether the orbit of 1 grows or cycles.",'https://oeis.org/A031439'),
 (r'7-free|seven-free|Seven-free|digit 7|digit 9',"Prior work: Maynard, Nath and Leng–Sawhney on primes with a missing digit.",'https://arxiv.org/pdf/2609.05810'),
 (r'Keller|Jacobian|Alpöge',"Prior work (2026): the Jacobian counterexamples, the tangent-sweep construction, geometric degrees and monodromy.",'https://arxiv.org/pdf/2608.00222'),
 (r'S_N|square-sum|Square-sum|C_N|cube-sum',"Prior work: square-sum chains and necklaces exist for N≥25 and N≥32 (Gerbicz).",'https://mathworld.wolfram.com/Square-SumProblem.html'),
 (r'Prime Nim|prime subtraction|G\(n\)',"Prior work: the subtract-a-prime game is in OEIS (A014589, A355557).",'https://oeis.org/A355557'),
 (r'[Ll]onely runner',"Prior work: lonely runner conjecture proved up to 10 runners (2025).",'https://arxiv.org/pdf/2512.01912'),
 (r'unit distance|Unit distance|distance \$1\$',"Builds on the 2026 disproof of Erdős's unit distance conjecture.",'https://openai.com/index/model-disproves-discrete-geometry-conjecture/'),
 (r'RiemannHypothesis|Riemann hypothesis|RH',"Builds on Alpöge's Lean proof of RH (certified 21 Nov 2026).",'https://leanprover-community.github.io/blog/posts/riemann-hypothesis/'),
 (r'Navier|MHD|blow-up|blow up',"Builds on the 2026 forced Navier–Stokes blow-up construction.",'https://openai.com/index/navier-stokes-solution/'),
 (r'Ising|Potts|percolation|Percolation',"Prior numerical work on stat-mech models on the hat (Okabe et al. 2024; percolation 2026).",'https://arxiv.org/abs/2402.11331'),
 (r'Gerver|sofa',"Prior work: Baek's proof that Gerver's sofa is optimal; Romik's ODE description.",'https://arxiv.org/abs/2411.19826'),
 (r'spectral|Fuglede',"Background: Fuglede's spectral set conjecture.",'https://en.wikipedia.org/wiki/Fuglede%27s_conjecture'),
]
# Stable IDs: problems already published keep their id; new ones get the next free numbers.
FROZEN={r[1]:r[0] for r in json.load(open('/home/claude/D2_617_frozen.json'))}
nxt=max(int(v[2:]) for v in FROZEN.values())+1
idmap={}
for i in items:
    if i[0] in FROZEN: idmap[i[0]]=FROZEN[i[0]]
for i in items:
    if i[0] not in idmap: idmap[i[0]]=f"N-{nxt:03d}" if nxt<1000 else f"N-{nxt}"; nxt+=1
data=[]
for k,i in enumerate(items):
    id_=idmap[i[0]]; lit=LT.get(i[0])
    if lit is None:
        s=i[0]+' '+i[3]+' '+i[4]
        for rx,note,url in RULES:
            if re.search(rx,s): lit=[P,note,url]; break
    data.append([id_]+i+[lit,AT.get(i[0])])
print('adv:',sum(1 for d in data if d[7]),' lit:',sum(1 for d in data if d[6]))
tpl=open('/home/claude/tpl_head.html').read()+open('/home/claude/tpl_body.html').read()
open('/home/claude/site/index.html','w').write(tpl.replace('/*DATA*/[]',json.dumps(data,ensure_ascii=False).replace('</','<\\/')))
json.dump(data,open('/home/claude/D2.json','w'),ensure_ascii=False)
