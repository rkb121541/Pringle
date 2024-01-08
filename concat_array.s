.global concat_array

concat_array:
   // char* concat_array(unsigned long int* arr -> X0, unsigned long int len -> X1);

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

   ADR   X27, concat_array_outstr
   MOV   X19, 0

zeroout:
   CMP   X19, 1016
   B.EQ  begin
   STR   XZR, [X27, X19]
   ADD   X19, X19, 8
   B     zeroout

begin:    
   MOV   X20, X0  // X0 -> array
   MOV   X21, X1  // X1 -> length of array
   MOV   X22, 0   // index
   MOV   W23, 32  // ascii for a space
   MOV   X24, 0   // counter for string that itoascii returns
   MOV   X25, 0   // counter for concat_array_outstr string

arrlengthiszero:
   CMP   X21, XZR
   B.EQ  exit
   SUB   X21, X21, 1 // length - 1

loop:   
   LDR   X0, [X20, X22] // LDR one element from array (unsigned long int) into X0; [X20, X22] -> array with offset [index*8]
   BL    itoascii       // returns string (chars) -> X0

innerloop:   
   LDRB  W26, [X0, X24] // loads 1 byte of info from return string (return from itoascii)
   CMP   W26, WZR       // compares if byte in return == 0
   B.EQ  space                      
   
   STRB  W26, [X27, X25]
   ADD   X24, X24, 1
   ADD   X25, X25, 1
   B     innerloop
   
space:
   STRB  W23, [X27, X25]
   ADD   X25, X25, 1
   CMP   X21, XZR
   B.EQ  exit
   SUB   X21, X21, 1
   ADD   X22, X22, 8
   MOV   X24, 0
   B     loop

exit:
   MOV   X0, X27

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

.data
    /* Put the converted string into concat_array_outstrer,
       and return the address of concat_array_outstr */
    concat_array_outstr:  .fill 1024, 1, 0
