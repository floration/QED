"""Hourly: find QED goal theorems on Prove2Me that are Proved/Disproved and open a GitHub issue with the accepted solution.
Stateless: discovers QED theorems from this account's mission proposals. Needs P2M_API_KEY and GH_TOKEN."""
import json,os,re,subprocess,sys
sys.path.insert(0,os.path.dirname(os.path.abspath(__file__))); import p2m_api as A
gh=lambda *a:subprocess.run(['gh',*a],capture_output=True,text=True,check=True).stdout
known=gh('issue','list','--label','p2m-solved','--state','all','--limit','500','--json','title')
found=0
for pr in A.proposals():
    m=re.match(r'(QED-[A-Z]\d+):',pr.get('name',''))
    if not m: continue
    det=A.get(f'/mission-proposals/{pr["id"]}')
    goal=next((it for it in det.get('items',[]) if it.get('id')==det.get('main_item_id')),None)
    tid=goal and goal.get('theorem_id')
    if not tid: continue                                   # not yet launched
    th=A.get(f'/theorems/{tid}'); st=th.get('status')
    print(m.group(1),pr.get('status'),st)
    if st not in ('Proved','Disproved') or f'{m.group(1)} ' in known: continue
    sub=A.get(f'/theorems/{tid}/submissions?first=true'); s=(sub.get('submissions') or [sub])[0] if isinstance(sub,dict) else sub[0]
    src=A.get(f'/submissions/{s["id"]}/solution').get('content','')
    who=(s.get('user') or {}).get('username') or s.get('username') or 'unknown'
    body=f'{m.group(1)} was **{st.lower()}** on Prove2Me by `{who}` (submission {s["id"]}).\n\nImport it as `solutions/{m.group(1)}/<user>/Solution.lean` so the QED verifier checks it.\n\n```lean\n{src}\n```'
    gh('issue','create','--title',f'{m.group(1)} {st.lower()} on Prove2Me','--label','p2m-solved','--body',body[:60000]); found+=1
print(found,'new results')
