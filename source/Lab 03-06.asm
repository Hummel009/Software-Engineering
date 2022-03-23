org 100h
;find the sum of 0+ elements and the quantity of 0- elements in the array

;====== Start ======;
        mov ah, 09h
        mov dx, str1
        int 21h

;====== First loop: count 0- ======;
        mov cx, [bytes]
startA1:

        mov bx, cx
        cmp [nums+bx], 0
        jnl finishA1      ;if >=0, then skip increment

        add [minus], 1

        finishA1:
        dec cx

loop startA1

;====== Second loop: the sum of 0+ ======;
        mov cx, [bytes]
startA2:

        mov bx, cx
        cmp [nums+bx], 0
        jl finishA2        ;if <0, then skip sum
        mov ax, [nums+bx]

        add [plus], ax

        finishA2:
        dec cx

loop startA2

;====== Display 1st ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str2
        int 21h

        mov ax, [minus]
        call intToStrAndDisp

;====== Display 2nd ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str3
        int 21h

        mov ax, [plus]
        call intToStrAndDisp

;====== Do not exit ======;
        mov ah, 08h
        int 21h
        
ret

;====== IntToStrAndDisp ======;
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

;====== Variables ======;
        str1 db "Array:  -1, -2, 3, 4, 7, 6, 7, 8, 9$"
        str2 db "Found 0- elements: $"
        str3 db "The sum of 0+ elements: $"
        nums dw '0', -1, -2, 3, 4, 7, 6, 7, 8, 9
        bytes dw 18
        newLine db 13, 10, '$'
        minus dw 0
        plus dw 0   
