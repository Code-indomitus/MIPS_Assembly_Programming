#   Auuthor: Shyam Kamalesh Borkar
#   Date: 11.08.2022
#   This file contains of mips code of a function
#   named print_combiniation and combination_aux.
#   Function print_combination calls combination_aux
#   by passing its local variable as one of the 
#   arguments. The combination_aux function
#   prints out all the possible combinations of r
#   numbers using the elements in the arr list.


    .data
    
space:       .asciiz " "
new_line:    .asciiz "\n"

    .text

            .globl print_combination
            .globl combination_aux
    
            jal main
            # End the program.
            addi $v0, $0, 10
            syscall

print_combination:

            # space for $ra and $fp on stack.
            addi $sp, $sp, -8
            # save $ra onto stack.
            sw $ra, 4($sp)
            # save $fp onto stack.
            sw $fp, 0($sp)
            # copy $sp into $fp.
            addi $fp, $sp, 0

            # allocate space for one local variable - data
            addi $sp, $sp, -4

            #  print_combination(arr, n, r)
            #  arg arr at 8($fp)
            #  arg n at 12($fp)
            #  arg r at 16($fp)
            #  local data at -4($fp)

            # allocate space for data using r
            lw $t0, 16($fp) # load r
            addi $t0, $t0, 1 # extra size for first element which is the size of data
            sll $t0, $t0, 2 # multiply by 4
            addi $a0, $t0, 0
            addi $v0, $0, 9
            syscall

            sw $v0, -4($fp) # save address of data to stack
            lw $t0, 16($fp) # load r from stack
            lw $t1, -4($fp) # load address of data
            sw $t0, ($t1) # store length r of data

            # store temporary counter onto stack
            addi $sp, $sp, -4
            sw $0, ($sp) # initialise counter to zero

for_initialize:
            lw $t0, ($sp) # load temp counter
            lw $t1, 16($fp)# load r from stack
            slt $t0, $t0, $t1 # temp counter < r ?
            beq $t0, $0, end_for_initialize

            lw $t0, ($sp) # load temp counter
            addi $t0, $t0, 1 # increment by 1
            sll $t0, $t0, 4 # multiply by 4

            lw $t1, -4($fp) # load address of data
            add $t0, $t0, $t1  # add offset
            sw $0, ($t0)

            lw $t0, ($sp) # load temp counter
            addi $t0, $t0 1 # increment counter in for loop
            sw $t0, ($sp) # save it

            j for_initialize

end_for_initialize:
            #deallocate temp counter from stack
            addi $sp, $sp, 4

            # allocate space for 6 arguments
            addi $sp, $sp, -24

            lw $t0, 8($fp) #argument arr
            sw $t0, 0($sp)

            lw $t0, 12($fp) #argument n
            sw $t0, 4($sp)

            lw $t0, 16($fp) #argument r
            sw $t0,8($sp)

            sw $0, 12($sp) #argument index

            lw $t0, -4($fp) #argument data (address)
            sw $t0, 16($sp)

            sw $0, 20($sp) #argument i

            jal combination_aux 

            addi $sp, $sp, 24 # clear arguments off the stack
            addi $sp, $sp, 4 # clear local variables off the stack
            lw $fp, 0($sp) # restore $fp
            lw $ra, 4($sp) # restore $ra
            addi $sp, $sp, 8 # clear $fp and $ra off the stack
            jr $ra

combination_aux:
            # space for $ra and $fp on stack.
            addi $sp, $sp, -8
            # save $ra onto stack.
            sw $ra, 4($sp)
            # save $fp onto stack.
            sw $fp, 0($sp)
            # copy $sp into $fp.
            addi $fp, $sp, 0

            # allocate space for 1 local (j)
            addi $sp, $sp, -4
            sw $0, 0($sp) # initialise j to 0

            #  combination_aux(arr, n, r, index, data, i)
            #  arg arr at 8($fp)
            #  arg n at 12($fp)
            #  arg r at 16($fp)
            #  arg index at 20($fp)
            #  arg data at 24($fp)
            #  arg i at 28($fp)
            #  local j at -4($fp)

if1:
            lw $t0, 20($fp) # load index into $t0
            lw $t1, 16($fp) # load r into $t1
            bne $t0, $t1, if2

for:
            lw $t0, -4($fp) # load j from stack
            lw $t1, 16($fp) # load r from stack
            slt $t0, $t0, $t1 # j < r?
            beq $t0, $0, end_for

            # print(data[j], end=" ")

            lw $t0, -4($fp)# load j from stack
            addi $t0, $t0, 1 # add 1 to consider first element being size.
            sll $t0, $t0, 2 # multiply by 4
            lw $t1, 24($fp) # load address of data
            add $t1, $t0, $t1 # address of data[j]
            lw $t0, ($t1) # data[j]

            addi $v0, $0, 1
            addi $a0, $t0, 0 # print(data[j])
            syscall

            addi $v0, $0, 4
            la $a0, space # printn(" ")
            syscall

            # increment counter j
            lw $t0, -4($fp) # load j from stack
            addi $t0, $t0, 1 # increment by 1
            sw $t0, -4($fp) # save new j onto stack 

            j for

end_for:
            addi $v0, $0, 4
            la $a0, new_line # print() -> new line
            syscall

            # return
            addi $sp, $sp, 4 # clear local variables off the stack
            lw $fp, 0($sp) # restore $fp
            lw $ra, 4($sp) # restore $ra
            addi $sp, $sp, 8 # clear $fp and $ra off the stack
            jr $ra

if2:
            lw $t0, 28($fp) # load i into $t0
            lw $t1, 12($fp) # load n into $t1
            slt $t0, $t0, $t1 # i < n?
            bne $t0, $0 end_if2

            # return 
            addi $sp, $sp, 4 # clear local variables off the stack
            lw $fp, 0($sp) # restore $fp
            lw $ra, 4($sp) # restore $ra
            addi $sp, $sp, 8 # clear $fp and $ra off the stack
            jr $ra

end_if2:

            # data[index] = arr[i]
            lw $t0, 20($fp)# load index from stack
            addi $t0, $t0, 1 # add 1 to consider first element being size.
            sll $t0, $t0, 2 # multiply by 4
            lw $t1, 24($fp) # load address of data
            add $t0, $t0, $t1 # address of data[index] in $t0

            lw $t1, 28($fp)# load i from stack
            addi $t1, $t1, 1 # add 1 to consider first element being size.
            sll $t1, $t1, 2 # multiply by 4
            lw $t2, 8($fp) # load address of arr
            add $t2, $t1, $t2 # address of arr[i] in $t1
            lw $t1, ($t2) # arr[i]

            # save contents of arr[i] into data[index]
            sw $t1, ($t0)

            # combination_aux(arr, n, r, index + 1, data, i + 1)
            # allocate space for 6 arguments
            addi $sp, $sp, -24

            lw $t0, 8($fp) #argument arr
            sw $t0, 0($sp)

            lw $t0, 12($fp) #argument n
            sw $t0, 4($sp)

            lw $t0, 16($fp) #argument r
            sw $t0, 8($sp)

            lw $t0, 20($fp) #argument index -> index + 1
            addi $t0, $t0, 1
            sw $t0, 12($sp) 

            lw $t0, 24($fp) #argument data (address)
            sw $t0, 16($sp)

            lw $t0, 28($fp)
            addi $t0, $t0, 1
            sw $t0, 20($sp) #argument i -> i + 1

            jal combination_aux 

            addi $sp, $sp, 24 # deallocate arguments off the stack


            # combination_aux(arr, n, r, index, data, i + 1)
            # allocate space for 6 arguments
            addi $sp, $sp, -24

            lw $t0, 8($fp) #argument arr
            sw $t0, 0($sp)

            lw $t0, 12($fp) #argument n
            sw $t0, 4($sp)

            lw $t0, 16($fp) #argument r
            sw $t0, 8($sp)

            lw $t0, 20($fp) #argument index
            sw $t0, 12($sp) 

            lw $t0, 24($fp) #argument data (address)
            sw $t0, 16($sp)

            lw $t0, 28($fp)
            addi $t0, $t0, 1
            sw $t0, 20($sp) #argument i -> i + 1
                                
            jal combination_aux 

            addi $sp, $sp, 24 # clear arguments off the stack
            addi $sp, $sp, 4 # clear local variable 
            lw $fp, 0($sp) # restore $fp
            lw $ra, 4($sp) # restore $ra
            addi $sp, $sp, 8 # clear $fp and $ra off the stack
            jr $ra

main:
            # space for $ra and $fp on stack.
            addi $sp, $sp, -8
            # save $ra onto stack.
            sw $ra, 4($sp)
            # save $fp onto stack.
            sw $fp, 0($sp)
            # copy $sp into $fp.
            addi $fp, $sp, 0
            # allocate space for 3 local variables.
            addi $sp, $sp, -12

            #  main()
            #  local arr at -4($fp)
            #  local r at -8($fp)
            #  local n at -12($fp)

            # allocate space for arr.
            addi $v0, $0, 9
            addi $a0, $0, 24 # (5 + 1) * 4 bytes must be reserved.
            syscall
            addi $t0, $v0, 0 # copy address of arr to $t0
            # push address of array arr to stack
            sw $t0, -4($fp)

            lw $t0, -4($fp) # load address of array
            addi $t1, $0, 5 # Assign start of array to size of array.
            sw $t1, ($t0) # total length of array = 5 + 1
            # Fill in the elements into the array
            lw $t0, -4($fp) # load address of array
            addi $t1, $0, 1
            sw $t1, 4($t0) # arr[0] = 1
            addi $t1, $0, 2
            sw $t1, 8($t0) # arr[1] = 2
            addi $t1, $0, 3
            sw $t1, 12($t0) # arr[2] = 3
            addi $t1, $0, 4
            sw $t1, 16($t0) # arr[3] = 4
            addi $t1, $0, 5
            sw $t1, 20($t0) # arr[4] = 5

            # push r onto the stack
            addi $t0, $0, 3
            sw $t0, -8($fp)

            # push n = len(arr) onto the stack
            lw $t0, -4($fp) # load address of array arr
            lw $t0, ($t0) # Load length of array arr
            sw $t0, -12($fp) # n = len(arr)

            # push the 3 arguments of print_combination
            # allocate space for 3 arguments
            addi $sp, $sp, -12
            lw $t0,-4 ($fp) # load local arr
            sw $t0, 0($sp) # store argument arr

            lw $t0, -8($fp) # load local r
            sw $t0, 8($sp) # store argument r

            lw $t0, -12($fp) # load local n
            sw $t0, 4($sp) # store argument n

            jal print_combination

            addi $sp, $sp, 12 # clear 3 arguments off the stack
            addi $sp, $sp, 12 # clear 3 local variables off the stack
            lw $fp, 0($sp) # restore $fp
            lw $ra, 4($sp) # restore $ra
            addi $sp, $sp, 8 # clear $fp and $ra off the stack
            jr $ra



