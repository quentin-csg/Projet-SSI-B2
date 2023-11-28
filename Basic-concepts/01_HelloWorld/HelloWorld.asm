global _start

section .data
    message db "Hello World!"
    length equ $-message

section .text
_start:
    mov rax, 1  ; appel système write
    mov rdi, 1  ; où écrire les données ( en l'occurrence  le descripteur de fichier pour la sortie standard (stdout) )
    mov rsi, message  ; quelles données écrire
    mov rdx, length ; longueurs des données à écrire
    syscall

    mov rax, 60  ; appel système exit
    mov rdi, 0  ; code sortie 0 (normale)
    syscall