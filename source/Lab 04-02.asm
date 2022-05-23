org 100h
;DISPLAY THE QUANTITY OF ITEMS MOD 2 = 0 AND DISPLAY THEM AS AN ARRAY
;NO SUPPORT FOR ARRAY WITH NUMBERS 0-

;====== START ======;
        mov ah, 09h
        mov dx, writeln1
        int 21h

;====== SHOW ARR ======;
        mov bx, 0
cycle:
        mov ah, 02h
        mov dx, [nums+bx]
        add dx, '0'
        int 21h

        add bx, 2
        cmp bx, [bytes]
jng cycle

        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, writeln2
        int 21h

;====== DISPLAY NEEDED ITEMS ======;
        mov bx, 0
cycle2:
        mov cx, 2
        mov ax, [nums+bx]
        mov dx, 0
        div cx
        cmp dx, 1

        je skip

        add [mods], 1
        mov dx, [nums+bx]
        add dx, '0'
        mov ah, 02h
        int 21h

        skip:

        add bx, 2
        cmp bx, [bytes]
jng cycle2

;====== DISPLAY THE QUANTITY ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, writeln3
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
        writeln1 db "Start array: $"
        writeln2 db "New array: $"
        writeln3 db "Quantity of items mod 2 = 0: $"
        nums dw 1, 2, 3, 4, 5, 6, 7, 8, 9
        newLine db 13, 10, '$'
        mods dw 0
        bytes dw 16 
