%include 'io64.inc'
section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ;mov rbp, rsp
    ;write your code here
    xor rax, rax    ;char
    xor rbx, rbx    ;num2
    xor rbp, rbp    ;num1
    mov rcx, 10     ;index   
    xor rdx, rdx    ;flag_num1
    xor rdi, rdi    ;flag_end_num1
    xor rsi, rsi    ;flag_num2
    xor r8, r8      ;sum
    xor r9, r9      ;dif
    xor r10, r10    ;mult
    xor r15, r15    ;space_flag
       
loop1:
    GET_CHAR rax 
    cmp rax, ' '
    je space
    cmp rax, 10
    je space
    cmp rax, '0'
    jbe error
    cmp rax, '9'
    ja error
    sub rax, '0'
    imul rbx, rcx
    add rbx, rax
    inc rdx  
    cmp rdi, 0
    jne second  
    jmp loop1
 
space:
    cmp rdx, 0
    je loop1
    cmp rsi, 0
    jne result 
    cmp r15, 0
    jne loop1
    mov rbp, rbx
    xor rbx, rbx
    inc rdi
    inc r15
    jmp loop1 
    
second:
    inc rsi
    jmp loop1 
    
error:
    PRINT_STRING "אתה טיפש" 
    NEWLINE
    PRINT_STRING "נסה בחיים הבאים"
    jmp exit
             
result:
    mov r8, rbp
    mov r9, rbp
    mov r10, rbp
    add r8, rbx
    sub r9, rbx
    imul r10, rbx
    PRINT_DEC 8, r8
    NEWLINE
    PRINT_DEC 8, r9
    NEWLINE
    PRINT_DEC 8, r10
exit: 
    ret
