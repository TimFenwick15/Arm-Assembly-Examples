.global main
main:
    LDR R3, =numbers
    LDR R0, [R3, #2]

end:
    MOV R7, #1
    SWI 0

.data
numbers:
    .byte 1, 2, 3, 4, 5

