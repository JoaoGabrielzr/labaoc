.data
	msg1: .asciiz "Informe o primeiro valor: "
	msg2: .asciiz "\nInforme o segundo valor: "
	msg3: .asciiz "\nInforme o operador: "
	msg4: .asciiz " = "
	msg5: .asciiz "\nResultado: "
	msg6: .asciiz "\nImpossível realizar divisão por 0"

	operador: .word '+', '-', '/', '*'
.text

.globl main
@@ -49,31 +50,37 @@ main:

#encerra o programa
exit:
	li $v0, 4
#imprime a mensagem resultado
	li $v0, 4			
	la $a0, msg5
	syscall

	li $v0, 1
#imprime o primeiro valor
	li $v0, 1			
	move $a0, $s0
	syscall
	
	li $v0, 11
#imprime o sinal
	li $v0, 11			
	move $a0, $s2
	syscall
	
	li $v0, 1
#imprime o segundo valor
	li $v0, 1			
	move $a0, $s1
	syscall

	li $v0, 4
#imprime o =
	li $v0, 4			
	la $a0, msg4
	syscall
	
	li $v0, 1
#imprime o resultado
	li $v0, 1	
	move $a0, $s3
	syscall
			
	li $v0, 10
	li $v0, 10	
	syscall	

soma:
@@ -83,10 +90,21 @@ subt:
	sub $s3, $s0, $s1
	j exit
multp:
	mult $s1, $s2
	mulo $s3, $s0, $s1 
	j exit
divis:
#verifica divisao por zero
	beqz $s1, erro
	div $s3, $s0, $s1
	j exit
	
erro: 
	li $v0, 4
	la $a0, msg6
	syscall

#encerra o programa
	li $v0, 10			
	syscall
	
	