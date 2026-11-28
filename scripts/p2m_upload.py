"""Create one Prove2Me mission proposal per QED problem (definition item + goal theorem).
Usage: P2M_API_KEY=... python3 scripts/p2m_upload.py [main|extended|all|QED-M004,QED-E010,...] [--dry]
Idempotent: problems that already have a proposal (matched by name prefix "QED-XXXX:") are skipped.
Proposals stay Drafts: the account owner audits and clicks Submit Proposal on prove2.me (human-only step)."""
import json,os,re,sys,subprocess
sys.path.insert(0,os.path.dirname(os.path.abspath(__file__))); import p2m_api as A
R=os.path.join(os.path.dirname(os.path.abspath(__file__)),'..')
sel=sys.argv[1] if len(sys.argv)>1 else 'main'; dry='--dry' in sys.argv
subprocess.run([sys.executable,os.path.join(R,'scripts/p2m_export.py'),'/tmp/p2m_out'],check=True)
PAY={x['id']:x for x in json.load(open('/tmp/p2m_out/payload.json'))}
D={p['id']:p for f in ('data/main.json','data/extended.json') for p in json.load(open(os.path.join(R,f)))}
ids=[i for i in PAY if sel=='all' or PAY[i]['set']==sel] if sel in('main','extended','all') else sel.split(',')
AREA={'Combinatorics':['combinatorics'],'Number theory':['number theory','number-theory'],'Geometry':['geometry'],'Analysis':['analysis'],
 'Dynamics':['dynamical','dynamics'],'Algebra':['algebra'],'Graph theory':['graph','combinatorics'],'Complexity':['complexity','computer science','combinatorics & cs'],
 'Logic & computability':['logic','computability'],'PDE':['pde','partial differential'],'Probability':['probability'],'Mathematical physics':['physics'],
 'Topology':['topology'],'Coding & information theory':['information','coding'],'Games':['game','combinatorics']}
FIELDS=[] if dry else A.get('/fields?limit=200&sort=popular')['fields']
def field_ids(area):
    for q in AREA.get(area,[area.lower()]):
        for f in FIELDS:
            if q in f['name'].lower() or q.replace(' ','-') in f['slug']: return [f['id']]
    return []
def esc(s): return s or ''
def description(p):
    lean_doc=re.search(r'/-!(.*?)-/',p['lean'],re.S); notes=lean_doc.group(1).strip() if lean_doc else ''
    fn=notes.split('Formalization notes:',1)[1].strip() if 'Formalization notes:' in notes else ''
    refs='\n'.join(f'- <{u}>' for u in (p.get('refs') or []))
    risks='\n'.join(f'- {r}' for r in (p.get('premise_risks') or []))
    s=[f'*This mission mirrors [{p["id"]}](https://floration.github.io/QED/#{p["id"]}) on the QED board of open problems. A proof (or disproof) accepted here can be submitted to QED unchanged.*',
       '## Motivation',esc(p['plain']),
       '## Setting and target',esc(p['math']),
       '## Significance',f'QED difficulty estimate: {p.get("difficulty")}/10 on an anchored scale (1 ≈ Erdős–Ginzburg–Ziv, 2.5 ≈ the sensitivity conjecture, 5 ≈ bounded prime gaps, 7.5 ≈ the Riemann Hypothesis, 10 ≈ P vs NP). Provenance on QED: {p.get("provenance") or "unlabelled"}.'+(f'\n\nKnown partial results: {p["results"]}' if p.get('results') else '')]
    if risks: s+=['## Status notes',risks]
    s+=['## Formalization scope',
        f'The definition `QED_{p["id"].split("-")[1]}` is QED\'s official statement file verbatim (namespace `OpenProblems.{p["id"].replace("-","")}`), which defines the proposition `Claim`. The goal theorem asserts `Claim`; per Prove2Me rules, a disproof proves `¬ Claim`, and either outcome resolves the problem.'+(f'\n\n{fn}' if fn else ''),
        '## Selected references',refs or '- see the QED problem page']
    return '\n\n'.join(s)
existing={re.match(r'(QED-[A-Z]\d+):',x.get('name','')).group(1):x for x in ([] if dry else A.proposals()) if re.match(r'QED-[A-Z]\d+:',x.get('name',''))}
done=0
for i in ids:
    if i in existing: print('skip',i,'(proposal exists)'); continue
    p=D[i]; x=PAY[i]; d=x['definition_name']
    prop=dict(name=f'{i}: {p["title"]}'[:200],description=description(p),mission_type='OpenProblem',field_ids=field_ids(p['area']))
    defi=dict(kind='definition',definition_name=d,definition_title=f'{i} statement definitions',definition=x['definition'],
              natural_language_statement=f'Definitions for the QED problem {i}, ending with the proposition `Claim`.\n\n{esc(p["math"])}',
              source=f'QED open problem {i}, https://floration.github.io/QED/#{i}',tags=['qed',p['area'].lower()])
    thm=dict(kind='theorem',theorem_name=x['theorem_name'],theorem_title=p['title'][:200],formal_statement=x['formal_statement'],
             natural_language_statement=esc(p['math']),preamble=x['preamble'],source=f'QED open problem {i}, https://floration.github.io/QED/#{i}',tags=['qed',p['area'].lower()])
    if dry: print(json.dumps(dict(proposal=prop,items=[defi,thm]),ensure_ascii=False)[:3000]); continue
    pr=A.post('/mission-proposals',prop); di=A.post(f'/mission-proposals/{pr["id"]}/items',defi); ti=A.post(f'/mission-proposals/{pr["id"]}/items',thm)
    A.patch(f'/mission-proposals/{pr["id"]}',dict(main_item_id=ti['id'],item_order=[di['id'],ti['id']]))
    done+=1; print('created',i,pr['id'],'fields',prop['field_ids'])
print(done,'proposals created')
