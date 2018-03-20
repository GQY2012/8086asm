data segment
    PATHNM DB 'test.txt'
    BUFFER DB 100 DUP (0)
    NUM DW 100 DUP (0)
ends

stack segment
    dw   128  dup(0)
ends

code segment  
assume  CS:code, DS:data

start:   mov ax, data
         mov ds, ax 
         MOV SI,-1
         MOV DI,-2 
         MOV CX,0
    
         MOV AH,3DH
         LEA DX,PATHNM
         MOV AL,2
         INT 21H  ;OPEN
    
         LEA DX,BUFFER
         MOV BX,AX
         MOV CX,100
         MOV AH,3FH
         INT 21H 
         MOV CX,0  ;READ
        
S2:      MOV AX,0
         MOV DX,0 
         ADD DI,2
         INC SI
         INC CX 
S1:      MOV AL,BUFFER[SI]
         CMP AL,' '
         JE S2
         CMP AL,0H
         JE S3
         SUB AL,'0'
         ADD DL,AL
         MOV NUM[DI],DX
         SHL DX,4
         INC SI 
         JMP S1   
         
         
S3:      MOV NUM[DI+2],'$'
         PUSH CX   
         MOV AX,0
         MOV DX,0 
         MOV BX,-2 
S4:      MOV SI,2
         ADD BX,2
S6:      MOV AX,NUM[BX]
         CMP NUM[BX+SI],'$'
         JE S7
         MOV DX,NUM[BX+SI]
         CMP AX,DX 
         JBE S5
         MOV NUM[BX],DX
         MOV NUM[BX+SI],AX
S5:      ADD SI,2
         JMP S6 
S7:      LOOP S4   ;SORT 
                 

         POP CX
         MOV DI,0 
S9:      MOV BX,4             
         MOV AX,NUM[DI]
S8:      ROL AX,4
         MOV DX,AX
         AND DX,000FH
         ADD DX,'0'
         PUSH AX
         MOV AH,2H
         INT 21H          
         POP AX
         DEC BX
         CMP BX,0    
         JNE S8
         PUSH AX
         MOV DL,' '
         MOV AH,2H
         INT 21H
         POP AX
         ADD DI,2
         LOOP S9   ;PRINT
    
         MOV AH,3EH
         INT 21H   ;CLOSE
         
         mov ax, 4c00h  
         int 21h    ;RAT
ends

end start 
