global  _start
extern  printf

section .data
    message db "Fibonacci Sequence:", 0x0a
    outFormat db  "%d", 0x0a, 0x00

section .text
_start:
    call printMessage
    call initFib
    call loopFib
    call Exit

printMessage:
    mov rax, 1
    mov rdi, 1
    mov rsi, message
    mov rdx, 20
    syscall
    ret

initFib:
    xor rax, rax
    xor rbx, rbx
    inc rbx
    ret

printFib:
    push rax
    push rbx
    mov rdi, outFormat
    mov rsi, rbx
    call printf
    pop rbx
    pop rax
    ret

loopFib:
    call printFib
    add rax, rbx
    xchg rax, rbx
    cmp rbx, 10
    js loopFib
    ret

Exit:
    mov rax, 60
    mov rdi, 0
    syscall