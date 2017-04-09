#include <stdio.h>

__global__ void add(int *a, int *b, int *c)
{
    /* insira codigo para calcular o indice usando blockIdx.x, blockDim.x, threadIdx.x */
	//int index = threadIdx.x;/* RESPONDA */
	int index = blockIdx.x;
	c[index] = a[index] + b[index];
}

/* EXPERIMENTE com N */
/* o quao grande ele pode ser? */
#define N (32*32)
#define THREADS_PER_BLOCK 512

int main()
{
	int *a, *b, *c;
	int *d_a, *d_b, *d_c;

	int size = N * sizeof( int );

	/* aloca espaco no device para copias de a, b, c */
	cudaMalloc( (void **) &d_a, size );
	cudaMalloc( (void **) &d_b, size );
	cudaMalloc( (void **) &d_c, size );

	/* aloca espaco no host para copias de a, b, c e inicializa valores */

	a = (int *)malloc( size );
	b = (int *)malloc( size );
	c = (int *)malloc( size );

	for( int i = 0; i < N; i++ )
	{
		a[i] = b[i] = i;
		c[i] = 0;
	}

	/* copia dados para o device */
	/* COMPLETE com os parametros necessários para copiar dados para o device */
	cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

	/* lance o kernel na GPU */
	/* COMPLETE com os parametros para lançar o kernel propriamente usando blocos e threads */
	add<<<N/THREADS_PER_BLOCK,THREADS_PER_BLOC>>>( d_a, d_b, d_c );

	/* copie os resultados de volta ao host */
	/* COMPLETE com parametros necessarios para copiar os dados de volta ao host */
	cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost );


	printf( "c[0] = %d\n", c[0] );
	printf( "c[%d] = %d\n",N-1, c[N-1] );

	/* clean up */

	free(a);
	free(b);
	free(c);
	cudaFree( d_a );
	cudaFree( d_b );
	cudaFree( d_c );
	
	return 0;
} /* end main */
