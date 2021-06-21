.data
list:
    .word 2
    .word 4
    .word 6

.text
.global main
main:
    LDR R0, list_addr
    LDR R0, [R0, #4]  @ Get list_addr + 4 byte offset

    @LDR R3, bytes_addr
    @LDR R0 [R3, #2]   @ LDRB = load bytes, this time a 2 byte offset, so 3

end:
    MOV R7, #1
    SWI 0

list_addr: .word list

