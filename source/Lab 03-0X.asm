org 100h
;find the quantity of 7+ elements in the array and replace them with "7"

;====== Start ======;
        mov ah, 09h
        mov dx, str1
        int 21h
        mov [big], 0

;====== First loop: count 0- ======;
        mov cx, [bytes]
startA1:

        mov bx, cx
        cmp [nums+bx], 7
        jng @F      ;if >=0, then skip increment

        add [big], 1
        mov [nums+bx], 7

        @@:
        dec cx

loop startA1

;====== Display 1st ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str2
        int 21h

        mov ax, [big]
        call intToStrAndDisp

;====== Do not exit ======;
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
        str1 db "Array:  1, 2, 3, 4, 7, 6, 7, 8, 9$"
        str2 db "Found >7 elements: $"
        nums dw '0', 1, 2, 3, 4, 7, 6, 7, 8, 9
        bytes dw 18
        newLine db 13, 10, '$'
        big dw 0
