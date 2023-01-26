#include <stdio.h>
#include "cuda.h"
#define max(x,y)  ((x) > (y)? (x) : (y))
#define min(x,y)  ((x) < (y)? (x) : (y))
#define ceil(a,b) ((a) % (b) == 0 ? (a) / (b) : ((a) / (b)) + 1)

void check_error (const char* message) {
	cudaError_t error = cudaGetLastError ();
	if (error != cudaSuccess) {
		printf ("CUDA error : %s, %s\n", message, cudaGetErrorString (error));
		exit(-1);
	}
}

__global__ void curvi (float * __restrict__ r1, float *__restrict__ in_u1, float * __restrict__ in_u2, float *__restrict__ in_u3, float * __restrict__ in_mu, float * __restrict__ in_la, float * __restrict__ in_met1, float * __restrict__ in_met2, float * __restrict__ in_met3, float * __restrict__ in_met4, float * __restrict__ strx, float * __restrict__ stry, float c1, float c2, int N) {
	//Determing the block's indices
	int blockdim_k= (int)(blockDim.x);
	int k0 = (int)(blockIdx.x)*(blockdim_k);
	int k = max (k0, 0) + (int)(threadIdx.x);
	int blockdim_j= (int)(blockDim.y);
	int j0 = (int)(blockIdx.y)*(blockdim_j);
	int j = max (j0, 0) + (int)(threadIdx.y);

	float (*u1)[304][304] = (float (*)[304][304])in_u1;
	float (*u2)[304][304] = (float (*)[304][304])in_u2;
	float (*u3)[304][304] = (float (*)[304][304])in_u3;
	float (*mu)[304][304] = (float (*)[304][304])in_mu;
	float (*la)[304][304] = (float (*)[304][304])in_la;
	float (*met1)[304][304] = (float (*)[304][304])in_met1;
	float (*met2)[304][304] = (float (*)[304][304])in_met2;
	float (*met3)[304][304] = (float (*)[304][304])in_met3;
	float (*met4)[304][304] = (float (*)[304][304])in_met4;

	if (j>=2 & k>=2 & j<=N-3 & k<=N-3) {
		for (int i=2; i<=N-3; i++) {
		r1[i*N*N+j*N+k] +=
			c2*(  mu[i][j+2][k]*met1[i][j+2][k]*met1[i][j+2][k]*(
						c2*(u2[i+2][j+2][k]-u2[i-2][j+2][k]) +
						c1*(u2[i+1][j+2][k]-u2[i-1][j+2][k])    )
					+  mu[i][j-2][k]*met1[i][j-2][k]*met1[i][j-2][k]*(
						c2*(u2[i+2][j-2][k]-u2[i-2][j-2][k])+
						c1*(u2[i+1][j-2][k]-u2[i-1][j-2][k])     )
			   ) +
			c1*(  mu[i][j+1][k]*met1[i][j+1][k]*met1[i][j+1][k]*(
						c2*(u2[i+2][j+1][k]-u2[i-2][j+1][k]) +
						c1*(u2[i+1][j+1][k]-u2[i-1][j+1][k])  )
					+ mu[i][j-1][k]*met1[i][j-1][k]*met1[i][j-1][k]*(
						c2*(u2[i+2][j-1][k]-u2[i-2][j-1][k]) +
						c1*(u2[i+1][j-1][k]-u2[i-1][j-1][k])))
			+
			c2*(  la[i+2][j][k]*met1[i+2][j][k]*met1[i+2][j][k]*(
						c2*(u2[i+2][j+2][k]-u2[i+2][j-2][k]) +
						c1*(u2[i+2][j+1][k]-u2[i+2][j-1][k])    )
					+ la[i-2][j][k]*met1[i-2][j][k]*met1[i-2][j][k]*(
						c2*(u2[i-2][j+2][k]-u2[i-2][j-2][k])+
						c1*(u2[i-2][j+1][k]-u2[i-2][j-1][k])     )
			   ) +
			c1*(  la[i+1][j][k]*met1[i+1][j][k]*met1[i+1][j][k]*(
						c2*(u2[i+1][j+2][k]-u2[i+1][j-2][k]) +
						c1*(u2[i+1][j+1][k]-u2[i+1][j-1][k])  )
					+ la[i-1][j][k]*met1[i-1][j][k]*met1[i-1][j][k]*(
						c2*(u2[i-1][j+2][k]-u2[i-1][j-2][k]) +
						c1*(u2[i-1][j+1][k]-u2[i-1][j-1][k])));

		r1[i*N*N+j*N+k] += c2*(
				(2*mu[i][j][k+2]+la[i][j][k+2])*met2[i][j][k+2]*met1[i][j][k+2]*(
					c2*(u1[i+2][j][k+2]-u1[i-2][j][k+2]) +
					c1*(u1[i+1][j][k+2]-u1[i-1][j][k+2])   )*strx[i]*stry[j]
				+ mu[i][j][k+2]*met3[i][j][k+2]*met1[i][j][k+2]*(
					c2*(u2[i+2][j][k+2]-u2[i-2][j][k+2]) +
					c1*(u2[i+1][j][k+2]-u2[i-1][j][k+2])  )
				+ mu[i][j][k+2]*met4[i][j][k+2]*met1[i][j][k+2]*(
					c2*(u3[i+2][j][k+2]-u3[i-2][j][k+2]) +
					c1*(u3[i+1][j][k+2]-u3[i-1][j][k+2])  )*stry[j]
				+ ((2*mu[i][j][k-2]+la[i][j][k-2])*met2[i][j][k-2]*met1[i][j][k-2]*(
						c2*(u1[i+2][j][k-2]-u1[i-2][j][k-2]) +
						c1*(u1[i+1][j][k-2]-u1[i-1][j][k-2])  )*strx[i]*stry[j]
					+ mu[i][j][k-2]*met3[i][j][k-2]*met1[i][j][k-2]*(
						c2*(u2[i+2][j][k-2]-u2[i-2][j][k-2]) +
						c1*(u2[i+1][j][k-2]-u2[i-1][j][k-2])   )
					+ mu[i][j][k-2]*met4[i][j][k-2]*met1[i][j][k-2]*(
						c2*(u3[i+2][j][k-2]-u3[i-2][j][k-2]) +
						c1*(u3[i+1][j][k-2]-u3[i-1][j][k-2])   )*stry[j] )
				) + c1*(
					(2*mu[i][j][k+1]+la[i][j][k+1])*met2[i][j][k+1]*met1[i][j][k+1]*(
						c2*(u1[i+2][j][k+1]-u1[i-2][j][k+1]) +
						c1*(u1[i+1][j][k+1]-u1[i-1][j][k+1]) )*strx[i+2]*stry[j]
					+ mu[i][j][k+1]*met3[i][j][k+1]*met1[i][j][k+1]*(
						c2*(u2[i+2][j][k+1]-u2[i-2][j][k+1]) +
						c1*(u2[i+1][j][k+1]-u2[i-1][j][k+1]) )
					+ mu[i][j][k+1]*met4[i][j][k+1]*met1[i][j][k+1]*(
						c2*(u3[i+2][j][k+1]-u3[i-2][j][k+1]) +
						c1*(u3[i+1][j][k+1]-u3[i-1][j][k+1])  )*stry[j]
					+ ((2*mu[i][j][k-1]+la[i][j][k-1])*met2[i][j][k-1]*met1[i][j][k-1]*(
							c2*(u1[i+2][j][k-1]-u1[i-2][j][k-1]) +
							c1*(u1[i+1][j][k-1]-u1[i-1][j][k-1]) )*strx[i-2]*stry[j]
						+ mu[i][j][k-1]*met3[i][j][k-1]*met1[i][j][k-1]*(
							c2*(u2[i+2][j][k-1]-u2[i-2][j][k-1]) +
							c1*(u2[i+1][j][k-1]-u2[i-1][j][k-1]) )
						+ mu[i][j][k-1]*met4[i][j][k-1]*met1[i][j][k-1]*(
							c2*(u3[i+2][j][k-1]-u3[i-2][j][k-1]) +
							c1*(u3[i+1][j][k-1]-u3[i-1][j][k-1])   )*stry[j]  ) );

		r1[i*N*N+j*N+k] += ( c2*(
					(2*mu[i+2][j][k]+la[i+2][j][k])*met2[i+2][j][k]*met1[i+2][j][k]*(
						c2*(u1[i+2][j][k+2]-u1[i+2][j][k-2]) +
						c1*(u1[i+2][j][k+1]-u1[i+2][j][k-1])   )*strx[i]
					+ la[i+2][j][k]*met3[i+2][j][k]*met1[i+2][j][k]*(
						c2*(u2[i+2][j][k+2]-u2[i+2][j][k-2]) +
						c1*(u2[i+2][j][k+1]-u2[i+2][j][k-1])  )*stry[j]
					+ la[i+2][j][k]*met4[i+2][j][k]*met1[i+2][j][k]*(
						c2*(u3[i+2][j][k+2]-u3[i+2][j][k-2]) +
						c1*(u3[i+2][j][k+1]-u3[i+2][j][k-1])  )
					+ ((2*mu[i-2][j][k]+la[i-2][j][k])*met2[i-2][j][k]*met1[i-2][j][k]*(
							c2*(u1[i-2][j][k+2]-u1[i-2][j][k-2]) +
							c1*(u1[i-2][j][k+1]-u1[i-2][j][k-1])  )*strx[i]
						+ la[i-2][j][k]*met3[i-2][j][k]*met1[i-2][j][k]*(
							c2*(u2[i-2][j][k+2]-u2[i-2][j][k-2]) +
							c1*(u2[i-2][j][k+1]-u2[i-2][j][k-1])   )*stry[j]
						+ la[i-2][j][k]*met4[i-2][j][k]*met1[i-2][j][k]*(
							c2*(u3[i-2][j][k+2]-u3[i-2][j][k-2]) +
							c1*(u3[i-2][j][k+1]-u3[i-2][j][k-1])   ) )
				    ) + c1*(
					    (2*mu[i+1][j][k]+la[i+1][j][k])*met2[i+1][j][k]*met1[i+1][j][k]*(
						    c2*(u1[i+1][j][k+2]-u1[i+1][j][k-2]) +
						    c1*(u1[i+1][j][k+1]-u1[i+1][j][k-1]) )*strx[i]
					    + la[i+1][j][k]*met3[i+1][j][k]*met1[i+1][j][k]*(
						    c2*(u2[i+1][j][k+2]-u2[i+1][j][k-2]) +
						    c1*(u2[i+1][j][k+1]-u2[i+1][j][k-1]) )*stry[j]
					    + la[i+1][j][k]*met4[i+1][j][k]*met1[i+1][j][k]*(
						    c2*(u3[i+1][j][k+2]-u3[i+1][j][k-2]) +
						    c1*(u3[i+1][j][k+1]-u3[i+1][j][k-1])  )
					    + ((2*mu[i-1][j][k]+la[i-1][j][k])*met2[i-1][j][k]*met1[i-1][j][k]*(
							    c2*(u1[i-1][j][k+2]-u1[i-1][j][k-2]) +
							    c1*(u1[i-1][j][k+1]-u1[i-1][j][k-1]) )*strx[i]
						    + la[i-1][j][k]*met3[i-1][j][k]*met1[i-1][j][k]*(
							    c2*(u2[i-1][j][k+2]-u2[i-1][j][k-2]) +
							    c1*(u2[i-1][j][k+1]-u2[i-1][j][k-1]) )*stry[j]
						    + la[i-1][j][k]*met4[i-1][j][k]*met1[i-1][j][k]*(
							    c2*(u3[i-1][j][k+2]-u3[i-1][j][k-2]) +
							    c1*(u3[i-1][j][k+1]-u3[i-1][j][k-1])   )  ) ) )*stry[j];

		r1[i*N*N+j*N+k] += c2*(
				mu[i][j+2][k]*met3[i][j+2][k]*met1[i][j+2][k]*(
					c2*(u1[i][j+2][k+2]-u1[i][j+2][k-2]) +
					c1*(u1[i][j+2][k+1]-u1[i][j+2][k-1])   )*stry[j+1]*strx[i]
				+ mu[i][j+2][k]*met2[i][j+2][k]*met1[i][j+2][k]*(
					c2*(u2[i][j+2][k+2]-u2[i][j+2][k-2]) +
					c1*(u2[i][j+2][k+1]-u2[i][j+2][k-1])  )
				+ ( mu[i][j-2][k]*met3[i][j-2][k]*met1[i][j-2][k]*(
						c2*(u1[i][j-2][k+2]-u1[i][j-2][k-2]) +
						c1*(u1[i][j-2][k+1]-u1[i][j-2][k-1])  )*stry[j]*strx[i]
					+ mu[i][j-2][k]*met2[i][j-2][k]*met1[i][j-2][k]*(
						c2*(u2[i][j-2][k+2]-u2[i][j-2][k-2]) +
						c1*(u2[i][j-2][k+1]-u2[i][j-2][k-1])   ) )
				) + c1*(
					mu[i][j+1][k]*met3[i][j+1][k]*met1[i][j+1][k]*(
						c2*(u1[i][j+1][k+2]-u1[i][j+1][k-2]) +
						c1*(u1[i][j+1][k+1]-u1[i][j+1][k-1]) )*stry[j-1]*strx[i]
					+ mu[i][j+1][k]*met2[i][j+1][k]*met1[i][j+1][k]*(
						c2*(u2[i][j+1][k+2]-u2[i][j+1][k-2]) +
						c1*(u2[i][j+1][k+1]-u2[i][j+1][k-1]) )
					+ ( mu[i][j-1][k]*met3[i][j-1][k]*met1[i][j-1][k]*(
							c2*(u1[i][j-1][k+2]-u1[i][j-1][k-2]) +
							c1*(u1[i][j-1][k+1]-u1[i][j-1][k-1]) )*stry[j]*strx[i]
						+ mu[i][j-1][k]*met2[i][j-1][k]*met1[i][j-1][k]*(
							c2*(u2[i][j-1][k+2]-u2[i][j-1][k-2]) +
							c1*(u2[i][j-1][k+1]-u2[i][j-1][k-1]) ) ) );


		r1[i*N*N+j*N+k] += c2*(
				mu[i][j][k+2]*met3[i][j][k+2]*met1[i][j][k+2]*(
					c2*(u1[i][j+2][k+2]-u1[i][j-2][k+2]) +
					c1*(u1[i][j+1][k+2]-u1[i][j-1][k+2])   )*stry[j+2]*strx[i]
				+ la[i][j][k+2]*met2[i][j][k+2]*met1[i][j][k+2]*(
					c2*(u2[i][j+2][k+2]-u2[i][j-2][k+2]) +
					c1*(u2[i][j+1][k+2]-u2[i][j-1][k+2])  )
				+ ( mu[i][j][k-2]*met3[i][j][k-2]*met1[i][j][k-2]*(
						c2*(u1[i][j+2][k-2]-u1[i][j-2][k-2]) +
						c1*(u1[i][j+1][k-2]-u1[i][j-1][k-2])  )*stry[j]*strx[i]
					+ la[i][j][k-2]*met2[i][j][k-2]*met1[i][j][k-2]*(
						c2*(u2[i][j+2][k-2]-u2[i][j-2][k-2]) +
						c1*(u2[i][j+1][k-2]-u2[i][j-1][k-2])   ) )
				) + c1*(
					mu[i][j][k+1]*met3[i][j][k+1]*met1[i][j][k+1]*(
						c2*(u1[i][j+2][k+1]-u1[i][j-2][k+1]) +
						c1*(u1[i][j+1][k+1]-u1[i][j-1][k+1]) )*stry[j-2]*strx[i]
					+ la[i][j][k+1]*met2[i][j][k+1]*met1[i][j][k+1]*(
						c2*(u2[i][j+2][k+1]-u2[i][j-2][k+1]) +
						c1*(u2[i][j+1][k+1]-u2[i][j-1][k+1]) )
					+ ( mu[i][j][k-1]*met3[i][j][k-1]*met1[i][j][k-1]*(
							c2*(u1[i][j+2][k-1]-u1[i][j-2][k-1]) +
							c1*(u1[i][j+1][k-1]-u1[i][j-1][k-1]) )*stry[j]*strx[i]
						+ la[i][j][k-1]*met2[i][j][k-1]*met1[i][j][k-1]*(
							c2*(u2[i][j+2][k-1]-u2[i][j-2][k-1]) +
							c1*(u2[i][j+1][k-1]-u2[i][j-1][k-1]) ) ) );

		}
	} 
}

extern "C" void host_code (float *h_r1, float *h_u1, float *h_u2, float *h_u3,  float *h_mu, float *h_la, float *h_met1, float *h_met2, float *h_met3, float *h_met4, float *h_strx, float *h_stry, float c1, float c2, int N) {
	float *r1;
	cudaMalloc (&r1, sizeof(float)*N*N*N);
	check_error ("Failed to allocate device memory for r1\n");
	cudaMemcpy (r1, h_r1, sizeof(float)*N*N*N, cudaMemcpyHostToDevice);
	float *u1;
	cudaMalloc (&u1, sizeof(float)*N*N*N);
	check_error ("Failed to allocate device memory for u1\n");
	cudaMemcpy (u1, h_u1, sizeof(float)*N*N*N, cudaMemcpyHostToDevice);
	float *u2;
	cudaMalloc (&u2, sizeof(float)*N*N*N);
	check_error ("Failed to allocate device memory for u2\n");
	cudaMemcpy (u2, h_u2, sizeof(float)*N*N*N, cudaMemcpyHostToDevice);
	float *u3;
	cudaMalloc (&u3, sizeof(float)*N*N*N);
	check_error ("Failed to allocate device memory for u3\n");
	cudaMemcpy (u3, h_u3, sizeof(float)*N*N*N, cudaMemcpyHostToDevice);
	float *mu;
	cudaMalloc (&mu, sizeof(float)*N*N*N);
	check_error ("Failed to allocate device memory for mu\n");
	cudaMemcpy (mu, h_mu, sizeof(float)*N*N*N, cudaMemcpyHostToDevice);
	float *la;
	cudaMalloc (&la, sizeof(float)*N*N*N);
	check_error ("Failed to allocate device memory for la\n");
	cudaMemcpy (la, h_la, sizeof(float)*N*N*N, cudaMemcpyHostToDevice);
	float *met1;
	cudaMalloc (&met1, sizeof(float)*N*N*N);
	check_error ("Failed to allocate device memory for met1\n");
	cudaMemcpy (met1, h_met1, sizeof(float)*N*N*N, cudaMemcpyHostToDevice);
	float *met2;
	cudaMalloc (&met2, sizeof(float)*N*N*N);
	check_error ("Failed to allocate device memory for met2\n");
	cudaMemcpy (met2, h_met2, sizeof(float)*N*N*N, cudaMemcpyHostToDevice);
	float *met3;
	cudaMalloc (&met3, sizeof(float)*N*N*N);
	check_error ("Failed to allocate device memory for met3\n");
	cudaMemcpy (met3, h_met3, sizeof(float)*N*N*N, cudaMemcpyHostToDevice);
	float *met4;
	cudaMalloc (&met4, sizeof(float)*N*N*N);
	check_error ("Failed to allocate device memory for met4\n");
	cudaMemcpy (met4, h_met4, sizeof(float)*N*N*N, cudaMemcpyHostToDevice);
	float *strx;
	cudaMalloc (&strx, sizeof(float)*N);
	check_error ("Failed to allocate device memory for strx\n");
	cudaMemcpy (strx, h_strx, sizeof(float)*N, cudaMemcpyHostToDevice);
	float *stry;
	cudaMalloc (&stry, sizeof(float)*N);
	check_error ("Failed to allocate device memory for stry\n");
	cudaMemcpy (stry, h_stry, sizeof(float)*N, cudaMemcpyHostToDevice);

	dim3 blockconfig (32, 8);
	dim3 gridconfig (ceil(N, blockconfig.x), ceil(N, blockconfig.y), 1);

	curvi <<<gridconfig, blockconfig>>> (r1, u1, u2, u3, mu, la, met1, met2, met3, met4, strx, stry, c1, c2, N);
	cudaMemcpy (h_r1, r1, sizeof(float)*N*N*N, cudaMemcpyDeviceToHost);
}
