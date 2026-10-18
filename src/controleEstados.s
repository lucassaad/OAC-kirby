# a0 = movendo
# a1 = estado
# a2 = caindo

controleEstado:
	la t0, subindo
	lh t0, 0(t0)
	li t1, 1
	beq t0, t1, controleSubindo
	
	la t0, caindo
	lh t0, 0(t0)
	li t1, 1
	beq t0, t1, controleCaindo
	
	beqz a0, controleParado
	
	li t0, 1
	beq a0, t0, controleMovimento
	
FimControle:ret
		

						
controleParado:		
	beqz a1, Incrementa		# se estado = 0 : incrementa estado 
	mv a1, zero				# se estado != 0; estado <- 0

	j FimControle
	
controleMovimento:
	li t0, 2
	beq a1, t0, Incrementa  
	li t0, 3
	beq a1, t0, Incrementa
	li t0, 4
	beq a1, t0, Incrementa
	li t0, 2
	mv a1, t0
	
	j FimControle

controleCaindo:
	li a1, 7
	
	j FimControle

controleSubindo:
	li a1, 6
	
	j FimControle
Incrementa:
	addi a1, a1, 1
	j FimControle
	
	

		
