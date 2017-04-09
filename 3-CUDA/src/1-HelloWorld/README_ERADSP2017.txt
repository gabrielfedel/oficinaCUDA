Credito:
Profa. Denise Stringhini - Unifesp

Descrição:
Código de Hello World muito simples que tem o objetivo de auxiliar na demonstração de alto paralelismo existente em GPUs modernas.

Código fonte:

    hello0.cu - exemplo de Hello World

Compilação:

  nvcc -o hello0 hello0.cu

Exercícios:
1. Compile e execute o código. 

2. Observe os parâmetros entre <<< e >>> na main. Como veremos a seguir, estes são os parâmetros de lançamento do kernel e indicam a quantidade de Blocos e Threads que serão executados. Experimente as seguintes alterações e observe o que acontece:
a) altere apenas o segundo parâmetro (num_threads) para 2
b) altere apenas o segundo parâmetro (num_blocks) para 2 - altere a mensagem substituindo "thread" por "bloco"
c) altere os dois e imprima blockIdx.x e threadIdx.x 

