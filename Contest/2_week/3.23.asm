%include "io64.inc"
section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ;write your code here
    xor rax, rax
    xor rcx, rcx
loop1: 
    GET_CHAR rax
    cmp rax, 10
    je print
    cmp rax, '.'
    je exit
    push rax
    inc rcx
    jmp loop1
     
new: 
    NEWLINE
    jmp loop1

print:
    cmp rcx, 0
    je new
    pop rax
    PRINT_CHAR rax
    dec rcx
    jmp print
        
exit:   
    cmp rcx, 0
    je end
    pop rax
    PRINT_CHAR rax
    dec rcx
    jmp print
  
end:
    ret
