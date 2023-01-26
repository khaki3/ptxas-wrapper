#define tf (3d0/4)
#define i6 (1d0/6)
#define i144 (1d0/144)
#define i12 (1d0/12)
#define d4a (2d0/3)
#define d4b (-(1d0/12))

extern "C" void derivative_gold (float *h_r1, float *h_u1, float *h_u2, float *h_u3, float *h_mu, float *h_la, float *h_met1, float *h_met2, float *h_met3, float *h_met4, float *strx, float *stry, float c1, float c2, int N) {
	float (*r1)[304][304] = (float (*)[304][304])h_r1;
	float (*u1)[304][304] = (float (*)[304][304])h_u1;
	float (*u2)[304][304] = (float (*)[304][304])h_u2;
	float (*u3)[304][304] = (float (*)[304][304])h_u3;
	float (*mu)[304][304] = (float (*)[304][304])h_mu;
	float (*la)[304][304] = (float (*)[304][304])h_la;
	float (*met1)[304][304] = (float (*)[304][304])h_met1;
	float (*met2)[304][304] = (float (*)[304][304])h_met2;
	float (*met3)[304][304] = (float (*)[304][304])h_met3;
	float (*met4)[304][304] = (float (*)[304][304])h_met4;
	int i, j, k;
	/* Assumptions */
	for (i = 2; i < N-2; i++) {
		for (j = 2; j < N-2; j++) {
			for (k = 2; k < N-2; k++) {
				r1[i][j][k] +=
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

				r1[i][j][k] += c2*(
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

				r1[i][j][k] += ( c2*(
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

				r1[i][j][k] += c2*(
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

				r1[i][j][k] += c2*(
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
			}
		}
	}
}
