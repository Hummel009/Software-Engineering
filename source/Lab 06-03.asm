org 100h
;CALCULATE FORMULA WITH 16-BIT NUMBERS USING CALL WITH REGISTERS

;====== START ======;
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

        mov ah, 09h
        mov dx, writeln3
        int 21h

        mov ah, 0ah
        mov dx, readln3
        int 21h

        mov ah, 09h
        mov dx, newLine
        int 21h

;====== STR TO INT ======;
        mov ax, 0
        mov al, [readln1+2]
        sub al, '0'
        mov [savedX], ax

        mov ax, 0
        mov al, [readln2+2]
        sub al, '0'
        mov [savedY], ax

        mov ax, 0
        mov al, [readln3+2]
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
        writeln1 db "Enter the number X: $"
        writeln2 db "Enter the number Y: $"
        writeln3 db "Enter the number Z: $"
        newLine db 13, 10, '$'
        readln1 db 2, 0, 2 dup "$"
        readln2 db 2, 0, 2 dup "$"
        readln3 db 2, 0, 2 dup "$"
        savedX dw 0
        savedY dw 0
        savedZ dw 0