.data
# Número de Notas a tocar
NUM: .word 39
# Lista de nota,duração,nota,duração,nota,duração,...
NOTAS: .half 79,249,79,83,91,333,84,499,96,333,93,166,91,333,84,499,91,333,89,166,88,166,88,166,89,166,91,166,84,333,86,333,88,1332,91,333,84,499,96,333,93,166,91,333,84,499,91,333,89,166,88,166,88,166,89,166,91,166,84,333,86,333,84,1332,84,249,84,83,86,166,88,333,84,166,86,166,84,166

.text
.globl _start
_start:
    la s0, NUM        # Carrega o endereço do número de notas
    lw s1, 0(s0)      # Lê o número de notas
    la s0, NOTAS      # Carrega o endereço das notas
    li t0, 0          # Zera o contador de notas
    li a2, 0         # Define o instrumento
    li a3, 127        # Define o volume

    # Obtém o tempo inicial
    li a7, 30         # Syscall para obter o tempo atual em milissegundos
    ecall
    mv t2, a0         # Salva o tempo inicial em t2

LOOP:
    beq t0, s1, FIM1   # Se o contador chegou ao final, vá para FIM

    # Toca a nota atual
    lh a0, 0(s0)      # Lê o valor da nota
    lh a1, 2(s0)      # Lê a duração da nota
    li a7, 31         # Syscall para tocar a nota
    ecall             # Toca a nota

    # Calcula o tempo de término da nota
    add t3, t2, a1    # t3 = tempo inicial + duração da nota

WAIT:
    li a7, 30         # Syscall para obter o tempo atual em milissegundos
    ecall
    blt a0, t3, WAIT  # Espera até que o tempo atual seja >= tempo de término

    # Atualiza o tempo inicial para a próxima nota
    mv t2, t3         # t2 = tempo de término da nota atual

    # Avança para a próxima nota
    addi s0, s0, 4    # Incrementa para o endereço da próxima nota
    addi t0, t0, 1    # Incrementa o contador de notas
    j LOOP            # Volta ao loop

FIM1:
    # Toca uma nota final 
    li a0, 40         # Define a nota
    li a1, 1500       # Define a duração da nota em ms
    li a2, 127        # Define o instrumento
    li a3, 127        # Define o volume
    li a7, 31         # Syscall para tocar a nota
    ecall             # Toca a nota

    # Reinicia a música
    j loop

