        .data

m1:     .word 1, 2, 3, 4, 5, 6     # 2 x 3
m2:     .word 7, 8, 9, 10, 11, 12  # 3 x 2
res:    .word 0, 0, 0, 0           # 2 x 2

        .text

main:
        addi $s0, $0, 2            # number of lines m1, number of columns of m2
        addi $s1, $0, 3            # number of columns of m1, number of lines of m2

        addi $t0, $0, 0            # i = 0
loop1:
        beq  $t0, $s0, end_loop1
        addi $t1, $0, 0            # j = 0
loop2:
        beq  $t1, $s0, end_loop2
        addi $t2, $0, 0            # k = 0
        addi $t3, $0, 0            # sum = 0
loop3:
        beq  $t2, $s1, end_loop3

        mul  $t4, $t0, 3           # $t4 = i * 3
        add  $t4, $t4, $t2         # $t4 = i * 3 + k
        sll  $t4, $t4, 2           # $t4 = (i * 3 + k) * 4
        lw   $t4, m1($t4)          # $t4 = m1[i][k]

        sll  $t5, $t2, 1           # $t5 = k * 2
        add  $t5, $t5, $t1         # $t5 = k * 2 + j
        sll  $t5, $t5, 2           # $t5 = (k * 2 + j) * 4
        lw   $t5, m2($t5)          # $t5 = m2[k][j]

        mul  $t5, $t4, $t5         # $t5 = m1[i][k] * m2[k][j]
        add  $t3, $t3, $t5         # sum += m1[i][k] * m2[k][j]

        addi $t2, $t2, 1           # k++
        j    loop3
end_loop3:
        sll  $t5, $t0, 1           # $t5 = i * 2
        add  $t5, $t5, $t1         # $t5 = i * 2 + j
        sll  $t5, $t5, 2           # $t5 = (i * 2 + j) * 4
        sw   $t3, res($t5)         # res[i][j] = sum

        addi $t1, $t1, 1           # j++
        j    loop2
end_loop2:
        addi $t0, $t0, 1           # i++
        j    loop1
end_loop1:

        add  $t0, $0, $0
        addi $t1, $t0, 16          # number of bytes in res
print_matrix:
        lw   $a0, res($t0)
        addi $v0, $0, 1
        syscall                    # print_int(*(res + $t0))
        addi $a0, $0, 10
        addi $v0, $0, 11
        syscall                    # print newline
        addi $t0, $t0, 4
        bne  $t0, $t1, print_matrix
        addi $v0, $0, 10
        syscall                    # exit
