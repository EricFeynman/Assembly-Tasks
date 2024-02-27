%include 'io64.inc'
section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ;write your code here
    xor rax, rax    ;char
    PRINT_CHAR '('
    
loop1:
    GET_CHAR rax
    cmp rax, '.'
    je exit
    cmp rax, 10
    je next_line
    cmp rax, ' '
    je space
    PRINT_CHAR rax
    jmp loop1
    
space:
    PRINT_CHAR ')'
    PRINT_CHAR ' '
    PRINT_CHAR '('
    jmp loop1

next_line:
    PRINT_CHAR ')'
    NEWLINE
    PRINT_CHAR '('
    jmp loop1               
    
exit:    
    PRINT_CHAR ')'   
    ret
