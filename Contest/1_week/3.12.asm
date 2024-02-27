%include 'io64.inc'
section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ;write your code here
    xor rax, rax    ;char
    
loop1:
    GET_CHAR rax
    cmp rax, '.'
    je last
    cmp rax, 10
    je next_line
    PRINT_CHAR rax
    jmp loop1

next_line:
    NEWLINE
    PRINT_STRING 'OK'
    NEWLINE
    jmp loop1               
  
last:
    NEWLINE
    PRINT_STRING 'OK'
    NEWLINE
exit:       
    ret
