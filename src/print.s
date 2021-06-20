@ Variables go in the data section
.data
.balign 4       
    string: .asciz "\n%d %d %d %d\n" @ asciz means ascii, with a zero byte at the end

@ Code goes in the text section
.text
.global main
.extern printf

main:
    push    {ip, lr}        @ push return address + dummy register for alignment
    ldr     r0, =string     @ get address of string into r0
    mov     r1, #11
    mov     r2, #22
    mov     r3, #33
    mov     r4, #444        @ This is beyond the end of printf, so doesn't work
    bl      printf          @ print string from r0 and pass params into r1, r2, and r3
    pop     {ip, pc}        @ pop return address into pc

