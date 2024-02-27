%include 'io64.inc'
section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ;write your code here
    xor rax, rax    ;char
    xor rcx, rcx    ;flag = 0
    xor rbx, rbx    ;cnt = 0 
    xor rdx, rdx    ;maxLength = 0  
     
    
loop1:
    GET_CHAR rax
    cmp rax, '.'
    je last
    cmp rax, 10
    je symbol_print
    cmp rax, ' '
    je compare
    inc rbx
    xor rcx, rcx
    jmp loop1
  
compare:
    cmp rbx, rdx
    jna compare_end
    mov rdx, rbx
compare_end:
    xor rbx, rbx
    inc rcx
    jmp loop1
  
symbol_print:
    cmp rcx, 0
    jne symbol_print_continue
    mov rbx, rdx
symbol_print_continue:
    cmp rbx, 0
    je new
    PRINT_CHAR '*'
    dec rbx
    jmp symbol_print_continue
new:
    NEWLINE
    jmp loop1    
  
last:
    cmp rcx, 0
    jne last_continue
    mov rbx, rdx
last_continue:
    cmp rbx, 0
    je exit
    PRINT_CHAR '*'
    dec rbx
    jmp last_continue       
exit:
    ret
