# colunas a serem printadas = 320  = 20 quadrados da matriz
# linhas a serem printadas = 192 = 12 quadrados da matrtiz
#s10 = contador de coluna
#s11 = contador de linha  

# t0 -> deslocamento x do mapa
# a0 -> ende3reço com conjuntos de tiles 
# a1 -> matriz a serprintada
 
print_mapa:
# calcula primeiro tile a ser printaddo
	li t1, 16	# tamanho de cada tile representada na matriz
	lh t0, 0(t0)
	div t1, t0, t1  
	add a1, a1, t1
	mv a5, a1
	mv s10, zero
	mv s11, zero
	
PrintTileMap:
	# a0 -> tiles
	li t0, 16
	mul t1, t0, s10
	mv a1, t1
	mul t1, t0, s11
	mv a2, t1
	lb a4, 0(a5)
	
	addi sp, sp, -4
	sw ra, 0(sp)
	
	call print_tile
	
	lw ra, 0(sp)
	addi sp, sp, 4
	
	addi s10, s10, 1
	li t0, 20
	addi a5, a5, 1
	blt s10, t0, PrintTileMap
	
	addi s11, s11, 1
	mv s10, zero
	
	addi a5, a5, 50
	
	li t0, 12
	blt s11, t0, PrintTileMap
	ret
	
																
	
	
	
	
