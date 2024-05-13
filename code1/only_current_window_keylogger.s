section .data
    filename db "output.txt", 0

section .bss
    fd resq 1
    user_input resb 256

section .text
    global _start

_start:
    call createFile

input_loop:
    call readInput
    call writeInput
    call checkExit
    jmp input_loop

createFile:
    mov rax, 2           ; sys_open
    mov rdi, filename
    mov rsi, 0102o   ; O_CREAT  S_IXUSR | S_IWOTH
    mov rdx, 0644o
    syscall

    mov [fd], rax
    ret

readInput:
    mov rax, 0          ; sys_read
    mov rdi, 0
    mov rsi, user_input
    mov rdx, 256
    syscall
    ret

writeInput:
    mov rax, 1          ; sys_write
    mov rdi, [fd]
    mov rsi, user_input
    mov rdx, 256
    syscall
    ret

checkExit:
    mov rsi, user_input
    mov al, [rsi]
    cmp al, "!"
    je closeFile
    ret

closeFile:
    mov rax, 3      ; sys_close
    mov rdi, [fd]
    syscall
    jmp Exit
    ret

Exit:
    mov rax, 60      ; sys_exit
    xor rdi, rdi
    syscall