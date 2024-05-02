.data
array: .word 34, 7, 23, 32, 15, 88, 26, 12, 29, 5   # vetor com 10 posições
min_label: .asciiz "min="
max_label: .asciiz "max="
newline: .asciiz "\n"

.text
.globl main
main:
    # Inicializações
    la $a0, array          # Carrega o endereço base do vetor em $a0
    li $t0, 0              # Inicializa o índice i = 0
    lw $t1, 0($a0)         # Inicializa $t1 com o primeiro elemento do vetor (min = array[0])
    lw $t2, 0($a0)         # Inicializa $t2 com o primeiro elemento do vetor (max = array[0])
    li $t3, 40             # Tamanho do vetor (10 elementos * 4 bytes cada)

    # Encontra o menor e o maior valor
find_min_max:
    lw $t4, 0($a0)         # Carrega o próximo elemento do vetor em $t4
    ble $t4, $t1, not_smaller  # Se $t4 <= $t1, então $t4 é menor ou igual
    move $t1, $t4           # Atualiza o menor valor
not_smaller:
    bgt $t4, $t2, not_bigger  # Se $t4 > $t2, então $t4 é maior
    move $t2, $t4           # Atualiza o maior valor
not_bigger:
    addi $a0, $a0, 4        # Avança para o próximo elemento do vetor
    addi $t0, $t0, 1        # Incrementa o índice i
    bne $t0, $t3, find_min_max  # Se o índice i não for igual ao tamanho do vetor, continue

    # Imprime o menor valor
    li $v0, 4               # System call para imprimir string
    la $a0, min_label
    syscall

    li $v0, 1               # System call para imprimir inteiro
    move $a0, $t1           # Coloca o menor valor em $a0
    syscall

   

    # Imprime o maior valor
    li $v0, 4               # System call para imprimir string
    la $a0, max_label
    syscall

    li $v0, 1               # System call para imprimir inteiro
    move $a0, $t2           # Coloca o maior valor em $a0
    syscall

    # Pula para uma nova linha
    li $v0, 4               
    la $a0, newline
    syscall

    # Encerra o programa
    li $v0, 10             
    syscall