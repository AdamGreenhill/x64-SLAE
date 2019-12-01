#!/bin/bash

nasm -f elf64 linux_x64_reverse_shell.nasm

ld linux_x64_reverse_shell.o -o linux_x64_reverse_shell 

for i in $(objdump -D linux_x64_reverse_shell | grep "^ "|cut -f2); do echo -n '\\x'$i; done; echo
