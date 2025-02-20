.data
	.include "tilesDir16.s"
	.include "tilesEsq16.s"
	.include "matriz1.s"
	.include "matriz2.s"
	.include "checagemMapa1.s"
	.include "checagemMapa2.s"
	.include "tiles.s"
	
	
	deslocamento_x_mapa: 	.half 0
	fase:		.half 0
	char_pos:	.half 48, 128
	movendo: 	.half 0
	caindo: 	.half 0
	Ecaindo:	.half 0					# 0-2
	subindo:	.half 0
	Esubindo:	.half 0
	faltaSubir:	.half 32
	
	direcao: 	.half 0
	estado: 	.half 0
	
	
	Tempo_ultima_leitura:	.word 0x00000000
	.eqv tempo_poses 300
		
.text
mv s0, zero
loop:
	la t0, Tempo_ultima_leitura
	lw t1, 0(t0)
	csrr t2, time
	sub t3, t2, t1
	li t1, tempo_poses
	bgeu t3, t1, GAMELOOP
	j loop
GAMELOOP:
	
	la t0, Tempo_ultima_leitura
	sw t2, 0(t0)
	la t1, fase
	lh t1, 0(t1)
	
	beqz t1, C5
	la a0, checagemMatriz2
	j C6
	# fazer checagem de fase e asssociaer devida matriz de colisao 
C5:	la a0, checagemMatriz1
	 
C6:	call keyboard_input
	
# FUNÇAO PARA ATUALIZAR E SLAVAR ESTADO DO PERSONAGEM
	la t0, movendo
	lh a0, 0(t0)
	la t0, estado
	lh a1, 0(t0)
	la t0, caindo
	lh a2, 0(t0)
	la t0, subindo
	lh a3, 0(t0)
	call controleEstado
	la t0, estado
	sh a1, 0(t0)
#####
# inversão dde Frame
	mv a3, s0
	xori a3, a3, 1
# FUNÇÂO PARA PRINTAR MAPA
	la t0, deslocamento_x_mapa
	la a0, tiles
	la t1, fase
	lh t1, 0(t1)
	beqz t1, C3
	la a1, matriz2
	j call_print
C3:	la a1, matriz1
call_print:
	call print_mapa
	
# FUNÇÂO PARA PRINTAR PERSONAGEM 
	la t0, direcao
	lh t1, 0(t0)
	beqz t1, tileDir
	la a0, TilesEsq16
	j continue01
tileDir:
	la a0, TilesDir16
continue01:
	la t0, char_pos
	lh a1, 0(t0)
	lh a2, 2(t0)
	la t0, estado
	lh a4, 0(t0)
	call print_tile
# troca de frame
	mv s0, a3
	li t0, 0xFF200604
	sw s0, 0(t0)
######
# FUNÇÂO PARA CHECAR SE O PERSONAGEM DEVE PULAR/CONTINUAR SUBINDO
	la a0, char_pos
	la a1, subindo
	la a2, faltaSubir
	la a3, Esubindo
	call checaSubindo

# FUNÇAO PARA CHECAR SE O PERSONGAEM DEVE CAIR/CONTINUAR CAINDO 
	la a0, char_pos
	la t0, fase
	lh t0, 0(t0)
	beqz t0, C7
	la a1, checagemMatriz2
	j C8
C7: la a1, checagemMatriz1
C8:	la a2, caindo
	la a3, Ecaindo
	call checaCaindo


	j loop
.include "keyboard.s"
.include "controleEstados.s"
.include "print_tile.s"
.include "print_map.s"
.include "checaCaindo.s"
.include "checaSubindo.s"
