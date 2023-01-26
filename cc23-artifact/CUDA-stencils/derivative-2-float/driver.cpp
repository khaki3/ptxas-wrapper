#include "common/common.hpp"
#include <cassert>
#include <cstdio>

extern "C" void derivative_gold (float *h_r1, float *h_u1, float *h_u2, float *h_u3, float *h_mu, float *h_la, float *h_met1, float *h_met2, float *h_met3, float *h_met4, float *, float *, float c1, float c2, int N); 
extern "C" void host_code (float *h_r1, float *h_u1, float *h_u2, float *h_u3, float *h_mu, float *h_la, float *h_met1, float *h_met2, float *h_met3, float *h_met4, float *, float *, float c1, float c2, int N); 

int main(int argc, char** argv) {
  int N = 304; 

  float (*r_gold_0)[304][304] = (float (*)[304][304]) getRandom3DArray<float>(304, 304, 304);
  float (*mu)[304][304] = (float (*)[304][304]) getRandom3DArray<float>(304, 304, 304);
  float (*la)[304][304] = (float (*)[304][304]) getRandom3DArray<float>(304, 304, 304);
  float (*met1)[304][304] = (float (*)[304][304]) getRandom3DArray<float>(304, 304, 304);
  float (*met2)[304][304] = (float (*)[304][304]) getRandom3DArray<float>(304, 304, 304);
  float (*met3)[304][304] = (float (*)[304][304]) getRandom3DArray<float>(304, 304, 304);
  float (*met4)[304][304] = (float (*)[304][304]) getRandom3DArray<float>(304, 304, 304);
  float (*u1)[304][304] = (float (*)[304][304]) getRandom3DArray<float>(304, 304, 304);
  float (*u2)[304][304] = (float (*)[304][304]) getRandom3DArray<float>(304, 304, 304);
  float (*u3)[304][304] = (float (*)[304][304]) getRandom3DArray<float>(304, 304, 304);
  float (*r_0)[304][304] = (float (*)[304][304]) getZero3DArray<float>(304, 304, 304);
  memcpy(r_0, r_gold_0, sizeof(float)*304*304*304);
  float *strx = (float *) getRandom1DArray<float>(304);
  float *stry = (float *) getRandom1DArray<float>(304);
 
  float c1 = 0.32;
  float c2 = 0.43;
  if (argc == 2){
  derivative_gold ((float*)r_gold_0, (float *)u1, (float *)u2, (float *)u3, (float*)mu, (float*)la, (float*)met1, (float*)met2, (float *)met3, (float*)met4, strx, stry, c1, c2, N);
  host_code ((float*)r_0, (float *)u1, (float *)u2, (float *)u3, (float*)mu, (float*)la, (float*)met1, (float*)met2, (float *)met3, (float*)met4, strx, stry, c1, c2, N);
  float error_0 = checkError3D<float> (N, N, (float*)r_0, (float*)r_gold_0, 2, N-2, 2, N-2, 2, N-2);
  printf("[Test] RMS Error : %e\n",error_0);
  if (error_0 > TOLERANCE)
    return -1;
  }
  else
  for (int t = 0; t < 10; t++)
    host_code ((float*)r_0, (float *)u1, (float *)u2, (float *)u3, (float*)mu, (float*)la, (float*)met1, (float*)met2, (float *)met3, (float*)met4, strx, stry, c1, c2, N);
}
