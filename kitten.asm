;Kitten: stupidly overoptimized replacement for `cat` command
;Does not take stdin
;Any argument that's not a file we can read is silently skipped.
;When called on a list of valid files, should behave identical to regular cat

%use smartalign

bits 64

section	.text
		global _start			;must be declared for linker (ld)

_start:					;tell linker entry point
  mov rax,[rsp]
  cmp rax,1
  jle _exit
  add rsp,8
  
  align 32
_mainloop:
  add rsp,8
  mov rdi,[rsp]
  cmp rdi,0
  je _exit
  
  ;open
  mov rax,2
  ;pathname already in rdi
  xor esi,esi ;no special flags
  syscall
  mov ebx,eax ;store in nonvolatile register
  
  align 32
_readloop:
  ;read
	mov edi,ebx
  xor rax,rax
	mov rsi,buffer
	mov rdx,1024 ;null pointer in rdx
	syscall
  
  cmp ax,0
  jle _mainloop
  
  ;write
  movzx rdx,ax
  mov rax,1
  mov rdi,1
  mov rsi,buffer
  syscall
  
  jmp  _readloop
  
align 16
_exit:
	xor di,di
	mov	rax,60
	syscall

section	.bss
alignb 1024
buffer: resb 1024
