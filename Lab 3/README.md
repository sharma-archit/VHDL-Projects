# Lab 3

The goal of Lab 3 is to design a simple CPU that can correctly run two programs:
1. Get user input and check if it is zero. If ‘yes’ just output the 0. If ‘no’ the 
CPU shifts the input number left by 2 bits and then outputs the result. Next, executing instruction LDI 
loads an immediate operand into the accumulator and then shifts it to right by 1 bit. Finally, the CPU 
outputs the right-shifted value. The program then halts.
2. Perform a simple addition of two numbers. The first number is obtained from the user and is 
stored in the accumulator. Next, it is stored in a register. Then the second number is received 
as an immediate operand and loaded into the accumulator. The ADD instruction is used to add the two 
numbers and the sum is stored back into the accumulator. The CPU outputs the result and then the CPU 
enters the halted state.
