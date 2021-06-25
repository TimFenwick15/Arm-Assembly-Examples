.global main
.func main
main:
    @
    @ Load and print a number
    @
    LDR R1, addr_pi
    VLDR S0, [R1]       @ Load into a VFP register

    VCVT.F64.F32 D1, S0 @ convert from F64 to F32, load to D1. This is required for printf

    LDR R0, =output

    VMOV R2, R3, D1     @ Move bottom 32 bits into R2, top 32 bits into R3 (printf args)

    BL printf

    @
    @ Load two numbers and print their sum
    @
    LDR R1, addr_pi
    VLDR S0, [R1]
    LDR R2, addr_pi
    VLDR S1, [R2]

    VADD.f32 S2, S0, S1 @ Add two f32. Also have VSUB, VMUL, VDIV, VCMP

    VCVT.F64.F32 D1, S2

    LDR R0, =add_output

    VMOV R2, R3, D1

    BL printf

end:
    MOV R7, #1
    SWI 0

addr_pi: .word pi

.data
pi: .float 3.141592
output: .asciz "The value of Pi is %f\n"
add_output: .asciz "The value of two Pi is %f\n"

.global printf
