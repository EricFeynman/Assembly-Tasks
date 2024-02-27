%include 'io.inc'
section .data
n dd 10
mas dd 6, 2, -3, 14, 100, -100,  67, -34, 23, 15
section .text
global main
main:
    mov ebp, esp; for correct debugging
    mov ecx, 0  ;i = 0
    mov ebx, 0  ;j = 0    
loop1:
    cmp ecx, [n] ;n * 4
    jge print_mas
loop2: 
    cmp ebx, 36 ;(n - 1) * 4
    jge loop3
    mov eax, dword[mas + ebx]
    mov edx, dword[mas + ebx + 4]
    cmp eax, edx     ;mas[j] > mas[j + 1]
    jg swap
    add ebx, 4
    jmp loop2
swap:
    xchg eax, edx   ;swap(eax,edx)
    mov dword[mas + ebx], eax
    mov dword[mas + ebx + 4], edx
    add ebx, 4
    jmp loop2
loop3:
    xor ebx, ebx
    inc ecx
    jmp loop1
print_mas:
    xor ecx, ecx
loop4:
    cmp ecx, [n] ;n * 4
    jge exit
    mov eax, dword[mas + ecx*4]
    PRINT_DEC 4, eax
    NEWLINE
    inc ecx
    jmp loop4  
exit:
    ret 
