.bss
buffer: .skip 30000

.text
format_str: .asciz "We should be executing the following code:\n%s"
format_character: .asciz "%c"

format_input: .asciz "%ld"

.global brainfuck


# Your brainfuck subroutine will receive one argument:
# a zero terminated string containing the code to execute.
brainfuck:
	pushq %rbp
	movq %rsp, %rbp

	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15

	movq %rdi, %r13 		# save the address of the string in r13
	#movq $0, %r14			# clear r14 as a space to hold the number of open square brackets at the same time

	# print the string to interpret
	movq %rdi, %rsi
	movq $format_str, %rdi
	movq $0, %rax
	call printf
	

	leaq buffer, %r12  	   # use r12 as a data pointer
	addq $15000, %r12

	
	loop:					# loop to iterate through all characters
		cmpb $0, (%r13)		# check to see if we reached the end of the string
		je end_function		# go to the end of the function

		cmpb $'<', (%r13)	# check to see if we have the open angular character
		je openAngularCase		# go to the specific case

		cmpb $'>', (%r13)	# check to see if we have the closed angular character
		je closedAngularCase		# go to the specific case

		cmpb $'+', (%r13)	# check to see if we have the plus character
		je plusCase		# go to the specific case

		cmpb $'-', (%r13)	# check to see if we have the minus character
		je minusCase		# go to the specific case

		cmpb $'.', (%r13)	# check to see if we have the point character
		je pointCase		# go to the specific case

		cmpb $',', (%r13)	# check to see if we have the comma character
		je commaCase		# go to the specific case

		cmpb $'[', (%r13) 	# check to see if we have the open square character
		je openSquareCase		# go to the specific case

		cmpb $']', (%r13)	# check to see if we have the closed square character
		je closedSquareCase		# go to the specific case

		incq %r13
		jmp loop

		closedAngularCase:
			incq %r12	# increment the data pointer by one
			incq %r13	# increment the character address by one
			jmp loop	# go to the next iteration
		
		openAngularCase:
			decq %r12 	# decrement the data pointer by one
			incq %r13	# increment the character address by one
			jmp loop 	# go to the next iteration

		plusCase:
			incb (%r12)	# increment the value stored at the data pointer by one
			incq %r13	# increment the character address by one
			jmp loop	# go to the next iteration

		minusCase:
			decb (%r12)	# decrement the value stored at the data pointer by one
			incq %r13	# increment the character address by one
			jmp loop	# go to the next iteration
		
		commaCase:
    		
    		movq $format_character, %rdi # first parameter: format of what we are going to read (character)
    		leaq (%r12), %rsi # second parameter: the address of where we are going to store the number (the data pointer)
    		call scanf 	# call scanf to read the number
			movq $0, %rax # no vector registers for scanf
			incq %r13	# increment the character address by one
			jmp loop	# go to the next iteration

		pointCase:
		     
			movq $format_character, %rdi # set the format of a char as the first parameter of the print function
			movq $0, %rsi	# clear rsi
			movb (%r12), %sil # set the character as the second parameter of the print function
			movq $0, %rax # no vector registers for printf
			call printf
			incq %r13	# increment the character address by one
			jmp loop	# go to the next iteration

		# r12 = data pointer (buffer)
		# r13 = address of string to interpret
		# r14 = counter_buffer0
		
		openSquareCase:

		cmpb $0, (%r12)
		jne openSquareWithBufferNot0

		# openSquareWithBuffer0:
			movq $1, %r14		# increase the counter of square brackets
			incq %r13			# move to the next byte in the string

			loopOpenSquareWithBuffer0:
				cmpq $0, %r14
				jle end_loopOpenSquareWithBuffer0

				#counterGreaterThan0:
					cmpb $'[', (%r13)
					je incrementCounter

					cmpb $']', (%r13)
					je decrementCounter

					# randomCharacter
					incq %r13
					jmp loopOpenSquareWithBuffer0

					incrementCounter:
						incq %r14
						incq %r13
						jmp loopOpenSquareWithBuffer0

					decrementCounter:
						decq %r14
						incq %r13
						jmp loopOpenSquareWithBuffer0
					
			
			end_loopOpenSquareWithBuffer0:
				#incq %r13
				jmp end_openSquareCase


		openSquareWithBufferNot0:
			incq %r13
			pushq %r13
			pushq %r13


		end_openSquareCase:
			jmp loop


		# open square with buffer 0

			# initialize counter_buffer0 with 1
			# increment r12

			# iff counter > 0
				# for character '[': 		increment counter_buffer0
				# for character ']':		decrement counter_buffer0
			# increment r12

		# open square with buffer !0

			# increment r12
			# save address of the first character in the loop on the stack

		
		# jmp loop


		closedSquareCase:

		cmpb $0, (%r12)
		jne closedSquareWithBufferNot0

			closedSquareWithBuffer0:
				popq %r15
				popq %r15
				movq $0, %r15
				incq %r13
				jmp end_closedSquareCase

			closedSquareWithBufferNot0:
				popq %r13
				popq %r13
				pushq %r13
				pushq %r13
		
		end_closedSquareCase:
			jmp loop


			# iff buffer != 0
				# pop into r12
				# pop into r12
			
			# elsee (iff buffer == 0)
				# increment r12
			
			#jmp loop


	end_function:

		popq %r15
		popq %r14
		popq %r13
		popq %r12		

		movq %rbp, %rsp
		popq %rbp
		ret
		