%include 'io64.inc'
section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ;write your code here
    xor rax, rax    ;char
    xor rbx, rbx    ;cnt
    xor rcx, rcx    ;flag
    
loop1:
    GET_CHAR rax
    cmp rax, '.'
    je last
    cmp rax, 10
    je symbol_print
    cmp rax, ' '
    jne space
    xor rcx, rcx
    jmp loop1
    
space:
    cmp rcx, 0
    jne loop1
    inc  rbx
    inc rcx
    jmp loop1

symbol_print:
    cmp rbx, 0
    je to_zero
    PRINT_CHAR '*'
    dec rbx
    jmp symbol_print
 
to_zero:
    NEWLINE
    jmp loop1               
    
last:    
    cmp rbx, 0
    je exit
    PRINT_CHAR '*'
    dec rbx
    jmp symbol_print    
exit:
    ret
