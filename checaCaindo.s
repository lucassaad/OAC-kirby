# a0 -> char_pos
# a1 -> matriz1
# a2 -> caindo

checaCaindo:

    la t0, subindo
    lh t0, 0(t0)
    bnez t0, FimCaindo

	lh t0, 0(a0)	#t0 = pos x do personagem 
	lh t1, 2(a0)	# t1 = pos y do personagem 
	la t3, deslocamento_x_mapa
	lh t3, 0(t3)
	add t0, t0, t3
	
	li t2, 16
	
	div t0, t0, t2
	add a1, a1, t0
	div t1, t1, t2
	addi t1, t1, 1
	li t2, 70
	mul t1, t1, t2
	add a1, a1, t1
	lb t0, 0(a1)
	
	 
	beqz t0, Caindo
	sh zero, 0(a2)
	sh zero, 0(a3)
	j FimCaindo
Caindo:
	la t0, subindo
	sh zero, 0(t0)
	
	li t0, 1
	sh t0, 0(a2)
	lh t0, 2(a0)
	
	li t1, 2
	lh t2, 0(a3)
	blt t2, t1, Caindo1
	addi t0, t0, 8
	j continue2
Caindo1:
	addi t0, t0, 4
	addi t2, t2, 1
	sh t2, 0(a3)
continue2:
	sh t0, 2(a0)
FimCaindo: ret
	
