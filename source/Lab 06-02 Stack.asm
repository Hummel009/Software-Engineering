org 100h
;CALCULATE FORMULA WITH 16-BIT NUMBERS USING CALL WITH STACK

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
        mov ax, 0
        mov al, [str3+2]
        sub al, '0'

        mov bx, 0
        mov bl, [str4+2]
        sub bl, '0'

;====== PREPARING CALL ======;
        push ax
        push bx

        call operations

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

ret

;====== OPERATIONS ======;
operations:
        push bp
        mov bp, sp
        mov ax, [bp+4]
        mov bx, [bp+4]
        mul bx
        add ax, 1
        mov bx, ax
        mov ax, [bp+6]
        div bx
        add ax, 1
        pop bp
retn 4

;====== VARIABLES ======;
        str1 db "Enter the number C: $"
        str2 db "Enter the number D: $"
        str3 db 2, 0, 2 dup "$"
        str4 db 2, 0, 2 dup "$"
        newLine db 13, 10, '$'