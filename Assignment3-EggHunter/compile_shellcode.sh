#!/bin/bash

nasm -f elf64 egghunter.nasm

ld egghunter.o -o egghunter

for i in $(objdump -D egghunter | grep "^ "|cut -f2); do echo -n '\\x'$i; done; echo
