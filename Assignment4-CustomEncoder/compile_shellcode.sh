#!/bin/bash

nasm -f elf64 decoder_stub.nasm

ld decoder_stub.o -o decoder_stub

for i in $(objdump -D decoder_stub | grep "^ "|cut -f2); do echo -n '\\x'$i; done; echo
