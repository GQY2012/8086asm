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
    
    MOV BX,1 ;N
    PUSH BX
    
    MOV AX,1
    MOV DX,0
    MOV CX,0 
    
    MOV NUM[0],AX
    MOV NUM[2],DX
    
S1: PUSH BX
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
    JB  S1
    
    
    MOV DI,6
    MOV CX,0

S6: MOV BX,NUM[DI] 
    MOV CX,4
S2: ROL BX,4
    MOV AX,BX
    AND AL,0FH
    ADD AL,30H 
    CMP AL,0
    JE L
    CMP AL,3AH
    JL  S3
    ADD AL,7H
    
S3: MOV DL,AL
    MOV AH,2
    INT 21H
L:  LOOP S2
    SUB DI,2
    CMP DI,0
    JGE S6
    
    mov ax, 4c00h 
    int 21h    
ends

end start
