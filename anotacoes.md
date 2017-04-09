CUDA

* Diversas (4) arquiteturas: Kepler, Pascal,...

* CUDA -> funciona na Nvidia exclusivamante
* CUDA driver api -> similiar a opencl (permite trabalhar exclusivamente em C)
* CUDA tem melehor desemepenho nas placas da nvidia que opencl
* paralelismo tipo SIMD
* programa principal executa na cpu e inicia as threads na gpu
* própria hierarquia de memória (dados transferidos transferidos via pci excpress)

* kernel -> código/função que roda dentro da gpu

* CUDA foi desenvolvido para ser usado para programas de própsito geral

* computação heterogênea: código na cpu e na gpu  / ainda não é possível rodar só na gpu (no Xion phi pode)

* as threads executam dentro do bloco

## Arquitetura Kepler

* até 15 smx(multiprocessador simétrico) com 192 núcleos cada (2880 cores)
* paralelismo dinâmico
* hyper-q possibilita disparar kernels simultaneamente (antes não tinha como lançar kernels de dentro dela)
* 4 warps concorrentes : warps são conjuntos de threads (1 warp = 32 threads), unidade de escalonamento da placa. Sempre que escalona as threads tem conjunto de 32 threads
\-> quando se for programar é bom considerar os warps (tentar usar múltiplos de 32)

## Arquitetura Pascal

* sm menor mas tem mais sms (diminui o simd e aumentou o mimd)
* até 60SMs com 64 cores (3840 cores totais)
* 16G de memória
* interconexão vlink : mais rápido que a pciexpress (na comunicação entre as gpus), até 40GB/s
* é possível usar essa vlink com a memória do host


# Computer Capability
* descreve sua arquitetura
* diz número de registradores, tamanho de memórias, qtde de cores, 
* na hora de compilar pode indicar pra qual capability vai ser compilado


# Memória unificada
* facilita acesso as memórias (escondendo que a memória da cpu e da gpu são diferentes)
* usa um ponteiro alocado na cpu (com isso faz transferências automáticas)

*simplifica o código mas pode sacrificar o desempenho (abordagem conservadora)
*pode acontcer cópias extras do host para cpu e vice-versa

* na kepler é limitado ao tamanho da memória da gpu (na pascal à memória da cpu)


# Acrescentar paralelismo

* Computação na GPU deve ter paralelismo massivo

# profile
* calcular tempo de execução e comparar

# block e thread
* tamanho do bloco tem que ser divísivel por 32
* as threads usam memória compartilhada
* cada bloco executa em um SM

# problemas

* pode ser que dê problema numa execução, mas nenhuma mensagem de erro é emitida

# stencil

são problemas em que o cálculo de um elemento depende do uso de vizinhos (um raio de vizinhos)
* normalmente as bordas são somente elementos de entrada (uma massa para calcular os outros elementos)


__global__ void stencil_1d(int *in, int *out) {
__shared__ int temp[BLOCK_SIZE + 2 * RADIUS];

// indice glocal (bloco)
int gindex = threadIdx.x + blockIdx.x * blockDim.x;

//indice local
int lindex = threadIdx.x + RADIUS;

// Read input elements into shared memory

temp[lindex] = in[gindex];
if (threadIdx.x < RADIUS) {
temp[lindex - RADIUS] = in[gindex - RADIUS];
temp[lindex + BLOCK_SIZE] =
in[gindex + BLOCK_SIZE];
}

