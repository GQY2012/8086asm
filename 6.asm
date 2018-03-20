data segment
     NUM DB 36 DUP(0)
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
       mov ax, data
       mov ds, ax
       mov es, ax
  
       MOV CX,1
       MOV BX,0
S1:    
       MOV [BX],CX
       INC CX
       INC BX
       CMP CX,36
       JLE S1
       MOV BX , 0 
       MOV CX , 0
       JMP S2
S3: 
       MOV DL , 13
       INT 21H
       MOV DL , 10
       INT 21H
       ADD BX , 6 
       INC CX
       MOV DI , 0
       CMP BX , 36
       JE S4:
S2: 
       MOV DL , NUM[BX][DI]
       CMP DL , 10
       JL S5
       MOV AX , DX
       MOV DL , 10
       DIV DL
       MOV DL , AL
       ADD DL , '0'
       MOV CH , AH
       MOV AH , 2
       INT 21H
       MOV DL , CH
       MOV CH , 0
S5:
       ADD DL , '0'
       MOV AH , 2
       INT 21H
       MOV DL , ' '
       INT 21H
       CMP DI , CX
       JE  S3
       INC DI
       JMP S2
       
S4:   
       mov ax, 4c00h
       int 21h    
ends

end start 
