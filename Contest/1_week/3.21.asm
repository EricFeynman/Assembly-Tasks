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
    xor rdi, rdi    ;flag_op
    xor rsi, rsi    ;flag_num2
    xor r8, r8      ;flag_error
    xor r9, r9      ;op
    xor r10, r10    ;start
    xor r15, r15    ;flag_space
       
loop1:
    GET_CHAR rax 
    cmp rax, 10
    je result
    cmp r8, 0
    jne loop1
    cmp rax, '.'
    je last
    cmp rax, '+'
    je op
    cmp rax, '-'
    je op
    cmp rax, '*'
    je op
    cmp rax, '/'
    je op
    cmp rax, ' '
    je start
    cmp rax, '0'
    jbe error
    cmp rax, '9'
    ja error
    sub rax, '0'
    imul rbx, rcx
    add rbx, rax
    inc r10  
    jmp loop1

start:
    cmp r10, 0
    jne error
    jmp loop1

op:
    cmp rdi, 0
    jne error
    mov r9, rax
    mov rbp, rbx
    xor rbx, rbx
    inc rdi 
    jmp loop1
 
to_zero:
    xor rdi, rdi
    xor rbx, rbx
    xor r8, r8
    xor r10, r10
    NEWLINE
    jmp loop1
    
error:
    PRINT_STRING "ERROR"
    inc r8
    jmp loop1
             
result:
    cmp r8, 0
    jne to_zero
    cmp r9, '+'
    je add_res
    cmp r9, '-'
    je sub_res
    cmp r9, '*'
    je mult_res
    cmp r9, '/'
    je div_res
    
add_res:
    add rbp, rbx
    PRINT_DEC 8, rbp
    jmp to_zero
sub_res:
    sub rbp, rbx
    PRINT_DEC 8, rbp
    jmp to_zero
mult_res:
    imul rbp, rbx
    PRINT_DEC 8, rbp
    jmp to_zero
div_res:
    mov rax, rbp
    mov rdx, rax
    sar rdx, 31
    mov rcx, rbx
    idiv rcx
    PRINT_DEC 8, rax
    jmp to_zero
 
last: 
    cmp r8, 0
    jne to_zero
    cmp r9, '+'
    je add_res_last
    cmp r9, '-'
    je sub_res_last
    cmp r9, '*'
    je mult_res_last
    cmp r9, '/'
    je div_res_last
add_res_last:
    add rbp, rbx
    PRINT_DEC 8, rbp
    jmp exit
sub_res_last:
    sub rbp, rbx
    PRINT_DEC 8, rbp
    jmp exit
mult_res_last:
    imul rbp, rbx
    PRINT_DEC 8, rbp
    jmp exit
div_res_last:
    mov rax, rbp
    mov rdx, rax
    sar rdx, 31
    mov rcx, rbx
    idiv rcx
    PRINT_DEC 8, rax
    jmp exit
   
exit:
    ret
