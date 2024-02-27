%include "io64.inc"
section .text
global main
main:
    push rbp
    mov rbp, rsp; for correct debugging
    ;write your code here
    xor rax, rax
    GET_CHAR al
 
    cmp byte al, 'A'
    jne not_equal
    PRINT_STRING 'YES'
    jmp exit
not_equal: 
     PRINT_STRING 'NO'
    
exit:
    leave
    ret
