%include "io64.inc"
extern printf
section .data
section .bss
    msg resb 100 
section .text
global main
main:
    mov rbp, rsp; for correct debugging   
    xor rcx, rcx  ;length
    mov rax, msg    ;string
    xor rbx, rbx    ;char
    xor rdx, rdx    ;num
loop1:
    GET_CHAR rbx 
    mov [rax + rcx], rbx
    inc rcx
    cmp rbx, '.'
    je to_func
    jmp loop1
    
to_func:
    push rax
    push rcx
    call str_to_num
    add rsp, 16
    
    PRINT_DEC 8, rdx
    ret
    
;-----------------//CONVERT STRING TO NUMBER//-----------------
str_to_num:
push rbp
mov rbp, rsp
    push rsi    ;char
    push rdi    ;index
    xor rdi, rdi
loop2:
    cmp rdi, rcx
    jnb str_to_num_exit
    mov rsi, qword[rax + rdi]
    cmp rsi, '0'
    jbe to_next
    cmp rax, '9'
    ja to_next
    sub rsi, '0'
    imul rdx, rdi
    add rax, rsi
    inc rdi   
    jmp loop2
    
to_next:
    inc rdi
    jmp loop2
    
str_to_num_exit:
    pop rdi
    pop rsi
    ;mov rdx, rax
    leave
    ret
    
