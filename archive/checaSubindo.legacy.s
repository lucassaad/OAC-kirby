# a0 = char_pos
# a1 = subindo
# a2 = faltaSubir
# a3 = Esubindo
checaSubindo:
	li t0, 1
	lh t1, 0(a1)
	bne t1, t0, FimChecaSubindo
	
	lh t0, 0(a2)						# t0 -> falttaSubir
	beqz t0, TerminaSubindo
	
	lh t1, 0(a3)
	beqz t1, SubindoEst1
	
	li t2, 1 
	beq t1, t2, SubindoEst2
	# subindo estado 3
	lh t1, 2(a0)
	addi t1, t1, 4
	sh t1, 2(a0)
	
	addi t0, t0, -4
	sh t0, 0(a2)
	
FimChecaSubindo: ret

TerminaSubindo:
	sh zero, 0(a1)
	li t0, 1
	la t1, caindo
	sh t0, (t0)
	j FimChecaSubindo
	
SubindoEst1:
	lh t2, 2(a0)
	addi t2, t2, 16
	sh t2, 2(a0)
	
	addi t0, t0, -16
	sh t0, 0(a2)
	
	addi t1, t1, 1
	sh t1, 0(a3)
	
	 j FimChecaSubindo
	  
SubindoEst2:
	lh t2, 2(a0)
	addi t2, t2, 8
	sh t2, 2(a0)
	
	addi t0, t0, -8
	sh t0, 0(a2)
	
	addi t1, t1, 1
	sh t1, 0(a3)
	
	 j FimChecaSubindo

	
