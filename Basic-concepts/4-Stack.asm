global  _start

section .text
_start:
    xor rax, rax
    xor rbx, rbx
    inc rbx
    push rax        ; push registers to stack
    push rbx

loopFib:
    add rax, rbx
    xchg rax, rbx
    cmp rbx, 10
    js loopFib

    pop rbx         ; restore registers from stack
    pop rax