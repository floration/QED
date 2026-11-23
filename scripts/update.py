"""Rebuild data/solutions.json and data/leaderboard.json from merged solutions (run on push to main)."""
import os,json,re,subprocess,glob
def merged_time(path):
    t=subprocess.run(['git','log','--diff-filter=A','--format=%cI','--',path],capture_output=True,text=True).stdout.split()
    return t[-1] if t else '9999'
def size(sol):
    s=re.sub(r'/-.*?-/','',open(sol).read(),flags=re.S)
    return len([l for l in s.splitlines() if l.strip() and not l.strip().startswith('--') and not l.startswith('import ')])
S={}
for sol in glob.glob('solutions/N-*/*/Solution.lean'):
    d=os.path.dirname(sol); pid,user=d.split('/')[1:3]
    m=json.load(open(d+'/meta.json'))
    S.setdefault(pid,[]).append(dict(user=user,model=m['model'],kind=m['kind'],size=size(sol),time=merged_time(sol)))
out={}
for pid,L in S.items():
    first=min(L,key=lambda x:x['time']); small=min(L,key=lambda x:(x['size'],x['time']))
    out[pid]=dict(first=first,smallest=small,count=len(L),kind=first['kind'])
json.dump(out,open('data/solutions.json','w'),indent=1)
def board(key):
    c={}
    for v in out.values():
        e=v[key]; k=(e['user'],e['model']); c[k]=c.get(k,0)+1
    return [dict(user=u,model=m,count=n) for (u,m),n in sorted(c.items(),key=lambda z:-z[1])]
json.dump(dict(first=board('first'),smallest=board('smallest')),open('data/leaderboard.json','w'),indent=1)
print(len(out),'solved')
