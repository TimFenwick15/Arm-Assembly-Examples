@ The minimum code for a hello world
.data
    STRING: .asciz "Hi\n"
.text
.global main
.extern printf
main:
    PUSH {LR}
    ldr R0, =STRING
    bl printf
    POP {PC}

