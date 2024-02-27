%include "io64.inc"
section .data
section .text
global main
reverse: 
     push rbp
     sub rsp, 8; выделение памяти под локальную переменную
     mov rbp, rsp; точка доступа к переменной через rbp
     push rdi
     cmp rdi, 0;условие рекурсии 
     jbe exit
     mov rax, rdi; локальная переменная
     mov rdx, rax
     sar rdx, 31
     mov rcx, 10
     idiv rcx
     PRINT_UDEC 8, rdx  ;остаток
     PRINT_STRING ' '
     mov rdi, rax   ;частное
     call reverse

exit:
    pop rdi
    add rsp, 8
    pop rbp
    ret 
    
main:
    xor rcx, rcx
    GET_DEC 8, rcx
    mov rdi, rcx
    call reverse
    ret
