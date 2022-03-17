org 100h

start:
        mov ah, 09h
        mov dx, str1
        int 21h

        mov cx, [bytes]
startA2:

        mov bx, cx
        mov ax, [nums+bx]

        add [plus], ax

        finishA2:

        cmp cx, 4
        jl skipaboba


        dec cx
        dec cx
        dec cx

skipaboba:

loop startA2

;====== Display 2nd ======;

        call newLine

        mov ah, 09h
        mov dx, str3
        int 21h

        mov ax, [plus]
        call intToStrAndDisp

        mov ah, 08h
        int 21h
        
ret

newLine:
        mov ah, 02h
        mov dl, 10
        int 21h

        mov ah, 02h
        mov dl, 13
        int 21h
ret

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

;====== Temp variables ======;
        plus dw 0   