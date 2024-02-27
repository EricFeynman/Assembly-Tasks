extern printf
section .data
    a dd 4
    b dd 8
    two dd 2
    perry db "P = %d",10,0
    area db "S = %d",10,0
section .text
global main
main:
    push rbp
    mov rbp, rsp
    
    ;p - perimeter
    mov rax, [a]
    add rax, [b]
    imul qword[two]
    
    mov rcx, perry
    mov rdx, rax
    sub rsp, 32
    call printf
    add rsp, 32
    leave
    
    ;---area---
    push rbp
    mov rbp, rsp
    
    ;a * b
    mov rax, [a]
    imul dword[b]
    
    mov rcx, area
    mov rdx, rax
    sub rsp, 32
    call printf
    add rsp, 32
    leave
    
    ret
