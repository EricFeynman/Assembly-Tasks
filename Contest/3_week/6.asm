%include "io64.inc" 
section .data 
    HEAP_MAX_SIZE equ 256 
    NULL equ 0 
    step equ 32
section .bss 
    struc memory_node 
        next_node resq 3 
    endstruc  
     
    struc tree_node 
        data resq 1 
        left resq 1 
        right resq 1  
    endstruc 
     
    heap resq HEAP_MAX_SIZE * memory_node_size 
    heap_ptr resq 1 
     
    root resq 1 
    
    buf resq 256
section .text 
global main 
main: 
    mov rbp, rsp; for correct debugging 
    ;write your code here 
    xor rax, rax 
    call init_heap 
     
    GET_DEC 8, rdx
loop_enter:
    cmp rdx, 0
    je loop_print
    GET_DEC 8, rax
    
    push rax
    push root 
    call insert 
    add rsp, 16
    dec rdx
    jmp loop_enter 
     
loop_print:     
    push qword[root] 
    call printTree 
    add rsp, 8 
    NEWLINE 
     
    push qword[root]
    call  treeDepth
    add rsp, 8
    PRINT_STRING 'Depth of tree: '
    PRINT_DEC 8, r8 
    NEWLINE 
     
    ;inc r8
    PRINT_STRING 'Elements: ' 
    NEWLINE 
    push qword[root]
    call treeNumDepth 
    add rsp, 8 
    NEWLINE  
    ret 
;-----------------//MALLOC//----------------- 
init_heap: 
push rbp 
mov rbp, rsp 
    lea rsi, [heap] 
    mov [heap_ptr], rsi 
    mov rdi, rsi 
    add rdi, memory_node_size 
    mov rcx, HEAP_MAX_SIZE 
cycle1: 
    mov [rsi + next_node], rdi 
    add rsi, memory_node_size 
    add rdi, memory_node_size 
    loop cycle1 
     
    mov qword[rsi - memory_node_size + next_node], NULL 
leave  
ret 
new: 
    push rbp 
    mov rbp, rsp 
     
    xor rcx, rcx 
cycle2: 
    cmp rcx, [rbp + 16] 
    jnl end 
    add rcx, memory_node_size 
    jmp cycle2 
end: 
    mov rax, [heap_ptr] 
    cmp rax, NULL 
    je bad_malloc 
     
    add [heap_ptr], rcx 
     
    jmp finish_malloc 
bad_malloc: 
    PRINT_STRING "STATUS_NO_MEMORY\n" 
finish_malloc: 
leave  
ret     
 
getFreeNode: 
push rbp 
mov rbp, rsp 
    push qword tree_node_size 
    call new  
    add rsp, 8 
     
    push qword[rbp + 16] 
    pop qword[rax + data] 
      
    mov qword[rax + left], NULL 
    mov qword[rax + right], NULL 
leave  
ret 
 
;-----------------//INSERT//----------------- 
insert: 
push rbp 
mov rbp, rsp 
    mov rsi, [rbp + 16] 
    cmp qword[rsi], NULL 
    jne not_empty 
empty: 
    push qword[rbp + 24] 
    call getFreeNode 
    add rsp, 8 
    mov [rsi], rax 
    jmp finish_insert 
not_empty: 
    push qword[rbp + 24]    ;data 
    push qword[rsi] 
    call insert_continue 
    add rsp, 8 
finish_insert: 
leave 
ret 
     
 
insert_continue: 
push rbp 
mov rbp, rsp 
    mov rsi, [rbp + 16] 
    mov rbx, [rbp + 24] 
    cmp rbx, [rsi + data] 
    jnl to_right 
to_left: 
    cmp qword[rsi + left], NULL 
    jne left_not_empty 
left_is_empty: 
    push rbx 
    call getFreeNode 
    add rsp, 8 
    mov [rsi + left], rax 
    jmp finish_insert_continue 
left_not_empty: 
    push rbx 
    push qword[rsi + left] 
    call insert_continue 
    add rsp, 8 
    jmp finish_insert_continue 
to_right: 
    cmp qword[rsi + right], NULL 
    jne right_not_empty 
right_is_empty: 
    push rbx 
    call getFreeNode 
    add rsp, 8 
    mov [rsi + right], rax 
    jmp finish_insert_continue 
right_not_empty: 
    push rbx 
    push qword[rsi + right] 
    call insert_continue 
    add rsp, 16 
    jmp finish_insert_continue 
finish_insert_continue: 
leave 
ret 
         
;-----------------//PRINT_TREE//----------------- 
printTree: 
push rbp 
mov rbp, rsp 
    mov rsi, [rbp + 16] 
    cmp rsi, NULL 
    je finish_print 
     
    push rsi  
    push qword[rsi + left] 
    call printTree 
    add rsp, 8 
    pop rsi 
     
    PRINT_DEC 8, [rsi + data] 
    PRINT_CHAR ' ' 
     
    push qword[rsi + right] 
    call printTree 
    add rsp, 8 
finish_print: 
leave  
ret      
 
;-----------------//NUMDEPTH//----------------- 
treeNumDepth: 
push rbp 
mov rbp, rsp 
sub rsp, 8 
    cmp qword[rbp + 16], NULL 
    je nilNum 
    mov rsi, [rbp + 16] 
    push rsi 
    push qword[rsi + left] 
    call treeNumDepth 
    add rsp, 8 
    pop rsi 
     
    mov qword[rbp - 8], rax  
    push rsi 
    push qword[rsi + right] 
    call treeNumDepth
    add rsp, 8 
    pop rsi 
     
    cmp qword[rbp - 8], rax 
    jnl returnNumleft 
    inc rax
    mov r9, r8
    sub r9, rax
    PRINT_DEC 8, r9
    PRINT_STRING ': ' 
    PRINT_DEC 8, [rsi + data]
    ;mov [buf + r9 * step], [rsi + data] 
    NEWLINE 
    jmp finishNumdepth 
returnNumleft: 
    mov rax, qword[rbp - 8] 
    inc rax 
    mov r9, r8
    sub r9, rax
    PRINT_DEC 8, r9
    PRINT_STRING ': ' 
    PRINT_DEC 8, [rsi + data] 
    ;mov [buf + r9 * step], [rsi + data]
    NEWLINE 
    jmp finishNumdepth 
nilNum: 
    xor rax, rax 
finishNumdepth: 
leave  
ret

;-----------------//DEPTH//----------------- 
treeDepth: 
push rbp 
mov rbp, rsp 
sub rsp, 8 
    cmp qword[rbp + 16], NULL 
    je nil 
    mov rsi, [rbp + 16] 
    push rsi 
    push qword[rsi + left] 
    call treeDepth 
    add rsp, 8 
    pop rsi 
     
    mov qword[rbp - 8], r8 
     
    push rsi 
    push qword[rsi + right] 
    call treeDepth 
    add rsp, 8 
    pop rsi 
     
    cmp qword[rbp - 8], r8 
    jnl return_left 
    inc r8 
    jmp finish_depth 
return_left: 
    mov r8, qword[rbp - 8] 
    inc r8  
    jmp finish_depth 
nil: 
    xor r8, r8 
finish_depth: 
leave  
ret
