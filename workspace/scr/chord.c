#include <stdio.h>
#include <stdlib.h>
#include <math.h>
unsigned long long s=88172645463325252ULL;
static inline double U(){s^=s<<13;s^=s>>7;s^=s<<17;return (s>>11)*(1.0/9007199254740992.0);}
double A[2000000],B[2000000]; int m=0;
int cross(double a,double b,double c,double d){ // chords (a,b),(c,d), a<b, c<d
  int in1=(c>a&&c<b), in2=(d>a&&d<b); return in1!=in2;}
int main(int argc,char**argv){
  long N=atol(argv[1]); s+=atoi(argv[2]);
  long next=1000;
  for(long n=1;n<=N;n++){
    double a=U(),b=U(); if(a>b){double t=a;a=b;b=t;}
    int ok=1; for(int i=0;i<m;i++) if(cross(a,b,A[i],B[i])){ok=0;break;}
    if(ok){A[m]=a;B[m]=b;m++;}
    if(n==next){printf("n=%ld accepted=%d ratio=%f\n",n,m,m/pow(n,0.5)); next*=4;}
  }
}
