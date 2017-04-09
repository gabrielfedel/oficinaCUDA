Credito:
Mark Harris - NVIDIA Corporation
Adaptado por Denise Stringhini - Unifesp

Description:
A simple kernel which adds two vectors (1D arrays) with the GPU. This is a
good example showing off memory allocation and movement use the CUDA C 
runtime API, while using a very simple kernel function. There are many 
variations you can use on this example, including using the Thrust library
to handle memory allocation and movement instead of cudaMalloc and cudaMemcpy
explicitly.

Descrição: um kernel simples para adicionar dois vetores (arrays 1D) na GPU. Exmplifica o uso de alocação de memória e indexação.

Arquivos:
  Exercise:
    vec_exercicio.cu - versão para completar (traduzida)
  Answer:
    answer.cu - código completo com a solução
    vec_mem_unificada.cu - código completo com a versão para memória unificada

Compilar:

  nvcc -o vectoradd answer.cu

Exercícios:

1. Completar o código, compilar, executar
2. Alterar o código para usar Memória Unificada

