
data segment
    NUM DW 100 DUP(0);EXPR
    OPR DW 100 DUP(?);SYM
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
    mov ax, data
    mov ds, ax
    mov es, ax
    
    MOV BX, 0
    MOV SI, -1;FLAG1
    MOV CX, 10
    MOV DI, 0
    
    MOV NUM[DI],'('
    MOV OPR[DI],'('
    ADD DI,2 
    
S2: MOV AH,1
    INT 21H 
    MOV AH,0
    CMP AL,'0'
    JB S3
    
    MOV CX,1;FLAG2
    PUSH CX 
    MOV CX,10
    INC SI 
    SUB AL,'0'
    CMP SI,0
    JNE S1
    MOV BX,AX 
    JMP S2
S1: PUSH AX
    MOV AX,BX
    MUL CX
    MOV BX,AX
    POP AX
    ADD BX,AX
    JMP S2 


S3: POP CX
    CMP CX,1
    JNE S4
    MOV NUM[DI],BX   ;EXPR
    MOV BX, 0
    ADD DI,2   
    
S4: CMP AL,13
    JE S6
    MOV NUM[DI],AX    ;EXPR
    MOV OPR[DI],AX    ;SYM
    ADD DI,2
    MOV SI,-1
    MOV CX,0
    PUSH CX
    JMP S2    ;LEX
    
    
S6: MOV NUM[DI],')'
    MOV OPR[DI],')'
    MOV BX,DI;LENGTH
    MOV DI,0
S7: 
    CMP NUM[DI],')'
    CMP OPR[DI],')'
    JNE S8
    MOV SI,DI;PH
S9: SUB DI,2
    CMP NUM[DI],'('
    CMP OPR[DI],'('
    JNE S9
    MOV CX,DI;PL
    MOV AX,NUM[DI+2] 
    ADD DI,4
    CMP DI,SI
    JE S15
S11:CMP OPR[DI],'+'
    JE S10
    SUB AX,NUM[DI+2]
    JMP S12
S10:ADD AX,NUM[DI+2]
S12:ADD DI,4
    CMP DI,SI
    JNE S11
    
S15:MOV DI,CX
    MOV NUM[DI],AX
    MOV OPR[DI],0 
    CMP DI,0
    JE S13
S14:ADD SI,2 
    ADD DI,2
    MOV DX,NUM[SI]
    MOV NUM[SI],0
    MOV NUM[DI],DX
    MOV DX,OPR[SI]
    MOV OPR[SI],0
    MOV OPR[DI],DX
    CMP SI,BX
    JBE S14
    MOV BX,DI
    MOV DI,CX 
    
S8: ADD DI,2
    CMP DI,BX
    JBE S7
        
    
S13:MOV BX,AX   
    
    MOV DL,13
    MOV AH,2
    INT 21H
    MOV DL,10
    MOV AH,2
    INT 21H
 
    CMP BX,0
    JGE L1
    NEG BX
    MOV AL,'-' 
    MOV DL,AL
    MOV AH,2
    INT 21H

L1:  
    MOV AX,BX
    MOV CX,0
L2: MOV DX,0
    MOV BX,10
    DIV BX
    PUSH DX
    INC CX
    CMP AX,0
    JE L3
    JMP L2
L3: POP DX
    ADD DL,30H
    MOV AH,2
    INT 21H
    LOOP L3  
        
    mov ax, 4c00h 
    int 21h    
ends

end start 
