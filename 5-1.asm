data segment
ends

STACK SEGMENT
    STRING DW 20H DUP(?)
ENDS

ASSUME  CS:code,DS:data,SS:STRING

code segment
start:

        mov ax, data
        mov ds, ax
        mov es, ax
        MOV DI,0
        MOV CX,0
        
S1:     MOV AH,1
        INT 21H
        CMP AL,13
        JE S3 
        CMP AL,'z'
        JG  S2
        CMP AL,'a'
        JL  S2
        SUB AL,32
S2:     PUSH AX
        INC CX
        JMP S1 

S3:     POP AX
        MOV AH,2H  
        MOV DX,AX                      
        INT 21H
        LOOP S3
        
        mov ax,4c00h 
        int 21h   
ends

end start 
