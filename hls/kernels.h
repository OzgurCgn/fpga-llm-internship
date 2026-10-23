#pragma once
#define DIM 64
#define SEQ 16
#define HALF_DIM 32
#ifdef __cplusplus
extern "C" {
#endif
void matvec_baseline(const float x[DIM], const float w[DIM*DIM], float y[DIM]);
void matvec_tiled(const float x[DIM], const float w[DIM*DIM], float y[DIM]);
void rmsnorm_kernel(const float x[DIM], const float g[DIM], float y[DIM]);
void softmax_kernel(const float x[SEQ], float y[SEQ]);
void rope_kernel(const float q[DIM], const float k[DIM], const float cs[HALF_DIM], const float sn[HALF_DIM], float qo[DIM], float ko[DIM]);
#ifdef __cplusplus
}
#endif
