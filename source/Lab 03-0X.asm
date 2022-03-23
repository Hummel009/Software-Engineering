org 100h
;calculate all the nums that are bigger then 7, replace them with 7 and display the new array

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
        jng @F ;if >=0, then skip increment

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
        mov ah, 09h
        mov dx, newLine
        int 21h

;====== Display arr ======;
        mov ah, 09h
        mov dx, str3
        int 21h

        mov cx, 2
cycle:
        mov bx, cx
        mov ax, [nums+bx]
        call intToStrAndDisp

        mov ah, 02h
        mov dx, ' '
        int 21h

        add cx, 2
        cmp cx, [bytes]

jbe cycle

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
        str1 db "Array: 9, 2, 9, 4, 7, 6, 7, 8, 9$"
        str2 db "Found >7 elements: $"
        str3 db "New array: $"
        nums dw '0', 9, 2, 9, 4, 7, 6, 7, 8, 9
        bytes dw 18
        newLine db 13, 10, '$'
        big dw 0