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

        mul  $t4, $t0, 8           # $t4 = i * 2 * 4
        add  $t4, $t4, $t2         # $t4 = i * 2 * 4 + k
        lw   $t4, m1($t4)          # $t4 = m1[i][k]

        mul  $t5, $t2, 12          # $t5 = k * 3 * 4
        add  $t5, $t5, $t1         # $t5 = k * 3 * 4 + j
        lw   $t5, m2($t5)          # $t5 = m2[k][j]

        mul  $t5, $t4, $t5         # $t5 = m1[i][k] * m2[k][j]
        add  $t3, $t3, $t5         # sum += m1[i][k] * m2[k][j]

        addi $t2, $t2, 1           # k++
        j loop3
end_loop3:
end_loop2:
end_loop1:
        j    end_loop1
