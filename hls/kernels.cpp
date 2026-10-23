#include "kernels.h"
#include <cmath>
extern "C" void matvec_baseline(const float x[DIM],const float w[DIM*DIM],float y[DIM]){
#pragma HLS INTERFACE m_axi port=x offset=slave bundle=gmem0
#pragma HLS INTERFACE m_axi port=w offset=slave bundle=gmem1
#pragma HLS INTERFACE m_axi port=y offset=slave bundle=gmem2
#pragma HLS INTERFACE s_axilite port=return bundle=control
for(int i=0;i<DIM;i++){float s=0;for(int j=0;j<DIM;j++)s+=w[i*DIM+j]*x[j];y[i]=s;}
}
extern "C" void matvec_tiled(const float x[DIM],const float w[DIM*DIM],float y[DIM]){
#pragma HLS INTERFACE m_axi port=x offset=slave bundle=gmem0
#pragma HLS INTERFACE m_axi port=w offset=slave bundle=gmem1
#pragma HLS INTERFACE m_axi port=y offset=slave bundle=gmem2
#pragma HLS INTERFACE s_axilite port=return bundle=control
float b[DIM];
#pragma HLS ARRAY_PARTITION variable=b cyclic factor=4
for(int j=0;j<DIM;j++)b[j]=x[j];
for(int i=0;i<DIM;i++){float s=0;for(int j=0;j<DIM;j+=4){
#pragma HLS PIPELINE II=1
s+=w[i*DIM+j]*b[j]+w[i*DIM+j+1]*b[j+1]+w[i*DIM+j+2]*b[j+2]+w[i*DIM+j+3]*b[j+3];}y[i]=s;}
}
extern "C" void rmsnorm_kernel(const float x[DIM],const float g[DIM],float y[DIM]){
float s=0;for(int i=0;i<DIM;i++)s+=x[i]*x[i];float k=1.0f/std::sqrt(s/DIM+1e-5f);
for(int i=0;i<DIM;i++)y[i]=x[i]*k*g[i];
}
extern "C" void softmax_kernel(const float x[SEQ],float y[SEQ]){
float m=x[0];for(int i=1;i<SEQ;i++)if(x[i]>m)m=x[i];
float s=0;for(int i=0;i<SEQ;i++){y[i]=std::exp(x[i]-m);s+=y[i];}
for(int i=0;i<SEQ;i++)y[i]/=s;
}
extern "C" void rope_kernel(const float q[DIM],const float k[DIM],const float cs[HALF_DIM],const float sn[HALF_DIM],float qo[DIM],float ko[DIM]){
for(int i=0;i<HALF_DIM;i++){int j=2*i;qo[j]=q[j]*cs[i]-q[j+1]*sn[i];qo[j+1]=q[j]*sn[i]+q[j+1]*cs[i];ko[j]=k[j]*cs[i]-k[j+1]*sn[i];ko[j+1]=k[j]*sn[i]+k[j+1]*cs[i];}
}
