#include "common/common.hpp"
#include <cassert>
#include <cstdio>

extern "C" void sw4_gold (float*, float*, float*, float*, float*, float*, float*, float*, float*, float*, float*, int);
extern "C" void host_code (float*, float*, float*, float*, float*, float*, float*, float*, float*, float*, float*, int);

int main(int argc, char** argv) {
  int N = 304; 

  float (*u_0)[304][304] = (float (*)[304][304]) getRandom3DArray<float>(304, 304, 304);
  float (*u_1)[304][304] = (float (*)[304][304]) getRandom3DArray<float>(304, 304, 304);
  float (*u_2)[304][304] = (float (*)[304][304]) getRandom3DArray<float>(304, 304, 304);
  float (*mu)[304][304] = (float (*)[304][304]) getRandom3DArray<float>(304, 304, 304);
  float (*la)[304][304] = (float (*)[304][304]) getRandom3DArray<float>(304, 304, 304);
  float *strx = (float *) getRandom1DArray<float>(304);
  float *stry = (float *) getRandom1DArray<float>(304);
  float *strz = (float *) getRandom1DArray<float>(304);
  float (*uacc_gold_0)[304][304] = (float (*)[304][304]) getRandom3DArray<float>(304, 304, 304);
  float (*uacc_gold_1)[304][304] = (float (*)[304][304]) getRandom3DArray<float>(304, 304, 304);
  float (*uacc_gold_2)[304][304] = (float (*)[304][304]) getRandom3DArray<float>(304, 304, 304);
  float (*uacc_0)[304][304] = (float (*)[304][304]) getZero3DArray<float>(304, 304, 304);
  float (*uacc_1)[304][304] = (float (*)[304][304]) getZero3DArray<float>(304, 304, 304);
  float (*uacc_2)[304][304] = (float (*)[304][304]) getZero3DArray<float>(304, 304, 304);
  memcpy(uacc_0, uacc_gold_0, sizeof(float)*N*N*N);
  memcpy(uacc_1, uacc_gold_1, sizeof(float)*N*N*N);
  memcpy(uacc_2, uacc_gold_2, sizeof(float)*N*N*N);

  if (argc == 2) {
  sw4_gold ((float*)uacc_gold_0, (float*)uacc_gold_1, (float*)uacc_gold_2, (float*)u_0, (float*)u_1, (float*)u_2, (float*)mu, (float*)la, (float*)strx, (float*)stry, (float*)strz, N);
  host_code ((float*)uacc_0, (float*)uacc_1, (float*)uacc_2, (float*)u_0, (float*)u_1, (float*)u_2, (float*)mu, (float*)la, (float*)strx, (float*)stry, (float*)strz, N);

  float error_0 = checkError3D<float> (N, N, (float*)uacc_0, (float*)uacc_gold_0, 2, N-2, 2, N-2, 2, N-2);
  printf("[Test] RMS Error : %e\n",error_0);
  if (error_0 > TOLERANCE)
    return -1;
  float error_1 = checkError3D<float> (N, N, (float*)uacc_1, (float*)uacc_gold_1, 2, N-2, 2, N-2, 2, N-2);
  printf("[Test] RMS Error : %e\n",error_1);
  if (error_1 > TOLERANCE)
    return -1;
  float error_2 = checkError3D<float> (N, N, (float*)uacc_2, (float*)uacc_gold_2, 2, N-2, 2, N-2, 2, N-2);
  printf("[Test] RMS Error : %e\n",error_2);
  if (error_2 > TOLERANCE)
    return -1;
}
else
  for (int t=0; t < 10; t++)
  host_code ((float*)uacc_0, (float*)uacc_1, (float*)uacc_2, (float*)u_0, (float*)u_1, (float*)u_2, (float*)mu, (float*)la, (float*)strx, (float*)stry, (float*)strz, N);


  delete[] strx;
  delete[] stry;
  delete[] strz;
  delete[] u_0;
  delete[] u_1;
  delete[] u_2;
  delete[] mu;
  delete[] la;
  delete[] uacc_0;
  delete[] uacc_1;
  delete[] uacc_2;
  delete[] uacc_gold_0;
  delete[] uacc_gold_1;
  delete[] uacc_gold_2;
}
