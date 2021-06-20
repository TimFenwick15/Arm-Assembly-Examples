.data
    USAGE: .asciz "Enter a number: "
    OUTSTR: .asciz "Res %d\n"
    INSTR: .asciz "%d"
    INPUT: .word
.text
.global main
.extern printf
.extern scanf
main:
    PUSH {LR}

    @ Print instructions
    ldr R0, =USAGE
    bl printf

    @ Parse user input
    ldr r0, =INSTR
    ldr r1, =INPUT
    bl scanf

    @ Print the result
    ldr r0, =OUTSTR
    ldr r1, =INPUT  @ I think this puts the address of INPUT into r1
    ldr r1, [r1]    @ Load the [value] of r1 into r1
    add r1,#1       @ Full form is dst,arg1,arg2. Arg1 can be dropped when it's the dst
    bl printf

    POP {PC}

