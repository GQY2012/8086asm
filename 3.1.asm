DATA    SEGMENT
DATA    ENDS

STACK   SEGMENT
   NUM DW 20H DUP(?)
STACK ENDS

CODE    SEGMENT
        ASSUME  CS:CODE,DS:DATA
BEGIN:  MOV AX,DATA
        MOV DS,AX
        MOV AX,STACK
        MOV SS,AX
        LEA SP,NUM
        MOV BX,0FFFFH
        
        MOV AH,1
        INT 21H
        CMP AL,'H'
        JE H
        CMP AL,'B'
        JE B
        JMP D
        
        
B:      MOV CX,16
S1:     
        ROL BX,1
        MOV AX,BX
        AND AL,1H
        ADD AL,30H
        MOV DL,AL
        MOV AH,2
        INT 21H
        LOOP S1
        JMP EXIT
                 
        
H:      MOV CX,4
S2:     ROL BX,4
        MOV AX,BX
        AND AL,0FH
        ADD AL,30H
        CMP AL,3AH
        JL  S3
        ADD AL,7H
        
S3:     MOV DL,AL
        MOV AH,2
        INT 21H
        LOOP S2
        JMP EXIT


D:      MOV AX,BX
        MOV CX,0
S5:     MOV DX,0
        MOV BX,10
        DIV BX
        PUSH DX
        INC CX
        CMP AX,0
        JE S4
        JMP S5
S4:     POP DX
        ADD DL,30H
        MOV AH,2
        INT 21H
        LOOP S4   
        
        
        
        
EXIT:   MOV AH,4CH
        INT 21H
CODE    ENDS
        END  BEGIN