###############################################################
# Kernel data and code
###############################################################
  .kdata
save0: .word 0
save1: .word 0
input_index:  .word 0
input_buffer: .space BIG # We don't care to handle the
                         # input buffer overflow in
                         # this exercice

  .ktext # This is the entry point of the kernel
         # we suppose that the interrupts are masked
         # at the beginning
init:
  # No other program exists here because we are at
  # the beginning of the kernel and because the interrupts
  # are masked, we cannot be interrupted (and execute the it_handler
  # code). Therefore, we don't have to worry about saving registers
  lw $k0, 0xffff0000 # Load the receiver control and status register
  ori $k0, $k0, 2    # Enable interrupts generation in device
  sw $k0, 0xffff0000

  mfc0 $k0, $12      # Load the processor status register
  ori $k0, $k0, 15   # Unmask the interrupt and all exceptions
  mtc0 $k0, $12

  # In a real kernel, after initialization, we would
  # start a process to launch a shell


  .ktext 0x80000180 # The handler address for MIPS32
it_handler:
  sw   $at, save0   # The register $at is used in pseudo-instructions.
                    # Because we use pseudo-instructions and the interrupted
                    # code can use them also, we have to save it

  mfc0 $k0, $13     # Get the value in cause register
  andi $k1, $k0, 3  # Mask all but the exception code to zero
  # The exception code is zero for an interrupt
  bne $k1, 0, panic    # If it is an exception we go to panic
                       # because we don't handle this case
                       # in this exercice

  lw $k0, 0xffff0004   # Get ASCII value of pressed key from the receiver data register
                       # and store content of the receiver data register in $k0

                       # NOTE that to simplify the exercice, we store the 32 bits
                       # register into the input buffer array even if we
                       # could have extracted the 8 lower bits

  lw $k1, input_index  # Get the value of the index
  sw $t0, save1        # We need to save $t0, because we need one more register
  la $t0, input_buffer # Get the address of the buffer
  sll $k1, $k1, 2      # Multiply by 4 because input_buffer is an int array
  add $t0, $t0, $k1    # Compute the address where to store the received character
  sw $k0, ($t0)        # Store the received character into the buffer

  srl $k1, $k1, 2      # Divide by 4 to get the original index value
                       # (multiplying by 4 and then dividing by 4 could give back a
                       # different value, we don't care in this exercice, but can
                       # you see why ?)
  addi $k1, $k1, 1     # Increment the index
  sw $k1, input_index  # Save it to memory
  lw $at, save0        # Restore the registers
  lw $t0, save1
  eret                 # Return from interrupt

# We go there for exceptions because we just handle the keyboard interrupt
# for this exercice
panic:
  j panic
