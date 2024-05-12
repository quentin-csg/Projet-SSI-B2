#!/bin/bash

fileName="${1%%.*}"

nasm -f elf ${fileName}.s -o ${fileName}.o
ld -m elf_i386 -s ${fileName}.o -o ${fileName}

[ "$2" == "-g" ] && gdb -q ${fileName} || ./${fileName}

# nasm -f elf keylogger.asm
# ld -m elf_i386 -s -o keylogger keylogger.o