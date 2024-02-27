%include 'io64.inc'
section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ;write your code here
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx ;maxLength = 0
    
loop1:
    GET_CHAR rax
    cmp rax, '.'
    je last
    cmp rax, 10
    je compare
    inc rbx
    jmp loop1
    
compare:
    cmp rbx, rdx
    jna compare_end
    mov rdx, rbx
compare_end:
    xor rbx, rbx
    jmp loop1
    
last:    
    cmp rbx, rdx
    jna symbol_print
    mov rdx, rbx
symbol_print:
    cmp rdx, 0
    je exit
    PRINT_CHAR '*'
    dec rdx
    jmp symbol_print
    
exit:
    ret
