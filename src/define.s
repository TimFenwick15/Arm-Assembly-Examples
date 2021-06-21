.global main
main:
    MOV R0, #two  @ Using our defined constant

end:
    MOV R7, #1
    SWI 0

.data
.equ two, 2       @ Like a hash define for making constants

