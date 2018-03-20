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

    MOV BX,20
    CMP BX,8
    JBE L1   ;N < 9
    JMP L3   ;N >= 9
    
L1: CMP BL,'1'
    JE  L2
    MOV AX,1 
    MOV CX,AX
L4: INC CX
    MUL CX
    MOV NUM[0],AX  
    CMP CX,BX
    JNE L4 
    JMP S3
    
L3: MOV AX,1 
    MOV CX,AX
S1: INC CX
    MUL CX  
    CMP CX,9
    JNE S1      
    
L2: MOV NUM[0],AX
    MOV NUM[2],DX
    CMP BX,9 
    JBE S3
    
    PUSH BX
S2: ADD CX,1
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
    JBE  S2  
    
S3:    
    MOV DI,6
    
S6: MOV AX,NUM[DI]
    MOV CX,0
S5: MOV DX,0
    MOV BX,10
    DIV BX
    PUSH DX
    INC CX
    CMP AX,0
    JE S4
    JMP S5
S4: POP DX
    ADD DL,30H
    MOV AH,2
    INT 21H
    LOOP S4 
    SUB DI,2
    CMP DI,0
    JGE S6
    
    
    
    

    mov ax, 4c00h 
    int 21h    
ends

end start
