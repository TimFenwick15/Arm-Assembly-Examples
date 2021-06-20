.data
.balign 4       
    string: .asciz "\n%d %d %d %d\n"        
.text
.global main
.extern printf

main:
    push    {ip, lr}        @ push return address + dummy register
                            @ for alignment
    ldr     r0, =string     @ get address of string into r0
    mov     r1, #11
    mov     r2, #22
    mov     r3, #33
    mov     r4, #444
    bl      printf          @ print string and pass params
                            @ into r1, r2, and r3
    pop     {ip, pc}        @ pop return address into pc

