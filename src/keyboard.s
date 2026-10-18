keyboard_input:		
# guarda o tempo da leitura atual
	li t1,0xFF200000		# carrega o endereco de controle do KDMMIO
	lw t0,0(t1)				# Le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,NONE   	   	# Se nao ha tecla pressionada entao vai para FIM
  	lw t2,4(t1)  			# le o valor da tecla tecla
	
	li t0,'a'
	beq t2,t0,MAP_ESQ		# se tecla pressionada for 'a', chama CHAR_ESQ
	
	li t0,'d'
	beq t2,t0,MAP_DIR		# se tecla pressionada for 'd', chama CHAR_DIR
	
	li t0, 'w'
	beq t2, t0, CHAR_JUMP
	
	li t0, 'e'
	beq t2, t0, PROX_FASE 
	
	
NONE:
	
# atualiza a movimentação do kirby <- movendo(0)
	la t0, movendo		# caso tenha dado o tempo:
	li t1, 0			# movendo: falso
	sh t1, 0 (t0)
	

FIM: ret				# retorna

MAP_ESQ:	
# checa se o personagem não vai colidir se for para esquerda: 
	la t0, char_pos	
# SOMA AS LINHAS QUE PRECISAM SER PULADAS
	lh t2, 2(t0)
	li t3, 16
	div t2, t2, t3 
	li t3, 70
	mul t2, t2, t3
	add a0, a0, t2
# SOMA COLUNAS QUE PRECISAM SER PULADAS
	lh t2, 0(t0)
	li t3, 16
	div t2, t2, t3
	add a0, a0, t2
# SOMA O RESTO DAS COLUNAS QUE PRECISAM SER PULADAS
	la t0, deslocamento_x_mapa
	lh t2, 0(t0)
	li t3, 16
	div t2, t2, t3
	add a0, a0, t2
	
	li t3, 1
	sub a0, a0, t3	
	
	lb t0, 0(a0)
	bnez t0, FIM
 
	
	
C1:	la t0, char_pos				 
	lh t1, 0(t0)				# posição x do personagem
	li t2, 120					# se pos > 120
	bgt t1, t2, KIR_MOV_ESQ		# decrememnte a pos do personagem
	
	la t0, deslocamento_x_mapa			 
	lh t1, 0(t0)					# posição horizontal atual 
	beqz t1, KIR_MOV_ESQ			# se o mapa já estiver na posição 0, decrememnte a pos. do kirby
	addi t1, t1, -16					# caso contrario, decrememnte a posição do mapa
	sh t1, 0(t0)	
	j CON1
	
# decrementa a posição do kirby
KIR_MOV_ESQ:
	la t0, char_pos
	lh t1, 0(t0)
	beqz t1, CON1
	addi t1, t1, -16
	sh  t1,0(t0)
# guarda a posição atual e atualiza o estado para movimentando
CON1:	
	# atualiza a direção do kirby <- esquerda(1)
	la t0, direcao
	li t1, 1
	sh t1, 0(t0)
# atualiza a movimentação do kirby <- movendo(1)
	la t0, movendo
	li t1, 1
	sh t1, 0(t0)
	ret
	
	##########
	#ADD se deslocamento < 30 ou > 680
MAP_DIR:
	# checa se o personagem não vai colidir se for para esquerda: 
	la t0, char_pos	
# SOMA AS LINHAS QUE PRECISAM SER PULADAS
	lh t2, 2(t0)
	li t3, 16
	div t2, t2, t3 
	li t3, 70
	mul t2, t2, t3
	add a0, a0, t2
# SOMA COLUNAS QUE PRECISAM SER PULADAS
	lh t2, 0(t0)
	li t3, 16
	div t2, t2, t3
	add a0, a0, t2
# SOMA O RESTO DAS COLUNAS QUE PRECISAM SER PULADAS
	la t0, deslocamento_x_mapa
	lh t2, 0(t0)
	li t3, 16
	div t2, t2, t3
	add a0, a0, t2
	
	addi a0, a0, 1
	
	lb t0, 0(a0)
	beqz t0, C2
 
	
	j FIM
			
C2:	la t0, char_pos
	lh t1, 0(t0)		# pos atual do kirby
	li t2, 296			# pos maxima do kirby
	bge t1, t2, CON2	# se o kirby esta na posição maxima, nao altere nada
	li t2, 120			
	ble t1, t2, KIR_MOV_DIR	# se kirby tiver abaixo da posição inicial, incremente a pos. do kirby
	la t0, deslocamento_x_mapa	
	lh t1, 0(t0)
	li t2, 696
	bge t1, t2, KIR_MOV_DIR
	addi t1, t1, 16			# incrememnta a posição do mapa
	sh t1, 0(t0)
	j CON2
# incrementa a posição do kirby 
KIR_MOV_DIR:
	la t0, char_pos
	lh t1, 0(t0)
	addi t1, t1, 16
	sh t1, 0(t0)
# guarda os paramteros atualizados
CON2:
	# atualiza a direção do kirby <- direita(0)
	la t0, direcao
	li t1, 0
	sh t1, 0(t0)
	# atualiza a movimentação do kirby <- movendo(1)
	la t0, movendo
	li t1, 1
	sh t1, 0(t0)
	
	j FIM

CHAR_JUMP:
    la t0, char_pos
    lh t0, 2(t0)
    li t1, 48
    ble t0, t1, FIM 
	la t0, caindo
	sh zero, 0(t0)
	la t0, subindo
	li t1, 1
	sh t1, 0(t0)
	la t0, faltaSubir
	li t1, 32
	sh t1, 0(t0)
	la t0, Esubindo
	sh zero, 0(t0)
	
	j FIM

PROX_FASE:
    la t0, fase
    li t1, 1
    sh t1, 0(t0)
	la t0, char_pos
    sh zero, 0(t0)
    li t1, 144
    
    sh t1, 2(t0)         
    la t0, deslocamento_x_mapa
    sh zero, 0(t0)
    j FIM
