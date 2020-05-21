.globl conv
conv:
	movb $0, %al		# return value = 0

	movl $0, %r8d		# m = 0
	movl $0, %r9d		# value at m = 0

	movl %edx, %ecx		# n
	subl $1, %ecx		# n - 1
	movl $0, %r11d		# counter

	addl %ecx, %esi

condition:
	cmpl %r11d, %edx	# n-counter ? 0
	jle	endloop			# n-counter <= 0
	incl %r11d			# counter++

	movl (%edi), %r10d
	imull (%esi), %r10d
	addb %r10b, %al

	addl $1, %edi		# m++
	subl $1, %esi 		# n-m-1

	jmp condition

endloop:
	ret
