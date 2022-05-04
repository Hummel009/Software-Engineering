format MZ
entry code_seg:entryPoint
stack 200h
;CALCULATE FORMULA WITH 8-BIT NUMBERS USING CALL WITH REGISTERS

segment data_seg
;====== VARIABLES ======;
        writeln1 db "Enter the number A: $"
        writeln2 db "Enter the number B: $"
        newLine db 13, 10, '$'
        readln1 db 2, 0, 2 dup "$"
        readln2 db 2, 0, 2 dup "$"
		
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
        mov al, [readln1+2]
        sub al, '0'

        mov bl, [readln2+2]
        sub bl, '0'

;====== PREPARING CALL ======;
        mov cl, al
        mov ch, bl

        call far calc_seg:operations

;====== SHOW ======;
        mov ah, 0

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
        mov al, cl

        mov bl, cl
        mul bl

        mov bl, ch
        div bl

        mov bl, cl
        add al, bl
retf