	.globl times
times:
	mov $0, %ecx
	mov $0, %eax
loop:
	cmpl %ecx, %esi
	jle endloop
	addl %edi, %eax
	incl %ecx
	jmp loop
endloop:
	ret

