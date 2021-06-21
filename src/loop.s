@ Seems to be a hack for getting data out quickly. Usage: ./exit_status ; echo $?
.global main
main:
    mov R0, #0
    mov R1, #1
    B _continue_loop

_loop:
    ADD R0, R0, R1

_continue_loop:     @ B to here. Once _loop completes, flow continues here
    CMP R0, #9
    BLE _loop       @ If CMP showed R0 <= 9, go back to _loop

end:                @ Once R0 > #9, don't go to _loop, so flow continues here
    mov R7, #1      @ output to console. After program runs, echo $? to get result
    SWI 0

