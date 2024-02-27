%include 'io64.inc'
section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ;write your code here
    xor rax, rax    ;char
    xor rbx, rbx    ;cnt
    ;xor rcx, rcx
    
loop1:
    GET_CHAR rax
    cmp rax, '.'
    je last
    cmp rax, 10
    je symbol_print
    inc rbx
    jmp loop1
    
symbol_print:
    cmp rbx, 0
    je to_zero
    PRINT_CHAR '*'
    dec rbx
    jmp symbol_print
      
to_zero:
    ;xor rbx, rbx
    NEWLINE
    jmp loop1
    
last:
    cmp rbx, 0
    je exit
    PRINT_CHAR '*'
    dec rbx
    jmp last
    
exit:
    ret
