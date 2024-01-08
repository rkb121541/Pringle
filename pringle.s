.global pringle

pringle:
    // ex: pringle(str -> X0, arr1 -> X1, 3 -> X2, arr2 -> X3, 1 -> X4, arr3 -> X5, 5 -> X6)

    // making space on the stack to put callee saved registers
    SUB   SP, SP, 160
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

    // stores the first 8 parameters
    STR   X0, [SP, 96]
    STR   X1, [SP, 104]
    STR   X2, [SP, 112]
    STR   X3, [SP, 120]
    STR   X4, [SP, 128]
    STR   X5, [SP, 136]
    STR   X6, [SP, 144]
    STR   X7, [SP, 152]
    
    MOV   X26, 0        // index of concat_array's return string
    MOV   X27, 0        // index of str (1st parameter)
    MOV   X28, 0        // index of destination str
    ADR   X29, str
    MOV   X22, 0        // counter for which %a im on
    LDR   X20, [SP, 96] // X20 -> str (1st parameter)

loop:
    LDRB  W23, [X20, X27]
    STRB  W23, [X29, X28]
    CMP   W23, WZR
    B.EQ  terminator
    MOV   X24, 37   
    CMP   X23, X24  // checks if percent
    B.EQ  alpha
    ADD   X27, X27, 1
    ADD   X28, X28, 1
    B     loop

alpha:
    ADD   X27, X27, 1
    ADD   X28, X28, 1
    LDRB  W23, [X20, X27]
    STRB  W23, [X29, X28]
    MOV   X24, 97   
    CMP   X23, X24  // checks if alpha
    B.NE  L1
L4: ADD   X22, X22, 1
    SUB   X25, X22, 1
    MOV   X21, 16
    MUL   X25, X25, X21
    ADD   X25, X25, 104
    LDR   X0, [SP, X25]
    ADD   X25, X25, 8
    LDR   X1, [SP, X25]
    B     bandl

L1: MOV   X24, 37   
    CMP   X23, X24  // checks if percent
    B.EQ  alpha
    CMP   W23, WZR  // checks if zero
    B.EQ  terminator
    ADD   X27, X27, 1
    ADD   X28, X28, 1
    B     loop

bandl:
    BL    concat_array
    MOV   X24, 0
    SUB   X28, X28, 1

L3: LDRB  W23, [X0, X24]
    CMP   W23, WZR
    B.EQ  L2
    STRB  W23, [X29, X28]
    ADD   X24, X24, 1
    ADD   X28, X28, 1
    B     L3

L2: ADD   X27, X27, 1
    B     loop    

terminator:
    ADD   X28, X28, 1

    MOV   X0, 1
    MOV   X1, X29
    MOV   X2, X28
    MOV   X8, 64
    SVC   0

    MOV   X0, X28

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
    
    LDR   X0, [SP, 96]
    LDR   X1, [SP, 104]
    LDR   X2, [SP, 112]
    LDR   X3, [SP, 120]
    LDR   X4, [SP, 128]
    LDR   X5, [SP, 136]
    LDR   X6, [SP, 144]
    LDR   X7, [SP, 152]
    ADD   SP, SP, 160

    RET

/*
    Declare .data here if you need.
*/
.data
    str:  .fill 1024, 1, 0
