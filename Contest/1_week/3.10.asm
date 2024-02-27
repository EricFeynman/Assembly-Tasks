%include "io64.inc"
section .bss
section .text
global main
main:
    mov rbp, rsp; for correct debugging
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
L:
    GET_CHAR al 
    cmp al, 10
    je exit
    cmp al, 0
    je exit
    cmp al, '+'
    je good1
    cmp al, '-'
    je good2
    jmp L
    
good1:
    inc rbx
    jmp L
      
good2:
    inc rcx
    jmp L
    
exit:
    xor rax, rax
    mov rax, rcx
    mul rbx
    PRINT_UDEC 8, rax
    NEWLINE
 
L2:
    cmp rax, 0
    JE end
    PRINT_CHAR '*'
    dec rax
    jmp L2

end: 
    ret
