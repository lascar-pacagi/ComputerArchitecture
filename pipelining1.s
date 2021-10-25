        .text
        .globl	main

main:
        pushq	%rbp
        movq	%rsp, %rbp
        movq	$0, %rax
        movq	$2, %rbx
        movq    $3, %rcx
        movq    $4, %rdx
        movq    $5, %r8
        movq    $6, %r9
        movq    $7, %r10
        movq    $8, %r11
        movq    $9, %r12

        jmp	.test_loop
.loop:
        addq    %rbx, %rcx
        addq    %rcx,  %rdx
        addq    %rdx, %r8
        addq    %r8, %r9
        addq    %r9, %r10
        addq    %r10, %r11
        addq    %r11, %r12

        addq	$1, %rax
.test_loop:
        cmpq	$999999999, %rax
        jle	.loop
        movq	$0, %rax
        popq	%rbp
        ret
