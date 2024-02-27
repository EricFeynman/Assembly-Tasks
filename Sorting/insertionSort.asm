%include 'io.inc'
section .bss
n equ 5
mas resd n
section .text
global main
main:
    mov ebp, esp; for correct debugging
    ;GET_DEC 4, n
    mov edx, n  
    mov ecx, 0  ;i = 0
input:
    cmp ecx, edx
    jge to_zero
    GET_DEC 4, eax
    mov dword[mas + ecx*4], eax
    inc ecx
    jmp input
to_zero:
    mov ecx, 1
    dec edx
insertionSort:
    cmp ecx, edx 
    jg print_mas
    mov esi, ecx    ;j = i - 1
    dec esi
    mov ebx, esi
    inc ecx
while:
    cmp ebx, 0
    jl insertionSort
    mov eax, dword[mas + ebx*4]
    mov edi, dword[mas + (ebx+1)*4]
    cmp eax, edi
    jle insertionSort
    xchg eax, edi   ;swap(eax,edi)
    mov dword[mas + ebx*4], eax
    mov dword[mas + (ebx+1)*4], edi
    dec ebx
    jmp while
print_mas:
    xor ecx, ecx
    inc edx
output:
    cmp ecx, edx ;n * 4
    jge exit
    mov eax, dword[mas + ecx*4]
    PRINT_DEC 4, eax
    NEWLINE
    inc ecx
    jmp output  
exit:
    ret
