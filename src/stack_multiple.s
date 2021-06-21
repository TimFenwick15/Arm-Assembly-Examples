.global main
main:
    MOV R4, #4
    MOV R5, #5

    STMDB SP!, {R4, R5} @ Store multiple values on stack, decrement SP each time
    LDMIA SP!, {R4, R5} @ Load two values from stack to R4/5, increment SP each time
    MOV R0, R4        @ Should be 1

end:
    MOV R7, #1
    SWI 0

