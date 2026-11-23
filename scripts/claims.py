"""Rebuild data/claims.json from open 'claim' issues; close claims with no activity from the claimant for 7 days.
Needs GH_TOKEN and GITHUB_REPOSITORY. Activity = issue opened, or a comment by the claimant."""
import os,json,re,subprocess,datetime as dt
R=os.environ['GITHUB_REPOSITORY']
def gh(*a): return json.loads(subprocess.run(['gh','api','--paginate',*a],capture_output=True,text=True,check=True).stdout or '[]')
now=dt.datetime.now(dt.timezone.utc); C={}
for iss in gh(f'repos/{R}/issues?state=open&labels=claim&per_page=100'):
    m=re.search(r'N-\d{3}',iss['title'])
    if not m: continue
    user=iss['user']['login']; last=iss['created_at']
    for c in gh(iss['comments_url']+'?per_page=100'):
        if c['user']['login']==user: last=max(last,c['created_at'])
    age=now-dt.datetime.fromisoformat(last.replace('Z','+00:00'))
    if age>dt.timedelta(days=7):
        subprocess.run(['gh','issue','close',str(iss['number']),'-R',R,'-c','Claim expired: no update from the claimant for 7 days. Reopen or open a new claim any time.'])
        continue
    C.setdefault(m.group(0),[]).append(dict(user=user,since=iss['created_at'],last=last,issue=iss['html_url']))
json.dump(C,open('data/claims.json','w'),indent=1); print(sum(map(len,C.values())),'active claims')
