.global itoascii

itoascii:
   // char* itoascii(unsigned long int number -> X0);

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

   ADR   X24, buffer    
   MOV   X19, 0  
zeroout:
   CMP   X19, 128
   B.EQ  initialize   
   STR   XZR, [X24, X19]
   ADD   X19, X19, 8
   B     zeroout
   
initialize:
   MOV   X20, 10
   MOV   X21, X0  // X0 -> unsigned long int number            
   MOV   X22, 0   // X22 -> length-1          
   
length:
   UDIV  X21, X21, X20
   CMP   X21, XZR
   B.EQ  preloop
   ADD   X22, X22, 1
   B     length

preloop:
   MOV   X21, X0  
loop:
   // extracts last digit of number   
   UDIV  X21, X21, X20  
   MUL   X25, X21, X20   
   SUB   X23, X0, X25     

tochar:
   ADD   X23, X23, 48
   
   STRB  W23, [X24, X22]
   CMP   X22, XZR
   B.EQ  exit
   
   SUB   X22, X22, 1
   MOV   X0, X21
   B     loop        

exit:
   MOV   X0, X24

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
    /* Put the converted string into buffer,
       and return the address of buffer */
    buffer: .fill 128, 1, 0
    