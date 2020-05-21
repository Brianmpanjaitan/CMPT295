	.globl sqrt
sqrt:
	movl $0, %eax   	# result
	movl $0, %r9d		# counter
	movl $0, %esi		# temp variable	
	movl $32768, %ecx	# bitmask, 2^k, k = 15
	
loop:
	cmpl %r9d, %ecx		# bitmask - 0 ? 0
	jle endloop		# jump if bitmask - 0 <= 0
	jmp innerloop

innerloop:
	xorl %ecx, %eax		# change kth bit of result to 1
	movl %eax, %esi		# temp = result
	imull %esi, %esi	# temp = result*result

	cmpl %edi, %esi		# temp - x ? 0
	jg backtozero		# jump if temp - x > 0
	shr $1, %ecx		# shift bitmask to the right by 1
	jmp loop

backtozero:
 	xorl %ecx, %eax		# change kth bit of result to 0
	shr $1, %ecx		# shift bitmask to the right by 1
	jmp loop		

endloop:
	ret
