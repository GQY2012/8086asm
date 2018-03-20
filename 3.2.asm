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
        MOV BX,0FD5EH
        
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
        CMP CX,16
        JNE S6 
        CMP AL,'0'
        JE S7
        MOV AL,'-' 
        JMP S6
S7:     MOV AL,'+'
           
S6:     MOV DL,AL
        MOV AH,2
        INT 21H
        LOOP S1
        JMP EXIT
                 
        
H:      MOV CX,5
        ROL BX,1 
        MOV AX,BX
        SHR BX,1
        AND AL,01H
        ADD AL,30H
        CMP AL,'0'
        JE S8
        MOV AL,'-' 
        JMP S3
S8:     MOV AL,'+'
        JMP S3
        
S2:     
        ROL BX,4 
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


D:      
        ROL BX,1 
        MOV AX,BX
        SHR BX,1
        AND AL,01H
        ADD AL,30H
        CMP AL,'0'
        JE S9
        MOV AL,'-' 
        JMP S10
S9:     MOV AL,'+'
        JMP S10
S10:    MOV DL,AL
        MOV AH,2
        INT 21H


        MOV AX,BX
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