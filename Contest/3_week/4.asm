%include "io64.inc"
section .data
section .text
global main
reverse: 
     push rbp
     mov rbp, rsp; точка доступа к переменной через rbp
     sub rsp, 8; выделение памяти под локальную переменную
     
     cmp rdi, rsi
     jb exit
     
     
loop1:
     mov rax, rdi; локальная переменная
     mov rdx, rax
     sar rdx, 31
     mov rcx, rsi
     idiv rcx
        
     cmp rdx, 0
     jne to_zero
     PRINT_DEC 8, rsi
     PRINT_STRING ' '
     ;inc rsi
     mov rdi, rax   ;частное
     call reverse
     jmp exit
 
to_zero:
    inc rsi
    jmp loop1  
  
exit:
    add rsp, 8
    leave
    ret
    
 
    
main:
    push rbp
    mov rbp, rsp; for correct debugging
    xor rcx, rcx
    GET_DEC 8, rcx
    mov rdi, rcx
    mov rsi, 2
    call reverse
    leave
    ret
