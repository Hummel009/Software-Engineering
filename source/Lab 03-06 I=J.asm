org 100h
;FIND THE QUANTITY OF NOT UNIQUE ELEMENTS IN ARRAY AND DISPLAY THEM

;====== START ======;
        mov ah, 09h
        mov dx, str1
        int 21h

;====== DISPLAY 1ST ======;
        mov cx, 2
cycle0:
        mov bx, cx
        mov ax, [arr1+bx]
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
        cmp cx, [arrSize]

jbe cycle0

        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str2
        int 21h

;====== DISPLAY 2ND ======;
        mov cx, 2
cycle1:
        mov bx, cx
        mov ax, [arr2+bx]
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
        cmp cx, [arrSize]

jbe cycle1

;====== FIRST LOOP ======;
        mov cx, 2
cycle2:

        mov bx, cx
        mov dx, [arr1+bx]
        mov [savedAI], dx

        mov bx, cx
        mov dx, [arr2+bx]
        mov [savedBI], dx

        mov dx, [savedAI]
        cmp dx, [savedBI]

        jne @F

        mov bx, [savedDupPos]
        mov dx, [savedBI]
        mov [arr3+bx], dx
        add [savedDupPos], 2

        @@:
        add cx, 2
        cmp cx, [arrSize]

jbe cycle2

        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str3
        int 21h

        mov cx, 2

cycle5:
        mov bx, cx
        mov ax, [arr3+bx]
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
        cmp cx, [savedDupPos]

jb cycle5


;====== DISPLAY THE QUANTITY ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str4
        int 21h

        mov ax, [savedDupPos]
        sub ax, 2
        mov bl, 2
        idiv bl

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
        str1 db "1st array: $"
        str2 db "2nd array: $"
        str3 db "Duplicates: $"
        str4 db "Duplicates quantity: $"
        arr1 dw '0', 1, 2, 3, 4, 5, 6, 7, 8, 9
        arr2 dw '0', -1, -2, 3, 4, -5, 6, 7, 8, 9
        arr3 dw '0', 0, 0, 0, 0, 0, 0, 0, 0, 0
        arrSize dw 18
        newLine db 13, 10, '$'
        savedAI dw 0
        savedBI dw 0
        temp dw 0
        savedDupPos dw 2  