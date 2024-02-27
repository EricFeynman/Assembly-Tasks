%include "io64.inc"
section .text
global main
main:
    ;write your code here
    xor rax, rax
    GET_CHAR al
    cmp al, '0'
    jb exit
    cmp al, '9'
    ja exit
    
    sub al, '0'
    xor rcx, rcx

L:
    cmp al, 0
    je exit
    PRINT_CHAR '*'
    dec al
    jmp L
    
exit:
    ret
