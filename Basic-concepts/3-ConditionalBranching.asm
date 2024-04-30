global  _start

section .text
_start:
    xor rax, rax
    xor rbx, rbx
    inc rbx
loopFib:
    add rax, rbx
    xchg rax, rbx
    cmp rbx, 10		; do rbx - 10
    js loopFib		; jump if result is <0