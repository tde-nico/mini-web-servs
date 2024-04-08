section .text
global _start

%define socket 41
%define bind 49
%define listen 50
%define accept 43
%define read 0
%define write 1
%define open 2
%define exit 60
%define af_inet 2
%define sock_stream 1
%define o_rdonly 0

_start:
	mov rdi, af_inet
	mov rsi, sock_stream
	mov rdx, 0
	mov rax, socket
	syscall

	mov r12, rax ; server socket

	mov rdi, r12
	mov rsi, address
	mov rdx, 16
	mov rax, bind
	syscall

	mov rdi, r12
	mov rsi, 10 ; max pending connections
	mov rax, listen
	syscall

	mov rdi, r12
	mov rsi, 0
	mov rax, accept
	syscall

	mov r13, rax ; client socket

	mov rdi, r13
	mov rsi, buffer
	mov rdx, 256
	mov rax, read
	syscall

	mov rdi, path
	mov rsi, o_rdonly
	mov rax, open
	syscall

	mov rdi, rax
	mov rsi, buffer2
	mov rdx, 256
	mov rax, read
	syscall

	inc rax

	mov rdi, r13
	mov rsi, buffer2
	mov rdx, rax
	mov rax, write
	syscall

	xor rdi, rdi
	mov rax, exit
	syscall


section .data

address:
	dw af_inet
	dw 0x901f ; 8080
	dd 0
	dq 0

buffer:
	db 256 dup 0

buffer2:
	db 256 dup 0

path:
	db "./index.html", 0
