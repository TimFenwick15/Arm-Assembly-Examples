## Building Arm binaries on x86
Followed this for a simple Arm program. More information on Qemu too. https://gist.github.com/luk6xff/9f8d2520530a823944355e59343eadc1

An Arm binary can be run directly in my environment: $ ./hello

## ELF
$ readelf -h bin/hello # show the ELF headers for this binary

$ readelf --segments bin/hello # show the segments in the binary. The data segment will be RW (read write), the code segment will be R E (read executable)

$ readelf --sections bin/hello # show the sections in the binary. These are used at link time, so removing them with sstrip won't break the binary

Segment - run-time, where code can be found in memory
Section - link time, divides data .data, and code .text

## Links
Write to console using printf in Arm assembly: https://stackoverflow.com/questions/40442133/how-to-use-printf-in-raspberry-pi-assembly-language

Write to console using syscall write. Not sure how this one works, svc #0? https://stackoverflow.com/questions/17357467/how-to-print-a-number-in-arm-assembly

GBA homebrew is a project that could be done in Arm assembly: https://www.gbadev.org/index.php

Manchester Uni slides: http://apt.cs.manchester.ac.uk/ftp/pub/apt/peve/PEVE05/Slides/02_ARMassembly.pdf

Azeria: https://azeria-labs.com/writing-arm-assembly-part-1/

Youtube tutorial: https://www.youtube.com/watch?v=ViNnfoE56V8

Shows simple starting point of a makefile: https://www.cs.colby.edu/maxwell/courses/tutorials/maketutor/

## Operations
`operation, operand1, operand 2, ...`

Where operand 1 is the destination (similar to x86, others can be different).

In Arm, the result can be a different register to the other operands.

All operands 32-bit

MLA = multiply acumulate.

`MLA R0, R1, R2, R3` means R0 := R1 * R2 + R3

ADC = add, then add the carry bit if set

## Branching
b = branch

Branches can depend on condition flags stored in the Program Status Register.

bne = branch if not equal

## Syntax
.something = directive, comands to the assembler, do not map to machine code

instructions are a mnemonic followed by operands

label: = label or function

## Data
| Symbol | Meaning                                                        |
|--------|----------------------------------------------------------------|
| #      | Literal, imediate value. Numbers in form 0-255 * <sup>2n</sup> |
| &      | Value in hex, eg #&FF                                          |
| 0x...  | Value in hex, eg #0xFF                                         |

## Conditions
Condition code is set by comparison operators, and can be optionally set by other instructions, eg
`ADDS r2, r2, r0 @ 32-bit overflow -> C`
Where the S in ADDS means set the condition code

## Load and Store Examples
Load and store:
```
LDR r0, [r1] ; r0 := mem[r1]
STR r0, [r1] ; mem[r1] := r0
```
Initialising an address pointer:
```
ADR r1, TABLE1 ; r1 points to TABLE1
..
TABLE1 ; LABEL
```

Simple load: `LDR r0, [r1] ; r0 := mem[r1]`
Load to reg + offset: `LDR r0, [r1,#4] ; r0 := mem[r1+4]`
As before, but move R1 by the offset too: `LDR r0, [r1,#4]!`

Branch to LABEL and continue from there:
```
b LABEL
LABEL ...
```

LDRH = load unsigned half-word.

| Name | Data type          | Size /bytes |
|------|--------------------|-------------|
|      | word               | 4           |
| H    | unsigned half-word | 2           |
| SH   | signed half-word   | 2           |
| B    | unsigned byte      | 1           |
| SB   | signed byte        | 1           |


## Branch
Branch is result of cmp is not equal:
```
LOOP
    ...
    CMP r0, #10
    BNE LOOP
```

Branch and link, when branch is complete, flow returns there:
```
    BL SUBR
    .. ; return to here
SUBR ..
    MOV pc, r14 @ R14 is link register, holding the return address, which we move the program counter to
```

All instructions can be conditional, eg ADD could be ADDNE (not equal)

swi is a supervisor call, calling a function from the operating system

## Current Program Status Register (CPSR)

Current Program Status Register (CPSR) holds flags. It's 31 bits wide, and occurs after the 16 registers.

| Bit | Name | Meaning                                                     |
|-----|------|-------------------------------------------------------------|
| 31  | N    | Set on negative result                                      |
| 30  | Z    | Set on zero result                                          |
| 29  | C    | Set if a carry occurs (result greater than 2<sup>32</sup>)  |
| 28  | V    | Set if overflow occurs (result greater than 2<sup>31</sup>) |

CPSR can be read like a register in the assembly code.

So if you say `cmp R1, R2`, this can be thought of as R1 - R2.

If R1 < R2, result is negative and `N` is set.

If R2 > R1, result is positive and `N` and `Z` are not set.

If R1 == R2, result is 0 and `Z` is set.

Rather than checking this manually, you'd add a condition onto the next instruction.

Eg, BEQ is branch if equal. BGT is branch if greater than.

## Float
Stored in VFP registers:
- S0 to S31 for float
- D0 to D15 for double (in the same memory space, to D0 is S0 + S1)

S0 - S15 (D0 - D7) are scalar mode, meaning you work on them in their locations only.

The rest are vector mode which means if they wrap, they can use additional space.

## mov vs ldr
Essentially do the same thing. mov can be faster, but operands must meet space requirements. The assembler may change your ldr for a mov.

https://stackoverflow.com/questions/14046686/why-use-ldr-over-mov-or-vice-versa-in-arm-assembly

Seems like load is for addresses, mov is for values?

## Git commit empty folders
Put a .gitignore in the directory. In this case, it's a bin directory where we want to ignore the files too: https://stackoverflow.com/questions/5711120/gitignore-binary-files-that-have-no-extension/25592735#25592735

## Make
Rule lines need to be tab indented.

