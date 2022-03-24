org 100h
;FIND THE QUANTITY OF UNIQUE ELEMENTS IN ARRAY

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

;====== FIRST LOOP ======;
        mov cx, 2
cycle2:

        mov [savedI], cx
        mov [added], 0

        ;====== SECOND LOOP ======;
        mov cx, [savedI]
        cycle3:
                mov [savedJ], cx    

                mov bx, [savedI]
                mov dx, [nums+bx]
                mov [savedAI], dx    

                mov bx, [savedJ]
                mov dx, [nums+bx]
                mov [savedAJ], dx

                mov dx, [savedI]
                cmp dx, [savedJ]
                je @F

                mov dx, [savedAI]
                cmp dx, [savedAJ]
                jne @F        

        ;====== BREAK ELEMENT ======;
                mov bx, [savedJ]
                mov [nums+bx], 'd'

                mov [added], 1

                @@:
                add cx, 2
                cmp cx, [bytes]

        jbe cycle3

        mov ax, [added]

        cmp ax, 0
        je @F

        mov bx, [savedI]
        mov [nums+bx], 'd'

        @@:
        mov cx, [savedI]
        add cx, 2
        cmp cx, [bytes]

jbe cycle2

;====== CALCULATE UNIQUE ELEMENTS ======;
        mov cx, 2
cycle4:
        mov bx, cx
        mov ax, [nums+bx]

        cmp ax, 'd'
        jne @F

        sub [unique], 1

        @@:
        add cx, 2
        cmp cx, [bytes]

jbe cycle4

        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str2
        int 21h

        mov cx, 2

cycle5:
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

jbe cycle5


;====== DISPLAY THE QUANTITY ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str3
        int 21h

        mov ax, [unique]
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
        str1 db "Start array: $"
        str2 db "No duplicat: $"
        str3 db "Unique elements: $"
        nums dw '0', 2, 2, -3, 5, 7, 4, 7, 2, 9
        bytes dw 18
        length dw 9
        unique dw 9
        newLine db 13, 10, '$'
        savedI dw 0
        savedJ dw 0
        savedAI dw 0
        savedAJ dw 0   
        temp dw 0
        added dw 0 