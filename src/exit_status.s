@ Seems to be a hack for getting data out quickly. Usage: ./exit_status ; echo $?
.global main
main:
    mov R1, #5
    mov R2, #9
    and R0, R1, R2

    mov R7, #1 @ output to console. After program runs, echo $? to get result
    SWI 0

