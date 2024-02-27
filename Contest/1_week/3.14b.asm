%include 'io64.inc'
section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ;write your code here
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    
loop1:
    GET_CHAR rax
    cmp rax, '.'
    je symbol_print
    cmp rax, 10
    je to_zero
    inc rbx
    jmp loop1
    
symbol_print:
    cmp rbx, 0
    je exit
    PRINT_CHAR '*'
    dec rbx
    jmp symbol_print
      
to_zero:
    xor rbx, rbx
    jmp loop1
    
exit:
    ret
