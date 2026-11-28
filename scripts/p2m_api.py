"""Minimal Prove2Me API client. Reads the API key from env P2M_API_KEY (a GitHub Actions secret)."""
import json,os,time,urllib.request,urllib.error
BASE='https://prove2.me/api/v1'; _tok=[None,0]
def _req(method,path,body=None,auth=True):
    h={'Content-Type':'application/json','Accept':'application/json'}
    if auth: h['Authorization']='Bearer '+token()
    r=urllib.request.Request(BASE+path,data=None if body is None else json.dumps(body).encode(),headers=h,method=method)
    for attempt in range(4):
        try:
            with urllib.request.urlopen(r,timeout=60) as f:
                t=f.read(); return json.loads(t) if t else None
        except urllib.error.HTTPError as e:
            if e.code in (429,502,503,504) and attempt<3: time.sleep(5*2**attempt); continue
            raise RuntimeError(f'{method} {path} -> {e.code}: {e.read()[:500]!r}')
def token():
    if not _tok[0] or time.time()>_tok[1]-120:
        r=_req('POST','/agent/refresh',{'api_key':os.environ['P2M_API_KEY']},auth=False)
        _tok[0],_tok[1]=r['access_token'],r['expires_at']; print('prove2me platform version',r.get('version'))
    return _tok[0]
get=lambda p:_req('GET',p); post=lambda p,b:_req('POST',p,b); patch=lambda p,b:_req('PATCH',p,b)
def proposals():
    out,off=[],0
    while True:
        r=get(f'/mission-proposals?limit=100&offset={off}'); L=r.get('proposals',r.get('items',[])) if isinstance(r,dict) else r
        out+=L; off+=len(L)
        if len(L)<100: return out
