global  _start

section .text
_start:
    xor rax, rax    ; initialise rax à 0
    xor rbx, rbx    ; initialise rbx à 0
    inc rbx         ; incrémente rbx à 1
    mov rcx, 10     ; 10 itérations
loopFib:
    add rax, rbx    ; obtenir next number
    xchg rax, rbx   ; swap valeurs
    jmp loopFib