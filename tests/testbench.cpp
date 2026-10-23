#include "../hls/kernels.h"
#include <cmath>
#include <cstdio>
#include <random>
#include <algorithm>
int main(){
std::mt19937 rng(2026);std::uniform_real_distribution<float>d(-0.8f,0.8f);
float x[DIM],w[DIM*DIM],b[DIM],t[DIM],g[DIM],n[DIM];
for(float &v:x)v=d(rng);for(float &v:w)v=d(rng);for(float &v:g)v=1.f+.1f*d(rng);
matvec_baseline(x,w,b);matvec_tiled(x,w,t);float err=0;
for(int i=0;i<DIM;i++)err=std::max(err,std::abs(b[i]-t[i]));
if(err>1e-4f){printf("FAIL matvec error=%g\n",err);return 1;}
printf("PASS MatVec baseline vs tiled max_abs_error=%g\n",err);
rmsnorm_kernel(x,g,n);float s=0;for(float v:x)s+=v*v;
float scale=1.f/std::sqrt(s/DIM+1e-5f);for(int i=0;i<DIM;i++)if(std::abs(n[i]-x[i]*scale*g[i])>1e-5f)return 2;
puts("PASS RMSNorm");
float logits[SEQ],p[SEQ];for(float &v:logits)v=10*d(rng);logits[0]=120.f;logits[1]=-110.f;
softmax_kernel(logits,p);s=0;for(float v:p){if(!std::isfinite(v)||v<0)return 3;s+=v;}if(std::abs(s-1.f)>1e-5f)return 4;
puts("PASS numerically stable Softmax");
float cs[HALF_DIM],sn[HALF_DIM],qo[DIM],ko[DIM];
for(int i=0;i<HALF_DIM;i++){cs[i]=std::cos(.04f*i);sn[i]=std::sin(.04f*i);}
rope_kernel(x,g,cs,sn,qo,ko);for(int i=0;i<HALF_DIM;i++){int j=2*i;float norm=x[j]*x[j]+x[j+1]*x[j+1];float rn=qo[j]*qo[j]+qo[j+1]*qo[j+1];if(std::abs(norm-rn)>1e-5f)return 5;}
puts("PASS RoPE preserves pair norm");return 0;
}
