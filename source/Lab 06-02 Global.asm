format MZ
entry code_seg:entryPoint
stack 200h
;CALCULATE FORMULA WITH 16-BIT NUMBERS USING CALL WITH REGISTERS

segment data_seg
;====== VARIABLES ======;
        writeln1 db "Enter the number C: $"
        writeln2 db "Enter the number D: $"
        newLine db 13, 10, '$'
        readln1 db 2, 0, 2 dup "$"
        readln2 db 2, 0, 2 dup "$"
        savedC dw 0
        savedD dw 0

segment code_seg
;====== START ======;
entryPoint:
        mov ax, data_seg
        mov ds, ax

        mov ah, 09h
        mov dx, writeln1
        int 21h

        mov ah, 0ah
        mov dx, readln1
        int 21h

        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, writeln2
        int 21h

        mov ah, 0ah
        mov dx, readln2
        int 21h

        mov ah, 09h
        mov dx, newLine
        int 21h

;====== STR TO INT ======;
        mov ax, 0
        mov al, [readln1+2]
        sub al, '0'

        mov bx, 0
        mov bl, [readln2+2]
        sub bl, '0'

;====== PREPARING CALL ======;
        mov [savedC], ax
        mov [savedD], bx

        call far calc_seg:operations

;====== SHOW ======;
        aam

        add ax, '00'
        mov dl, ah
        mov dh, al
                
        mov ah, 02h
        int 21h
                
        mov dl, dh
        int 21h

        mov ah, 08h
        int 21h

        mov ax, 4C00h
        int 21h

segment calc_seg
;====== OPERATIONS ======;
operations:
        mov ax, [savedD]
        mov bx, [savedD]
        mul bx
        add ax, 1
        mov bx, ax
        mov ax, [savedC]
        div bx
        add ax, 1
retf