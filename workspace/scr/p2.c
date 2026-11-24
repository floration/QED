#include <stdio.h>
#include <stdlib.h>
typedef unsigned long long u64; typedef __uint128_t u128;
int N; u128 forb[130]; long long cnt;
// count subsets of {0..N-1} with no two elements differing by power of 2
long long rec(int i, u128 banned){
  if(i==N) return 1;
  long long c=rec(i+1,banned);
  if(!((banned>>i)&1)) c+=rec(i+1,banned|forb[i]);
  return c;
}
int main(){
  for(N=10;N<=56;N+=6){
    for(int i=0;i<N;i++){forb[i]=0; for(int p=1;i+p<N;p<<=1) forb[i]|=((u128)1)<<(i+p);}
    long long c=rec(0,0);
    printf("N=%d count=%lld rate=%.5f\n",N,c,__builtin_log2((double)c)/N);
    fflush(stdout);
  }
}
