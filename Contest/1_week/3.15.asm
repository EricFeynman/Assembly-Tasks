%include 'io64.inc'
section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ;write your code here
    xor rax, rax
    xor rbx, rbx    ;cnt "("
    xor rcx, rcx    ;cnt ")"
    
loop1:
    GET_CHAR rax
    cmp rax, 10
    je compare
    cmp rax, '('
    je openpp
    cmp rax, ')'
    je closepp
    jmp loop1
    
openpp:
    inc rbx
    jmp loop1
    
closepp:
    inc rcx
    cmp rbx, rcx
    jb neg_answer
    jmp loop1

compare:
    cmp rbx, rcx
    jne neg_answer
    PRINT_STRING 'YES'
    jmp exit
neg_answer:
    PRINT_STRING 'NO'
    
exit:
    ret
