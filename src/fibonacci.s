fibonacci:
        addi $t0, $0, 2    # $t0 = 2
        slt  $t0, $a0, $t0 # n <= 1 ?
        beq  $t0, $0, else # no: goto else
        add  $v0, $a0, $0  # $v0 = n
        jr   $ra           # return n
else:
        addi $sp, $sp, -12 # make room on stack
        sw   $a0, 8($sp)   # store $a0
        sw   $ra, 4($sp)   # store $ra
        sw   $s0, 0($sp)   # store $s0
        addi $a0, $a0, -1  # n = n - 1
        jal  fibonacci
        add  $s0, $v0, $0  # $s0 = fibonacci(n - 1)
        addi $a0, $a0, -1  # n = n - 2
        jal  fibonacci
        add  $v0, $s0, $v0 # $v0 = fibonacci(n - 1) + fibonacci(n - 2)
        lw   $s0, 0($sp)   # restore $s0
        lw   $ra, 4($sp)   # restore $ra
        lw   $a0, 8($sp)   # restore $a0
        addi $sp, $sp, 12  # restore $sp
        jr   $ra           # return

main:
        addi $a0, $0, 16
        jal  fibonacci     # fibonacci(16)
        add  $a0, $v0, $0
        addi $v0, $0, 1
        syscall            # print_int(987)
        addi $v0, $0, 10
        syscall            # exit
