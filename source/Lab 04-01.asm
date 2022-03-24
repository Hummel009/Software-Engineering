org 100h
;SORT THE ARRAY USING THE BUBBLE SORT
;NO SUPPORT FOR ARRAY WITH NUMBERS 0-

;====== START ======;
        mov ah, 09h
        mov dx, str1
        int 21h

        mov cx, 2

cycle1:
        mov bx, cx
        mov ax, [nums+bx]
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

                mov dx, [savedAI]
                cmp dx, [savedAJ]
                jl notSwapThem

        ;====== SWAP ======;
                mov ax, [savedAJ]
                mov bx, [savedI]
                mov [nums+bx], ax

                mov ax, [savedAI]
                mov bx, [savedJ]
                mov [nums+bx], ax

                mov cx, [savedJ]

                notSwapThem:
                add cx, 2
                cmp cx, [bytes]

        jbe cycle3

        mov cx, [savedI]
        add cx, 2
        cmp cx, [bytes]

jbe cycle2

        mov ah, 09h
        mov dx, newLine
        int 21h

;====== DISPLAY THE ARRAY ======;
        mov ah, 09h
        mov dx, str2
        int 21h

        mov cx, 2
cycle4:
        mov bx, cx
        mov ax, [nums+bx]
        call intToStrAndDisp

        mov ah, 02h
        mov dx, ' '
        int 21h

        add cx, 2
        cmp cx, [bytes]

jbe cycle4

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
        str1 db "Start array: $"
        str2 db "Sorted array: $"
        nums dw '0', 9, 5, 17, 6, 8, 4, 3, 2, 1
        bytes dw 18                               
        length dw 9                                 
        newLine db 13, 10, '$'
        neededI dw 0
        neededJ dw 0
        savedI dw 0
        savedJ dw 0
        savedAI dw 0
        savedAJ dw 0