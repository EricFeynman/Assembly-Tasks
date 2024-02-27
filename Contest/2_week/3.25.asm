%include 'io64.inc'
section .text
global main
main:
    mov rbp, rsp
    ;write your code here
    xor rax, rax    ;chr
    xor rbx, rbx    ;num
    xor rcx, rcx    ;index   
    xor rdx, rdx    ;flag 
       
loop1:
    GET_CHAR rax 
    cmp rax, '.'
    je last
    cmp rax, '0'
    jbe symbol_print
    cmp rax, '9'
    ja symbol_print
    sub rax, '0'
    imul rbx, rcx
    add rbx, rax
    add rcx, 10
    inc rdx    
    jmp loop1
    
symbol_print:
    cmp rbx, 0
    je next
    PRINT_CHAR '*'
    dec rbx
    jmp symbol_print
  
next:
    xor rcx, rcx
    cmp rdx, 0
    je loop1
    NEWLINE
    xor rdx, rdx
    jmp loop1

last:
    cmp rbx, 0
    je exit
    PRINT_CHAR '*'
    dec rbx
    jmp symbol_print    
exit: 
    ret
