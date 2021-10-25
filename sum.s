main:
        add  $t0, $0, $0
        addi $t1, $0, 1
        addi $t2, $0, 101
loop:
        slt  $t3, $t1, $t2
        beq  $t3, $0, endloop
        add  $t0, $t0, $t1
        addi $t1, $t1, 1
        b loop
endloop:
        #b endloop
        add  $a0, $t0, $0
        addi $v0, $0, 1
        syscall
        addi $v0, $0, 10
        syscall
