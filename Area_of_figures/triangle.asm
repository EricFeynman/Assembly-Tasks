extern printf
section .data
     a dq 7.0
     b dq 9.0
     c dq 8.0
     p dq 0.0
     two dq 2.0
     f_p db "P = %f",10,0
     f_s db "S = %f",10,0
section .text
global main
main:
    push rbp
    mov rbp, rsp
    ;p - semi perimeter
    movsd xmm0, [a]
    addsd xmm0, [b]
    addsd xmm0, [c]
    movsd [p], xmm0
    
    mov rcx, f_p
    movq rdx, xmm0
    sub rsp, 32
    call printf
    add rsp, 32
    leave
    
    ;---area---
    push rbp
    mov rbp, rsp
    
    movsd xmm0, [p]
    divsd xmm0, [two]
    movsd [p], xmm0
    
    ;p*(p - a)
    movsd xmm1, [p]
    subsd xmm1, [a]
    mulsd xmm1, [p]
    ;p*(p - a)*(p - b) 
    movsd xmm2, [p]
    subsd xmm2, [b]
    mulsd xmm1, xmm2
    ;p*(p - a)*(p - b)*(p - c) 
    movsd xmm3, [p] 
    subsd xmm3, [c]
    mulsd xmm1, xmm3
    ;s * s =  p*(p - a)*(p - b)*(p - c)
    sqrtsd xmm1, xmm1
    
    mov rcx, f_s
    movq rdx, xmm1
    sub rsp, 32
    call printf
    add rsp, 32
    leave
    
   
    ret
