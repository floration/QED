"""Render the link-preview card (site/og.png) from live data: one dot per open problem,
coloured by difficulty, solved problems lit green, with live counts. Run by update.yml."""
import json,os,sys
from PIL import Image,ImageDraw,ImageFont,ImageFilter
R=os.path.join(os.path.dirname(os.path.abspath(__file__)),'..'); FD=os.path.join(R,'scripts','fonts')
out=sys.argv[1] if len(sys.argv)>1 else os.path.join(R,'site','og.png')
P=json.load(open(os.path.join(R,'data/main.json')))+json.load(open(os.path.join(R,'data/extended.json')))
try: SOL=json.load(open(os.path.join(R,'data/solutions.json')))
except Exception: SOL={}
n=len(P); new=sum(p.get('provenance') in ('Original','Extension') for p in P)
solved={p['id'] for p in P if p['id'] in SOL}; ns=len(solved)
W,H,S=1200,630,2
img=Image.new('RGB',(W*S,H*S),(7,8,11))
def glow(cx,cy,rad,col):
    g=Image.new('RGBA',img.size,(0,0,0,0)); ImageDraw.Draw(g).ellipse([cx-rad,cy-rad,cx+rad,cy+rad],fill=col+(255,))
    g=g.filter(ImageFilter.GaussianBlur(rad/2)); img.paste(g,(0,0),g)
glow(180*S,-80*S,480*S,(34,26,70)); glow(1230*S,60*S,420*S,(12,46,36))
def var(f,size,axes):
    x=ImageFont.truetype(os.path.join(FD,f),size*S); x.set_variation_by_axes(axes); return x
fr=var('Fraunces.ttf',250,[144,800,0,0]); jb=lambda sz:var('JetBrainsMono.ttf',sz,[500])
inter=lambda sz,w='Regular':ImageFont.truetype(os.path.join(FD,f'Inter-{w}.otf'),sz*S)
d=ImageDraw.Draw(img); X=72*S
d.text((X,70*S),'OPEN PROBLEMS  ·  LEAN  ·  MATHLIB',font=jb(19),fill=(201,184,255))
bb=d.textbbox((0,0),'QED',font=fr)
m=Image.new('L',img.size,0); ImageDraw.Draw(m).text((X-bb[0],118*S-bb[1]),'QED',font=fr,fill=255)
grad=Image.new('RGB',img.size); gd=ImageDraw.Draw(grad); x0,x1=X,X+bb[2]-bb[0]
stops=[(0,(255,255,255)),(.35,(255,255,255)),(.72,(201,184,255)),(1,(61,220,132))]
for x in range(img.size[0]):
    t=min(1,max(0,(x-x0)/(x1-x0)))
    for (a,ca),(b,cb) in zip(stops,stops[1:]):
        if a<=t<=b: u=(t-a)/(b-a); c=tuple(int(ca[k]+(cb[k]-ca[k])*u) for k in range(3)); break
    gd.line([(x,0),(x,img.size[1])],fill=c)
img.paste(grad,(0,0),m)
y=118*S+(bb[3]-bb[1])+40*S
d.text((X,y),f'{n} open problems,',font=inter(36,'SemiBold'),fill=(236,235,230))
d.text((X,y+50*S),'newly stated in Lean.',font=inter(36,'SemiBold'),fill=(236,235,230))
d.text((X,y+108*S),'Prove one and it\'s checked automatically.',font=inter(22),fill=(160,163,170))
# live tally
ty=H*S-70*S; f=jb(20)
d.ellipse([X,ty+7*S,X+12*S,ty+19*S],fill=(61,220,132)); d.text((X+22*S,ty),f'{ns} SOLVED',font=f,fill=(61,220,132))
x2=X+22*S+d.textlength(f'{ns} SOLVED',font=f)+34*S
d.ellipse([x2,ty+7*S,x2+12*S,ty+19*S],fill=(150,140,200)); d.text((x2+22*S,ty),f'{n-ns} OPEN',font=f,fill=(170,165,205))
x3=x2+22*S+d.textlength(f'{n-ns} OPEN',font=f)+34*S
d.text((x3,ty),'floration.github.io/QED',font=f,fill=(110,114,122))
# dot field: one dot per problem, easier → harder; solved dots are lit green
P.sort(key=lambda p:(float(p.get('difficulty') or 5),p['id']))
cols=14; rows=-(-n//cols); gap=min(24*S,int((H*S-170*S)/rows)); r=int(gap*0.31)
gx=W*S-80*S-(cols-1)*gap; gy=86*S
ds=[float(p.get('difficulty') or 5) for p in P]; lo,hi=min(ds),max(ds)
def col(v):
    t=(v-lo)/((hi-lo) or 1); a,b=(120,130,190),(205,95,110)
    return tuple(int(a[k]+(b[k]-a[k])*t) for k in range(3))
pts=[(gx+(i%cols)*gap,gy+(i//cols)*gap,p['id'] in solved,col(v)) for i,(p,v) in enumerate(zip(P,ds))]
gl=Image.new('RGBA',img.size,(0,0,0,0)); gld=ImageDraw.Draw(gl)
for cx,cy,s,c in pts:
    if s: gld.ellipse([cx-r*2.2,cy-r*2.2,cx+r*2.2,cy+r*2.2],fill=(61,220,132,200))
gl=gl.filter(ImageFilter.GaussianBlur(7*S)); img.paste(gl,(0,0),gl)
for cx,cy,s,c in pts:
    d.ellipse([cx-r,cy-r,cx+r,cy+r],fill=(61,220,132) if s else c)
d.text((gx-r,gy+rows*gap),'one dot per problem · easier → harder',font=jb(14),fill=(110,114,122))
img.resize((W,H),Image.LANCZOS).save(out,optimize=True)
print(f'og image: {ns}/{n} solved, {new} new -> {out}')
