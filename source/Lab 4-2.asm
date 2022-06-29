org 100h
;DISPLAY THE QUANTITY OF ITEMS MOD 2 = 0 AND DISPLAY THEM AS AN ARRAY
;NO SUPPORT FOR ARRAY WITH NUMBERS 0-

;====== START ======;
        mov ah, 09h
        mov dx, str1
        int 21h

;====== SHOW ARR ======;
        mov bx, 0
cycle1:
        mov ah, 02h
        mov dx, [arr+bx]
        add dx, '0'
        int 21h

        add bx, 2
        cmp bx, [arrSize]
jng cycle1

        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str2
        int 21h

;====== DISPLAY NEEDED ITEMS ======;
        mov bx, 0
cycle2:
        mov cx, 2
        mov ax, [arr+bx]
        mov dx, 0
        div cx
        cmp dx, 0

        jne skip

        add [mods], 1
        mov dx, [arr+bx]
        add dx, '0'
        mov ah, 02h
        int 21h

        skip:

        add bx, 2
        cmp bx, [arrSize]
jng cycle2

;====== DISPLAY THE QUANTITY ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str3
        int 21h

        mov ah, 02h
        mov dx, [mods]
        add dx, '0'
        int 21h

;====== DO NOT EXIT ======;
        mov ah, 08h
        int 21h
ret

;====== VARIABLES ======;
        str1 db "Start array: $"
        str2 db "New array: $"
        str3 db "Quantity of items mod 2 = 0: $"
        arr dw 1, 2, 3, 4, 5, 6, 7, 8, 9
        newLine db 13, 10, '$'
        mods dw 0
        arrSize dw 16