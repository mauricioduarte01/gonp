%include "sleep.asm"

ESC		equ 	0x1b
SYS_WRITE	equ	1
STDOUT		equ	1
SYS_NANOSLEEP	equ	35
SYS_EXIT	equ	60
; delay		equ timespec

%define		bold	ESC, "[1m"
%define		blink	ESC, "[5m"
%define		reset	ESC, "[0m"
%define		reverse	ESC, "[5m"
%define		red	ESC, "[31m"
%define		blue	ESC, "[34m"
%define		white	ESC, "[97m"
%define		magenta	ESC, "[95;105m"
; %define		delay   timespec



section .data

text		db  bold, red,"Hello,", blue, " TIMESPEC!", reset,0,10
len		equ $ - text

text_exit	db  bold,magenta,"                ",reset, blink, reverse, ".",reset,0,10
len_exit	equ $ - text_exit

;timespec:			; struc TIMESPEC/SLEEP we access by calling "delay
;    .tv_sec	dq 3		; 5
;    .tv_nsec	dq 500000000		; 500000000

section .text
    global _start
_start:

	mov rax, SYS_WRITE
	mov rdi, STDOUT
	mov rsi, text
	mov rdx, len
	syscall
	
	xor rax,rax
	xor rdi,rdi
	
	call _sleep		; TIMESPEC defined in sleep.asm
;_sleep:
;	mov rdi, delay		; use it directly or call the struct?
;	mov rsi, 0		; xor rsi, rsi - don't store remaining time
;	mov rax, SYS_NANOSLEEP  ; 35 defined as global
;	syscall

	mov rax, SYS_WRITE
	mov rdi, STDOUT
	mov rsi, text_exit
	mov rdx, len_exit
	syscall
	
	call _sleep
	
	mov rax, SYS_EXIT
	xor rdi, rdi		; exit code 0
	syscall