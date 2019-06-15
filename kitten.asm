;Kitten: stupidly overoptimized replacement for `cat` command
;Does not take stdin
;Any argument that's not a file we can read is silently skipped.
;When called on a list of valid files, should behave identical to regular cat

bits 64

section	.text
		global _start			;must be declared for linker (ld)

_start:					;tell linker entry point
  mov rax,[rsp]
  cmp eax,1
  jle _exit
  add rsp,8
  jmp _mainloop
  
  align 32
_mainloop:
  add rsp,8
  mov rdi,[rsp]
  test rdi,rdi
  je _exit
  
  ;open
  mov rax,2
  ;pathname already in rdi
  xor rsi,rsi ;no special flags
  syscall
  mov rbx,rax ;store in nonvolatile register
  mov r9,0x00aaaaaa00; basically a long nop since we don't use this register
  
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
  
align 32
_exit:
	xor di,di
	mov	rax,60
	syscall

section	.bss
alignb 1024
buffer: resb 1024
