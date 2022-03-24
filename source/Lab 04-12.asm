org 100h
;sort array

;====== Start ======;
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

;====== First loop: for every element ======;
        mov cx, [bytes]               ;cx is needed for the loop
startA1:

        mov [savedI], cx              ;save cx, because second loop will change it

        ;=======Second loop: for every element=======;
        mov cx, [bytes]               ;set new limit

        startA2:
                mov [savedJ], cx      ;save J

                mov bx, [savedI]
                mov dx, [nums+bx]
                mov [savedAI], dx     ;save item 1, that will be compared with 2

                mov bx, [savedJ]
                mov dx, [nums+bx]
                mov [savedAJ], dx     ;save item 2, that will be compared with 1

                mov dx, [savedAI]
                cmp dx, [savedAJ]
                jb notSwapThem       ;if not equal, do not decrement the quantity

                mov bx, [savedI]
                mov dx, [nums+bx]

                mov bx, [savedJ]
                mov ax, [nums+bx]

                mov cx, ax;
                mov ax, dx;
                mov dx, cx;

                mov bx, [savedI]
                mov [nums+bx], dx

                mov bx, [savedJ]
                mov [nums+bx], ax

                mov cx, [savedJ]

                notSwapThem:
                dec cx                ;every loop does -1, but we need -2: every element is 2 bytes

        finishA1:
        loop startA2

        mov cx, [savedI]              ;load saved counter instead of corrupted one from A2
        dec cx                        ;every loop does -1, but we need -2: every element is 2 bytes

loop startA1

        mov ah, 09h
        mov dx, newLine
        int 21h

;====== Display arr ======;

        mov ah, 09h
        mov dx, newLine
        int 21h

        mov cx, 2
cycle2:
        mov bx, cx
        mov ax, [nums+bx]
        call intToStrAndDisp

        mov ah, 02h
        mov dx, ' '
        int 21h

        add cx, 2
        cmp cx, [bytes]

jbe cycle2

;====== Do not exit ======;
        mov ah, 08h
        int 21h
        
ret

;====== IntToStr ======;
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
        nums dw '0', 9, 8, 17, 6, 5, 4, 3, 2, 1      ;our array; '0' prevents from skipping the first element while loop breaks
        bytes dw 18                                 ;array elements * 2
        length dw 9                                 ;array elements
        newLine db 13, 10, '$'
        neededI dw 0
        neededJ dw 0
        savedI dw 0
        savedJ dw 0
        savedAI dw 0
        savedAJ dw 0  
