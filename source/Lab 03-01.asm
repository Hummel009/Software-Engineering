org 100h
;THE SUM OF 0- ELEMENTS WITH INDEXES MOD 2 = 1

;====== START ======;
        mov ah, 09h
        mov dx, str1
        int 21h

        mov cx, 2

cycle1:
        mov bx, cx
        mov ax, [nums+bx]
        mov [temp], ax

        cmp ax, 0
        jnl @F

        mov ah, 02h
        mov dx, '-'
        int 21h

        mov ax, [temp]
        mov bl, -1
        idiv bl

        @@:
        call intToStrAndDisp

        mov ah, 02h
        mov dx, ' '
        int 21h

        add cx, 2
        cmp cx, [bytes]

jbe cycle1

;====== CALCULATE THE SUM ======;
        mov cx, 2
cycle2:

        mov bx, cx
        mov ax, [nums+bx]
        add [plus], ax

        add cx, 4
        cmp cx, [bytes]

jbe cycle2

;====== DISPLAY THE SUM ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str2
        int 21h

        mov ax, [plus]
        call intToStrAndDisp

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
        str1 db "Array: $"
        str2 db "The sum: $"
        nums dw '0', -1, -2, -3, 4, 7, 6, 7, 8, 9
        bytes dw 18
        newLine db 13, 10, '$'
        plus dw 0
        temp dw 0     