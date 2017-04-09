#include <stdio.h>


// indica que √© uma fun√√o que vai rodar no device
__global__ void hello()
{
	printf("Oi mundo! De thread: %d De: bloco %d\n", threadIdx.x, blockIdx.x);
}

int main(void)
{
	int num_threads = 5;
	int num_blocks = 5;
	//chama a fun√√o e espec√fica blocos e threads
	hello<<<num_blocks,num_threads>>>();
	//espera o c√digo da gpu terminar
	cudaDeviceSynchronize();

	return 0;
}
