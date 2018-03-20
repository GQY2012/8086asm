
data segment
   STRING1 DB 50 DUP(0)
   STRING2 DB 50 DUP(0)
ends

ASSUME  CS:code,DS:data

code segment
start:

        mov ax, data
        mov ds, ax
        mov es, ax
        MOV DI,0
        
S1:     MOV AH,1
        INT 21H
        CMP AL,13
        JE S3 
        CMP AL,'z'
        JG  S2
        CMP AL,'a'
        JL  S2
        SUB AL,32
S2:     MOV STRING1[DI],AL
        INC DI
        JMP S1 
        
        
S3:     SUB DI,1
        MOV SI,0
S4:     CMP DI,-1
        JE S5
        MOV DL,STRING1[SI]
        MOV STRING2[DI],DL
        INC SI
        DEC DI
        JMP S4   
        
        
S5:     INC DI
        MOV STRING2[SI],'$'
        MOV AH,9  
        LEA DX,STRING2                      
        INT 21H
        
        mov ax,4c00h 
        int 21h   
ends

end start 
