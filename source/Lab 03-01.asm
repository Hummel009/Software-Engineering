org 100h

;====== Start ======;
        mov ah, 09h
        mov dx, str1
        int 21h

;====== Loop for the sum of 9, 7, 5, 3, 1 items ======;
        mov cx, [bytes]
startA1:

        mov bx, cx
        mov ax, [nums+bx]

        add [plus], ax

        finishA2:

        cmp cx, 4
        jl @F


        dec cx
        dec cx
        dec cx

@@:
loop startA1

;====== Display ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str3
        int 21h

        mov ax, [plus]
        call intToStrAndDisp

        mov ah, 08h
        int 21h
        
ret

;====== IntToStrAndDisp ======;
intToStrAndDisp:
        aam

        add ax, 3030h
        mov dl, ah
        mov dh, al
                
        mov ah, 02h
        int 21h
                
        mov dl, dh
        int 21h
ret

;====== Variables ======;
        str1 db "Array:  -1, -2, 3, 4, 7, 6, 7, 8, 9$"
        str3 db "The sum of 0+ elements: $"
        nums dw '0', -1, -2, 3, 4, 7, 6, 7, 8, 9
        bytes dw 18
        newLine db 13, 10, '$'
        plus dw 0   