org 100h
;CALCULATE FORMULA WITH 8-BIT NUMBERS USING CALL WITH STACK

;====== START ======;
        mov ah, 09h
        mov dx, str1
        int 21h

        mov ah, 0ah
        mov dx, str3
        int 21h

        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str2
        int 21h

        mov ah, 0ah
        mov dx, str4
        int 21h

        mov ah, 09h
        mov dx, newLine
        int 21h

;====== STR TO INT ======;
        mov al, [str3+2]
        sub al, '0'

        mov bl, [str4+2]
        sub bl, '0'

;====== PREPARING CALL ======;
        push ax
        push bx

        call operations

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

ret

;====== OPERATIONS ======;
operations:
        push bp
        mov bp, sp

        mov al, [bp+6]

        mov bl, [bp+6]
        mul bl

        mov bl, [bp+4]
        div bl

        mov bl, [bp+6]
        add al, bl

        pop bp

retn 4

;====== VARIABLES ======;
        str1 db "Enter the number A: $"
        str2 db "Enter the number B: $"
        str3 db 2, 0, 2 dup "$"
        str4 db 2, 0, 2 dup "$"
        newLine db 13, 10, '$'