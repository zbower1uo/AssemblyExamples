.pos 0x100

main:	irmovl bottom,  %esp     # initialize stack
	irmovl a,       %edi     # address of the first element of a
	irmovl alen,    %esi	  
	mrmovl (%esi),  %esi     # number of elements of a
	irmovl $0x1,    %eax
	subl   %eax,    %esi     # last index in a
					 # ready to call findmax: a --> edi, last --> esi
	call findmax
	halt


.pos 0x200

#
# Find position of the maximum element in an array.
#
findmax:
		pushl %ebp			# push the base stack pointer onto the stack
		rrmovl %esp, %ebp	# make the top pointer the bottom pointer
		pushl %edi 		#
		pushl %esi 		# Push registers values onto stack to
		pushl %ebx 		# be preserved.
		
		# setup max
		irmovl $4, %eax
		mull %esi, %eax		# multiply n by 4
		addl %edi, %eax		# add a and n = a[n]
		rrmovl %eax, %ebx	# move the adress of a+n into ebx
		mrmovl (%ebx), %ebx	# dereference ebx to get the value at a+n (x = a[n])
		rrmovl %esi, %edx	# pos = n
while:	
		#while loop check
		xorl %eax, %eax
		subl %eax, %esi		# subtract 0 from n to set flag
		jl end				# jump to end if less than or equal to 
		
		#before if
		irmovl $1, %eax
		subl %eax, %esi		# decrement n
		irmovl $4, %eax
		mull %esi, %eax		# multiply n by 4
		addl %edi, %eax		# add a and n = a[n]
		mrmovl (%eax), %eax	# dereference eax to get the value at a+n (x = a[n])
		

		#if statement
		rrmovl %eax, %ecx	# move max into eax
		subl %ebx, %eax		# eax = max -x
		cmovg %ecx, %ebx 	# max = x
		cmovg %esi, %edx	# pos = n

		jmp while
 
end:		
		rrmovl %edx, %eax	# move pos to result register
		popl %ebx
		popl %esi
		popl %edi
		popl %ebp
		ret	
#
# Array to sort
#
.pos 0x1000
a:	.long 30
      .long 9
      .long 21
      .long 13
      .long 6
	.long 26
	.long 35
	.long 32
	.long 15
	.long 17
alen:	.long 10

	#
# Stack (256 thirty-two bit words is more than enough here).
#
.pos 0x3000
top:	            .long 0x00000000, 0x100    # top of stack.
bottom:           .long 0x00000000          # bottom of stack.

