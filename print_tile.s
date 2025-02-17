# a0 = endereço do conjunto de tiles
# a1 = posição x onde o tile vai ser printado 
# a2 = posição y onde o tile vai ser printado 
# a3 = frame
# a4 = Número do tile

print_tile:
# Coloca em t0 o ENDERECO INICIAL DO BITMAP  de acordo com o FRAME a3
	#t0 = endereço bitmap; a3 = frame
	li t0, 0xFF0 # carrega 0xFF0 em t0
	add t0, t0, a3 # adiciona o frame a FF0
	slli t0, t0, 20 # shift de 20 bits pra esquerda
	
# carrega a posição inicial (x,y) onde a imagem começa a ser printada no bitmap
# posição inicial = t0(inicial) + x + 320*y
	add t0, t0, a1 # adiciona x ao t0
	li t1, 320 # t1 = 320
	mul t1, t1, a2 # multiplica y por t1
	add t0, t0, t1 # coloca o endereco em t0	

	mv t5, a0
	lw t1, 0(t5)		# t1 = largura
	lw t2, 4(t5)		# t2 = altura
	addi t5, t5, 8		# vai para enderço da primeira cor no arquivo

	mv t3, a4			# t3 = número do tile
	mul t4, t1, t2		# t4 = número de bits em cada tile
	mul t3, t3, t4		# t3 = número total de bits a ser pulado
	add t5, t5, t3		# pula todos os bits até chegar no tile
	
	
	mv t3, zero			# zera t1
	mv t4, zero			# zera t4
#t0 <- endereço do bitmap
#t1 <- largura do tile
#t2 <- altura do tile
#t3 <- contador de colunas
#t4 <- contador de linhas
#t5 <- endereço da primeira cor a ser printada
PrintLinha:
	#printando o bit t6 da imagem, no endereÃ§o t5 do bitmap
	lbu t6, 0(t5) 			# carrega em t5 um byte da imagem
	sb t6, 0(t0) 			# imprime no bitmap o byte da imagem
	
	addi t0, t0, 1			# incrementa endereço do bitmap
	addi t5, t5, 1			# incrementa endereço da imagem
	addi t3, t3, 1			# incrementa contador de colunas
	
	blt t3, t1, PrintLinha	# se cont. colunas < largura -> LOOP
	
	addi t0, t0, 320
	sub t0, t0, t1		
	
	mv t3, zero				# zera contador de colunas para iniciar um novo ciclo
	addi t4, t4, 1			# incrementa o contador de linhas
	
	bgt t2, t4, PrintLinha	# se altura > cont. linhas -> LOOP
	ret