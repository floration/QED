#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define W 2001
unsigned long long s=88172645463325252ULL;
static inline unsigned long long xr(){s^=s<<13;s^=s>>7;s^=s<<17;return s;}
char occ[W][W]; int nb[W][W]; 
int *cx,*cy,*pos; int nc=0; // candidate list: empty sites with exactly one occ nbr
int idx(int x,int y){return x*W+y;}
void add(int x,int y){ pos[idx(x,y)]=nc; cx[nc]=x; cy[nc]=y; nc++; }
void rem(int x,int y){ int p=pos[idx(x,y)]; if(p<0)return; nc--; cx[p]=cx[nc]; cy[p]=cy[nc]; pos[idx(cx[p],cy[p])]=p; pos[idx(x,y)]=-1; }
int dx[4]={1,-1,0,0},dy[4]={0,0,1,-1};
void occupy(int x,int y){
  occ[x][y]=1; rem(x,y);
  for(int d=0;d<4;d++){int u=x+dx[d],v=y+dy[d]; nb[u][v]++; if(!occ[u][v]){ if(nb[u][v]==1) add(u,v); else if(nb[u][v]==2) rem(u,v);} }
}
int main(int argc,char**argv){
  s+=atoi(argv[1]); long N=atol(argv[2]);
  cx=malloc(sizeof(int)*W*W);cy=malloc(sizeof(int)*W*W);pos=malloc(sizeof(int)*W*W);
  for(long i=0;i<W*W;i++)pos[i]=-1;
  int c=W/2; occupy(c,c);
  long n=1;
  while(n<N){ int k=xr()%nc; int x=cx[k],y=cy[k]; if(x<2||y<2||x>W-3||y>W-3)break; occupy(x,y); n++; }
  // density in disks around center, extent in axis and diagonal
  int R[]={50,100,200,400};
  for(int r=0;r<4;r++){ long cnt=0,tot=0; for(int x=-R[r];x<=R[r];x++)for(int y=-R[r];y<=R[r];y++) if(x*x+y*y<=R[r]*R[r]){tot++;cnt+=occ[c+x][c+y];} printf("r=%d density=%.4f\n",R[r],(double)cnt/tot);}
  int ax=0; while(occ[c+ax+1][c]||occ[c+ax+2][c]||occ[c+ax+3][c]) ax++; 
  long maxr2=0, maxax=0,maxdg=0; for(int x=0;x<W;x++)for(int y=0;y<W;y++) if(occ[x][y]){int X=x-c,Y=y-c; if(abs(X)+abs(Y)>maxdg)maxdg=abs(X)+abs(Y); int m=abs(X)>abs(Y)?abs(X):abs(Y); if(m>maxax)maxax=m;}
  printf("n=%ld linf=%ld l1=%ld ratio l1/linf=%.3f\n",n,maxax,maxdg,(double)maxdg/maxax);
}
