%include 'io64.inc'
section .text
global main
main:
    mov rbp, rsp
    ;write your code here
    xor rbx, rbx
    xor rax, rax
       
L:
    GET_CHAR rbx 
    cmp rbx, '0'
    jbe exit
    cmp rbx, '9'
    ja exit
    sub rbx, '0'
    add rax, rbx    
    jmp L
    
exit: 

    cmp rbx, 0xa
    jne L
    PRINT_UDEC 8, rax
    NEWLINE
    
L2:
    cmp rax, 0
    je end
    PRINT_CHAR '*'
    dec rax
    jmp L2

end: 
    ret
