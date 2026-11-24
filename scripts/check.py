"""CI check for a solution PR. Usage: python3 scripts/check.py <changed files...>
Writes check_result.json. Exit 1 on failure."""
import sys,os,re,json,subprocess
files=[f for f in sys.argv[1:] if f.strip()]
def fail(msg): json.dump({'ok':False,'error':msg},open('check_result.json','w')); print('FAIL:',msg); sys.exit(1)
dirs={os.path.dirname(f) for f in files}
if not files or any(not re.fullmatch(r'solutions/N-\d{3,4}/[A-Za-z0-9-]+/(Solution\.lean|meta\.json|README\.md)',f) for f in files):
    fail('A solution PR may only add solutions/N-xxx/<username>/{Solution.lean,meta.json,README.md}')
if len(dirs)!=1: fail('One solution per PR')
d=dirs.pop(); pid,user=d.split('/')[1:3]
author=os.environ.get('PR_AUTHOR','')
if author and author.lower()!=user.lower(): fail(f'Folder name {user} must match PR author {author}')
sol=open(f'{d}/Solution.lean').read(); meta=json.load(open(f'{d}/meta.json'))
if meta.get('kind') not in ('proof','disproof') or not meta.get('model'): fail('meta.json needs "model" and "kind": proof|disproof')
stmt=open(f'problems/{pid}/Statement.lean').read()
if re.search(r'def Claim : Prop := sorry',stmt): fail(f'{pid} is not formalized yet; formalize Statement.lean first')
body=re.sub(r'(?m)^import .*$','',sol)
for bad in [r'\bsorry\b',r'\badmit\b',r'\baxiom\b',r'\bset_option\b',r'\bimplemented_by\b',r'\bextern\b',r'\bunsafe\b',r'\bdef Claim\b',r'\bnamespace OpenProblems\b',r'\bnative_decide\b',r'#exit',r'\bopaque\b',r'#eval',r'\brun_cmd\b',r'\brun_tac\b',r'\brun_elab\b',r'\belab\b',r'\bmacro\b',r'\bsyntax\b',r'\binitialize\b',r'\bIO\b',r'\bunsafe\b',r'#print']:
    if re.search(bad,body): fail(f'Forbidden token: {bad}')
ns=pid.replace('-','')
target=f'OpenProblems.{ns}.Claim' if meta['kind']=='proof' else f'¬ OpenProblems.{ns}.Claim'
open('Check.lean','w').write(stmt+'\n'+body+f'\nexample : {target} := solution\n#print axioms solution\n')
r=subprocess.run(['lake','env','lean','Check.lean'],capture_output=True,text=True,timeout=3600)
out=r.stdout+r.stderr
if r.returncode!=0 or 'error' in out: fail('Lean error:\n'+out[-3000:])
ax=re.search(r"depends on axioms: \[(.*?)\]",out,re.S)
allowed={'propext','Classical.choice','Quot.sound'}
if ax and set(a.strip() for a in ax.group(1).split(','))-allowed: fail('Uses non-standard axioms: '+ax.group(1))
lines=[l for l in re.sub(r'/-.*?-/','',sol,flags=re.S).splitlines() if l.strip() and not l.strip().startswith('--') and not l.startswith('import ')]
res={'ok':True,'id':pid,'user':user,'model':meta['model'],'kind':meta['kind'],'size':len(lines)}
json.dump(res,open('check_result.json','w')); print('OK',res)
