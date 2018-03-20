data segment
    NUM DW 4 DUP(0)
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:

    mov ax, data
    mov ds, ax
    mov es, ax

    
    MOV BX,9
    
    CMP BX,9
    JA L3
    
    MOV AX,1 
    MOV CX,AX
L1: INC CX
    MUL CX  
    CMP CX,BX
    JNE L1
    CMP BX,9
    JBE L2
     
  
L3: PUSH BX
    MOV AX,1 
    MOV CX,AX
S1: INC CX
    MUL CX  
    CMP CX,9
    JNE S1      ;N<10
    
L2: MOV NUM[0],AX
    MOV NUM[2],DX
    CMP BX,9
    JBE S3
    
S2: PUSH BX
    ADD CX,1
    MOV AX,NUM[0]
    MUL CX
    MOV NUM[0],AX
    MOV BX,DX 
    
    MOV AX,NUM[2]
    MUL CX
    PUSH DX
    MOV DX,BX
    ADD AX,DX
    MOV NUM[2],AX
    POP DX
    MOV BX,DX
    
    PUSHF
    MOV AX,NUM[4]
    MUL CX 
    POPF 
    PUSH DX
    MOV DX,BX
    ADC AX,DX
    MOV NUM[4],AX
    POP DX
    MOV BX,DX 
    
    MOV AX,NUM[6]
    MUL CX  
    MOV DX,BX
    ADC AX,DX
    MOV NUM[6],AX
    
    POP BX
    CMP CX,BX
    JB  S2

S3: mov ax, 4c00h 
    int 21h    
ends

end start
