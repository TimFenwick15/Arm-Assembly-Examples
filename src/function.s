@ R0, R1, R2, and R3 can be used as arguments to a function.
@ R0 is always the result.
@ If you need more arguments, you'll need a stack.
@ You'll need to restore the registers before returning.

@ To restore the stack at the end of a function:
@ STMFD SP!, {R4-R12} @ Place R4-R12 on the stack
@ LDMFD SP!, {R4-R12} @ Pull values from stack into R4-R12

.data
.balign 4
print: .asciz "Number is %d\n"

.balign 4
scan: .asciz "%d"

.balign 4
scan_data: .word 0

.balign 4
link_register_store: .word 0

.balign 4
link_register_store_2: .word 0       @ We need two because reusing the first stops start restoring LR

.text
.global main

main:
    B start

print_function:
    LDR R2, addr_link_register_store_2
    STR LR, [R2]

    LDR R0, addr_print
    LDR R1, addr_scan_data
    LDR R1, [R1]
    BL printf                        @ Branch with link, so return here when done

    LDR LR, addr_link_register_store_2
    LDR LR, [LR]
    BX LR

start:
    LDR R1, addr_link_register_store
    STR LR, [R1]                     @ 1/2 Store link register


    BL print_function

    LDR R0, addr_scan
    LDR R1, addr_scan_data
    BL scanf

    BL print_function

    LDR LR, addr_link_register_store @ 2/2 restore LR
    LDR LR, [LR]
    BX LR                            @ Branch and don't return here

addr_print: .word print
addr_scan: .word scan
addr_scan_data: .word scan_data
addr_link_register_store: .word link_register_store
addr_link_register_store_2: .word link_register_store_2

.global printf
.global scanf

