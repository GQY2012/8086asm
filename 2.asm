DATA SEGMENT
    DBUF DB 1,20,-30,0,-5,-66,77,-32,-9,0,0,78,-2,-78,34
    PLUS DB 0
    MINS DB 0 
    ZERO DB 0
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA

BEGIN:
        MOV AX,DATA
        MOV DS,AX
        MOV CX,15
        MOV SI,0
AGAIN:
        CMP DBUF[SI],0
        JG  NEXT
        JE  LAST
        INC MINS
        JMP LAST
NEXT:
        INC PLUS
LAST:
        INC SI
        LOOP AGAIN
        MOV DL,PLUS
        ADD DL,MINS 
        MOV CX,15
        SUB CX,DX
        MOV ZERO,CL
        MOV AH,4CH
        INT 21H

CODE ENDS
        END BEGIN