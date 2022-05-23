org 100h
;THE SUM OF 0+ ELEMENTS WITH INDEXES MOD 2 = 1

;====== START ======;
        mov ah, 09h
        mov dx, writeln1
        int 21h

;====== SHOW ARR ======;
        mov bx, 0
cycle1:
        mov ah, 02h
        mov dx, [nums+bx]
        add dx, '0'
        int 21h

        add bx, 2
        cmp bx, [bytes]
jng cycle1

        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, writeln2
        int 21h

;====== DISPLAY NEEDED ITEMS ======;
        mov bx, 0
cycle2:
        mov cx, 4
        mov ax, bx
        mov dx, 0
        div cx
        cmp dx, 0

        jne skip

        mov ax, [nums+bx]
        add [mods], ax
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

        mov ax, [mods]
        call intToStrAndDisp

;====== DO NOT EXIT ======;
        mov ah, 08h
        int 21h
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
        writeln1 db "Start array: $"
        writeln2 db "New array: $"
        writeln3 db "The sum of items mod 2 = 0: $"
        nums dw 1, 2, 3, 4, 5, 6, 7, 8, 9
        newLine db 13, 10, '$'
        mods dw 0
        bytes dw 16   
