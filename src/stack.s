.global main
main:
    MOV R1, #1
    MOV R2, #2

    STR R1, [SP, #-4]! @ Store R1 at stack pointer, move SP in 4 bytes, then update SP (!)
    STR R2, [SP, #-4]!

    LDR R0, [SP], #+4  @ Read value at SP, then move SP out 4 bytes
    LDR R0, [SP], #+4

end:
    MOV R7, #1
    SWI 0

