section .data
    filename db "output.txt", 0

section .bss
    fd resq 1             ; Change from resd to resq for 64-bit
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
    mov rax, 2
    mov rdi, filename
    mov rsi, 0102o
    mov rdx, 0666o        ; Corrected permission format
    syscall

    mov [fd], rax
    ret

readInput:
    mov rax, 0
    mov rdi, 0
    mov rsi, user_input
    mov rdx, 256
    syscall
    ret

writeInput:
    mov rax, 1
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
    mov rax, 3
    mov rdi, [fd]
    syscall
    jmp Exit
    ret

Exit:
    mov rax, 60
    xor rdi, rdi
    syscall