#include <stdio.h>

__global__ void add(int *a, int *b, int *c) {
    *c = *a + *b;
}


int main(void) {
    int *d_a, *d_b, *d_c; // device copies of a, b, c
    int size = sizeof(int);

    // Allocate space for device copies of a, b, c
    cudaMallocManaged(&d_a, size);
    cudaMallocManaged (&d_b, size);
    cudaMallocManaged (&d_c, size);

    // Setup input values
    *d_a = 2;
    *d_b = 7;
    *d_c = 0;

    // Launch add() kernel on GPU
    add<<<1,1>>>(d_a, d_b, d_c);

    cudaDeviceSynchronize();

    printf("d_c = %d\n", *d_c);

    // Cleanup
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);
    return 0;
}
