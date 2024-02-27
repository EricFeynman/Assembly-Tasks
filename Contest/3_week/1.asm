%include "io64.inc"
section .bss
msg resb 200
msg2 resb 200
bufer resq 200
max resq 1
min resq 1
index_max resq 1
index_min resq 1
section .text

scan:
    push rbp
    mov rbp, rsp
    
L:  
    GET_CHAR al
    mov [rsi+rcx], al
    inc rcx
    cmp rcx, 1
    je bukva
    cmp al, '.'
    je exit
    jmp L
    
bukva:
        mov al, [rsi]
        cmp al, 'A'
        jb next
        cmp al, 'Z'
        ja next
        PRINT_STRING '1_BUKVA_ZAGLAVNAYA'
        NEWLINE
        jmp L
        
next:
        PRINT_STRING '1_BUKVA_STROCHNAYA'
        NEWLINE
        jmp L
        
        
exit:
    mov rsp, rbp
    pop rbp
    ret 


probel:
      push rbp
      mov rbp, rsp
 
L2:
    mov al,[rsi+rcx]
    cmp al, ' '
    je go
    mov [rdi+rdx], al
    inc rcx
    inc rdx
    cmp al, '.'
    je vse
    jmp L2
    
    
go: 
    cmp al, [rsi+rcx+1]
    je go2
    mov [rdi+rdx], al
    inc rcx
    inc rdx
    jmp L2
    
go2:
    inc rcx
    jmp L2
    
vse:
       mov rsp, rbp
       pop rbp
       ret
       
       
create:
         push rbp
         mov rbp, rsp
         
L3:
    mov al, [rsi+rcx]
    cmp al, 'A'
    jae next2
    cmp al, '.'
    je exit3
    inc rcx
    jmp L3


next2:
     cmp al, 'Z'
     ja net
     add al, ' '
     mov [rsi+rcx], al
     inc rcx
     jmp L3

net:
    inc rcx
    jmp L3
    
    
exit3:
      mov [rsi+rcx], al
      mov rsp, rbp
      pop rbp
      ret
    
    

print:
     push rbp
     mov rbp, rsp
    
    
L4:


    mov al, [rsi+rcx]
    PRINT_CHAR al
    cmp al, '.'
    je exit4
    inc rcx
    jmp L4
          

exit4:
     mov rsp, rbp
     pop rbp
     ret



poisk:
      push rbp
      mov rbp, rsp
      
      
L5: 
    cmp r8, qword[max]
    ja peresilka
    xor r8, r8
    mov al, [rsi+rcx]
    cmp al, '.'
    je exit5
    inc rcx
    xor rbx, rbx
    jmp L6
    
    
L6: 
    cmp rbx, rdx
    je L5
    cmp al, [rsi+rbx]
    je good
    inc rbx
    jmp L6

good:
     inc r8
     inc rbx
     jmp L6    
       
       
peresilka:
         mov qword[max], r8
         mov qword[index_max], rcx
         jmp L5
        
exit5:
       mov rsp, rbp
       pop rbp
       ret
        
        
        
        
poisk2:
    push rbp
    mov rbp, rsp
    mov qword[min], 100  
        
L7:
    cmp r8, qword[min]
    jb peresilka2
    xor r8, r8
    mov al, [rsi+rcx]
    cmp al, '.'
    je exit6
    inc rcx
    xor rbx, rbx
    jmp L8
    
L8:
    cmp rbx, rdx
    je L7
    cmp al, [rsi+rbx]
    je good3
    inc rbx
    jmp L8
        
good3:
     inc r8     ;cnt
     inc rbx    ;index
     jmp L8
     
     
peresilka2:
         mov qword[min], r8
         mov qword[index_min], rcx
         jmp L7
  
exit6:
       mov rsp, rbp
       pop rbp
       ret
                
        
                    
global main
main:
    mov rbp, rsp; for correct debugging
    ;write your code here
    xor rcx, rcx 
    xor rax, rax
    xor rdx, rdx
    
    mov rsi, msg
    call scan
    
    xor rcx, rcx
    mov rdi, msg2
    call probel
    
    mov rsi, msg2
    mov rcx, 1
    call create
    
    xor rcx, rcx
    mov rsi, msg2
    ;в rdx размер строки
    xor rcx, rcx
    mov al, [msg2]
    add al, 32
    mov [msg2], al
    call print
    
    mov rsi, msg2
    xor rcx, rcx
    xor r8, r8
    xor rbx, rbx
    call poisk
    NEWLINE
    
    xor rax, rax
    xor rcx, rcx
    mov rcx, [index_max]
    dec rcx
    
   
    mov al, [msg2+rcx]
    PRINT_CHAR al
    NEWLINE
    
    mov rsi, msg2
    xor rcx, rcx
    xor rbx, rbx
    xor r8, r8
    call poisk2
    mov rcx, [index_min]
    mov al, [msg2+rcx]
    PRINT_CHAR al
    
    ret
