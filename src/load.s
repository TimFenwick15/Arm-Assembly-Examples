.data

.balign 4                   @ Assign 4 bytes for this variable
fifteen:
    .word 0                 @ We'll asign the value later

.balign 4
thirty:
    .word 0

.text
.global main
main:
    LDR R1, addr_fifteen    @ Point R1 to fifteen
    MOV R3, #15
    STR R3, [R1]            @ Store R3 in the value of R1
    LDR R1, [R1]            @ I think this is like dereferencing a pointer

    LDR R2, addr_thirty
    MOV R3, #30
    STR R3, [R2]
    LDR R2, [R2]

    ADD R0, R1, R2

end:
    mov R7, #1
    SWI 0

addr_fifteen: .word fifteen @ label for the address of the variables
addr_thirty: .word thirty

