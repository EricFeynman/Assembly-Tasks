%include 'io64.inc'
section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ;write your code here
    xor rax, rax    ;char
    xor rbx, rbx    ;cnt = 0    
    xor rdx, rdx    ;maxLength = 0
    
loop1:
    GET_CHAR rax
    cmp rax, '.'
    je last_compare
    cmp rax, 10
    je symbol_print_compare
    cmp rax, ' '
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
  
symbol_print_compare:
    cmp rbx, rdx
    jna symbol_print_compare_end
    mov rdx, rbx
symbol_print_compare_end:
    xor rbx, rbx
symbol_print:
    cmp rdx, 0
    je symbol_print_end
    PRINT_CHAR '*'
    dec rdx
    jmp symbol_print  
symbol_print_end:
    xor rbx, rbx
    NEWLINE
    jmp loop1    
  
last_compare:
    cmp rbx, rdx
    jna last_compare_end
    mov rdx, rbx
last_compare_end:
    xor rbx, rbx
last_print:
    cmp rdx, 0
    je exit
    PRINT_CHAR '*'
    dec rdx
    jmp last_print       
exit:
    ret
