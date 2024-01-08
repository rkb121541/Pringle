.global count_specs

count_specs:
    // unsigned long int count_specs(char* str -> X0);

    // making space on the stack to put callee saved registers
    SUB   SP, SP, 96
    STR   X30, [SP]
    STR   X19, [SP, 8]
    STR   X20, [SP, 16]
    STR   X21, [SP, 24]
    STR   X22, [SP, 32]
    STR   X23, [SP, 40]
    STR   X24, [SP, 48]
    STR   X25, [SP, 56]
    STR   X26, [SP, 64]
    STR   X27, [SP, 72]
    STR   X28, [SP, 80]
    STR   X29, [SP, 88]

    MOV   X25, X0   // X0 -> input string
    MOV   X22, 0    // counter for # of %
    MOV   X24, 0    // index
    MOV   X27, 37   // ascii for %
    MOV   X21, 97   // ascii for a

loop:
    LDRB  W23, [X25, X24]
    CMP   W23, WZR
    B.EQ  exit
    
    CMP   X23, X27
    B.EQ  alpha
    ADD   X24, X24, 1
    B     loop

alpha:
    ADD   X24, X24, 1
    LDRB  W23, [X25, X24]
    CMP   X23, X21
    B.EQ  increment
    B     loop

increment:
    ADD   X22, X22, 1
    ADD   X24, X24, 1
    B     loop

exit:
    MOV   X0, X22

    // deletes the space on the stack after using the registers
    LDR   X30, [SP]
    LDR   X19, [SP, 8]
    LDR   X20, [SP, 16]
    LDR   X21, [SP, 24]
    LDR   X22, [SP, 32]
    LDR   X23, [SP, 40]
    LDR   X24, [SP, 48]
    LDR   X25, [SP, 56]
    LDR   X26, [SP, 64]
    LDR   X27, [SP, 72]
    LDR   X28, [SP, 80]
    LDR   X29, [SP, 88]
    ADD   SP, SP, 96

    RET

/*
    Declare .data here if you need.
*/
