%include 'io.inc'
section .bss
m equ 3
n equ 3 
q equ 2
A resd m*n
B resd n*q
C resd m*q
section .text
global main
main:
    mov ebp, esp; for correct debugging
;Ввод матрицы A
    mov esi, 0  ;i = 0
l1:
    mov edi, 0  ;j = 0    
l2:
    GET_DEC 4, eax
    imul ecx, esi, n
    add ecx, edi
    mov dword[A + 4*ecx], eax
    
    inc edi
    cmp edi, n
    jl l2
    
    inc esi
    cmp esi, m
    jl l1
    
;Ввод матрицы B   
    mov esi, 0  ;i = 0
l3:
    mov edi, 0  ;j = 0    
l4:
    GET_DEC 4, eax
    imul ecx, esi, q
    add ecx, edi
    mov dword[B + 4*ecx], eax
    
    inc edi
    cmp edi, q
    jl l4
    
    inc esi
    cmp esi, n
    jl l3
    
;Вычисление произведение A и B    
    mov esi, 0  ;i = 0
l5:
    mov edi, 0  ;j = 0    
l6:
    mov ebp, 0  ;k = 0
l7:
    imul ecx, esi, n
    add ecx, ebp
    mov eax, dword[A + 4*ecx]
    imul ecx, ebp, q
    add ecx, edi
    imul eax, dword[B + 4*ecx]
    imul ecx, esi, q
    add ecx, edi
    add dword[C + 4*ecx], eax
    
    inc ebp
    cmp ebp, n
    jl l7
    
    inc edi
    cmp edi, q
    jl l6
    
    inc esi
    cmp esi, m
    jl l5
        
;Печать матрицы C    
    mov esi, 0  ;i = 0
print_l1:
    mov edi, 0  ;j = 0
print_l2:
    imul ecx, esi, q
    add ecx, edi
    mov eax, dword[C + 4*ecx]
    PRINT_DEC 4, eax
    NEWLINE
    
    inc edi
    cmp edi, q
    jl print_l2
    
    inc esi
    cmp esi, m
    jl print_l1

    ret
