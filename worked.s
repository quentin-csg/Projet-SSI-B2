section .bss
    buffer resb 24

section .text
    global _start

_start:
    mov eax, 5          ; sys_open
    mov ebx, input_file
    mov ecx, 0          ; O_RDONLY mode
    int 0x80

    ; Check for error
    test eax, eax
    js exit             ; if error, exit

read_loop:
    ; Read data
    mov eax, 3          ; sys_read
    mov ebx, eax        ; file descriptor
    mov ecx, buffer
    mov edx, 24
    int 0x80

    ; Check end of file
    test eax, eax
    jz exit             ; if end of file exit

    ; Print data
    mov eax, 4          ; sys_write
    mov ebx, 1          ; file descriptor (stdout)
    mov ecx, buffer
    mov edx, 24
    int 0x80

    jmp read_loop

exit:
    mov eax, 1          ; sys_exit
    xor ebx, ebx
    int 0x80

section .data
    input_file db "/dev/input/event0", 0