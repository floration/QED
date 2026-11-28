"""Export every live QED problem as a Prove2Me mission payload.
For problem QED-M004 (Lean namespace OpenProblems.QEDM004):
  definition  QED_M004                  = the official statement file, verbatim (defs + Claim)
  theorem     OpenProblems.QEDM004.claim : Claim   (preamble imports the definition)
So a Prove2Me `solution : OpenProblems.QEDM004.Claim` is exactly a QED solution.
Writes p2m/Definitions, p2m/Theorems (a Lake layout for local compile checks) and p2m/payload.json."""
import json,os,re,sys
R=os.path.join(os.path.dirname(os.path.abspath(__file__)),'..'); O=sys.argv[1] if len(sys.argv)>1 else os.path.join(R,'p2m')
P=[]
for f,s in (('data/main.json','main'),('data/extended.json','extended')):
    for p in json.load(open(os.path.join(R,f))): p['_set']=s; P.append(p)
os.makedirs(O+'/Definitions',exist_ok=True); os.makedirs(O+'/Theorems',exist_ok=True)
out=[]
for p in P:
    i=p['id']; ns='OpenProblems.'+i.replace('-','')
    assert f'namespace {ns}' in p['lean'] and re.search(r'\bdef Claim\b',p['lean']), i
    dname='QED_'+i.split('-')[1]; tname=ns+'.claim'
    pre=f'import Mathlib\nimport Definitions.Def_{dname}'
    stmt=f'namespace {ns}\ntheorem claim : Claim := by sorry\nend {ns}'
    open(f'{O}/Definitions/Def_{dname}.lean','w').write(p['lean'].rstrip()+'\n')
    open(f'{O}/Theorems/Thm_{tname.replace(".","_")}.lean','w').write(pre+'\n\n'+stmt+'\n')
    out.append(dict(id=i,set=p['_set'],title=p['title'],definition_name=dname,definition=p['lean'],
                    theorem_name=tname,preamble=pre,formal_statement=stmt))
json.dump(out,open(O+'/payload.json','w'),ensure_ascii=False,indent=1)
print(len(out),'problems exported to',O)
