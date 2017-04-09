#include <stdio.h>

__global__ void add(int *a, int *b, int *c)
{
    /* insert code to calculate the index properly using blockIdx.x, blockDim.x, threadIdx.x */
	int index = blockIdx.x * blockDim.x + threadIdx.x;
	c[index] = a[index] + b[index];
}

/* experiment with N */
/* how large can it be? */
#define N (2048*2048)
#define THREADS_PER_BLOCK 512

int main()
{
	int *d_a, *d_b, *d_c;
	int size = N * sizeof( int );

	/* allocate space for device copies of a, b, c */

	cudaMallocManaged(&d_a, size );
	cudaMallocManaged(&d_b, size );
	cudaMallocManaged(&d_c, size );

	for( int i = 0; i < N; i++ )
	{
		d_a[i] = d_b[i] = i;
		d_c[i] = 0;
	}

	/* launch the kernel on the GPU */
	/* insert the launch parameters to launch the kernel properly using blocks and threads */ 
	add<<< (N + (THREADS_PER_BLOCK-1)) / THREADS_PER_BLOCK, THREADS_PER_BLOCK >>>( d_a, d_b, d_c );

        cudaDeviceSynchronize();

	printf( "d_c[0] = %d\n", d_c[0] );
	printf( "d_c[%d] = %d\n",N-1, d_c[N-1] );

	/* clean up */

	cudaFree( d_a );
	cudaFree( d_b );
	cudaFree( d_c );
	
	return 0;
} /* end main */
