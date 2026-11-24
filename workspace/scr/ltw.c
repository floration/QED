#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define OFF 50000000L
int *c;
unsigned long long s=88172645463325252ULL;
static inline unsigned long long xr(){s^=s<<13;s^=s>>7;s^=s<<17;return s;}
int main(int argc,char**argv){
  long N=atol(argv[1]); int R=atoi(argv[2]); s+=atoi(argv[3]);
  c=calloc(2*OFF+1,sizeof(int));
  for(int r=0;r<R;r++){
    memset(c,0,(2*OFF+1)*sizeof(int));
    long x=0,ret=0,mx=0,dist=0; long checkpoints[]={1000000,10000000,100000000};
    int ci=0;
    for(long n=1;n<=N;n++){
      if(++c[x+OFF]==1) dist++;
      long k=c[x+OFF];
      x += (xr()>>63)? k : -k;
      if(x>OFF-1||x<-OFF+1){printf("overflow\n");return 0;}
      if(x==0) ret++;
      if(labs(x)>mx) mx=labs(x);
      if(ci<3 && n==checkpoints[ci]){printf("n=%ld returns=%ld max=%ld distinct=%ld x=%ld\n",n,ret,mx,dist,x);ci++;}
    }
  }
}
