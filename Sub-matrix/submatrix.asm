%include 'io.inc'
section .bss
m equ 4
n equ 4 
k equ 2
l equ 2
A resd m*n
B resd k*l
section .data
x dd 0
y dd 0
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
    
;Ввод координат началы отсчёта
    GET_DEC 4, eax  ;x = ...
    mov [x], eax
    GET_DEC 4, eax  ;y = ...
    mov [y], eax
;Построение подматрицы B матрицы A
    mov esi, [x]  ;i = x
    mov ebx, 0
l3:
    mov edi, [y]  ;j = y 
    mov edx, 0   
l4:
    imul ecx, esi, n
    add ecx, edi
    mov eax, dword[A + 4*ecx]
    imul ecx, ebx, l
    add ecx, edx
    mov dword[B + 4*ecx], eax
    
    inc edi            
    inc edx
    cmp edx, l
    jl l4
    
    inc esi
    inc ebx
    cmp ebx, k
    jl l3
        
;Печать матрицы B    
    mov esi, 0  ;i = 0
print_l1:
    mov edi, 0  ;j = 0
print_l2:
    imul ecx, esi, l
    add ecx, edi
    mov eax, dword[B + 4*ecx]
    PRINT_DEC 4, eax
    NEWLINE
    
    inc edi
    cmp edi, l
    jl print_l2
    
    inc esi
    cmp esi, k
    jl print_l1

    ret
