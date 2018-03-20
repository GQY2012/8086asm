data segment
    NUM DB 20 DUP(0)
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
        mov ax, data
        mov ds, ax
        mov es, ax 
        MOV DI,0
    
        MOV AH,1
        INT 21H
        CMP AL,'H'
        JE H
        CMP AL,'B'
        JE B
        JMP D
        
        
B:  
        MOV AH,1
        INT 21H
        CMP AL,13
        JE EXIT
        SUB AL,'0'
        MOV NUM[DI],AL
        SHL BX,1
        ADD BL,NUM[DI]
        INC DI  
        LOOP B
    
H:  
        MOV AH,1
        INT 21H
        CMP AL,13
        JE EXIT
        CMP AL,'9'
        JGE S1
        SUB AL,'0' 
        JMP S2
S1:     SUB AL,'7'
S2:     MOV NUM[DI],AL
        SHL BX,4
        ADD BL,NUM[DI]
        INC DI  
        LOOP H
    
D:      MOV AH,1
        INT 21H
        CMP AL,13
        JE EXIT
        SUB AL,'0'
        MOV NUM[DI],AL
        MOV AX,BX
        MOV CX,10
        MUL CX
        MOV BX,AX
        ADD BL,NUM[DI]
        INC DI  
        JMP D
    
            
EXIT: mov ax, 4c00h 
      int 21h    
ends

end start 