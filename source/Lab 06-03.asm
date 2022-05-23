org 100h
;CALCULATE FORMULA WITH 16-BIT NUMBERS USING CALL WITH REGISTERS

;====== START ======;
        mov ah, 09h
        mov dx, str1
        int 21h

        mov ah, 0ah
        mov dx, str4
        int 21h

        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str2
        int 21h

        mov ah, 0ah
        mov dx, str5
        int 21h

        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str3
        int 21h

        mov ah, 0ah
        mov dx, str6
        int 21h

        mov ah, 09h
        mov dx, newLine
        int 21h

;====== STR TO INT ======;
        mov ax, 0
        mov al, [str4+2]
        sub al, '0'
        mov [savedX], ax

        mov ax, 0
        mov al, [str5+2]
        sub al, '0'
        mov [savedY], ax

        mov ax, 0
        mov al, [str6+2]
        sub al, '0'
        mov [savedZ], ax

        call operations

;====== SHOW ======;
        call intToStrAndDisp

        mov ah, 08h
        int 21h

ret

;====== OPERATIONS ======;
operations:
        mov ax, [savedX]
        mov bx, [savedX]
        mul bx

        mov cx, [savedY]
        mov bx, [savedY]
        mul bx

        add ax, cx
        mov bx, [savedZ]
        mul bx

        mov cx, [savedZ]
        sar ax, cl
ret

;====== CONVERT ======;
intToStrAndDisp:
        aam

        add ax, '00'
        mov dl, ah
        mov dh, al
                
        mov ah, 02h
        int 21h
                
        mov dl, dh
        int 21h
ret

;====== VARIABLES ======;
        str1 db "Enter the number X: $"
        str2 db "Enter the number Y: $"
        str3 db "Enter the number Z: $"
        str4 db 2, 0, 2 dup "$"
        str5 db 2, 0, 2 dup "$"
        str6 db 2, 0, 2 dup "$"
        newLine db 13, 10, '$'
        savedX dw 0
        savedY dw 0
        savedZ dw 0