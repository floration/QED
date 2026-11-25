import json,sys
d=json.loads(sys.stdin.read())
ids=set()
try:
    for l in open('out2.jsonl'): ids.add(json.loads(l)['id'])
except FileNotFoundError: pass
if d['id'] in ids: print('skip'); sys.exit()
open('out2.jsonl','a').write(json.dumps(d,ensure_ascii=False)+'\n'); print('ok',d['id'])
