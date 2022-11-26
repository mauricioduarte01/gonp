%define delay timespec
; %define SYS_NANOSLEEP 35

timespec:
    .tv_sec	dq 3		; 3 seconds 
    .tv_nsec	dq 500000000	; 5 nanoseconds

section .text

global sleep

_sleep:
	mov rdi, delay
	xor rsi, rsi 
	mov rax, SYS_NANOSLEEP
	syscall	
	
	ret