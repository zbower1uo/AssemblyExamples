.pos 0x100
	irmovl bottom, %esp # initialize stack pointer
	irmovl $a, %eax		# move address of a into register
	call (%eax)			# call a
	irmovl $0, %edx 	# do something to see if we've returned successfully
	halt

.pos 0x200
a:	irmovl $b, %ebx		# get another function for a nested call
	call (%ebx)			# call b
	irmovl $1, %edx		# do something to see if we've returned successfully
	ret

.pos 0x300
b:	irmovl $c, %ecx		# get another function for another nested call
	call (%ecx)			# call c
	irmovl $2, %edx		# do something to see if we've returned successfully	
	ret

.pos 0x400
c:	irmovl $3, %edx		# do something
	ret

# Stack 
.pos 0x1000
top:	    .long 0x00000000, 0x10      # top of stack.
bottom:     .long 0x00000000            # bottom of stack.
