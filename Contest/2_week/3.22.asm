%include "io64.inc"
section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ;write your code here
    xor rax, rax    ;char
    xor rcx, rcx    ;cnt
loop1: 
    GET_CHAR rax
    cmp rax, 10
    je print
    push rax
    inc rcx
    jmp loop1
    
print:
    cmp rcx, 0
    je exit
    pop rax
    PRINT_CHAR rax
    dec rcx
    jmp print
         
exit:   
      ret
