org 100h
;find the positions of two duplicates in the array

;====== Start ======;
        mov ah, 09h
        mov dx, str1
        int 21h

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


                mov bx, [savedI]
                cmp bx, [savedJ]
                je finishA1           ;do not compare itself

                mov dx, [savedAI]
                cmp dx, [savedAJ]
                jne finishA1          ;if not equal, do not decrement the quantity

                mov ax, [savedI]
                mov bl, 2
                div bl
                mov [neededI], ax

                mov ax, [savedJ]
                mov bl, 2
                div bl
                mov [neededJ], ax

                dec cx                ;every loop does -1, but we need -2: every element is 2 bytes

        finishA1:
        loop startA2

        mov cx, [savedI]              ;load saved counter instead of corrupted one from A2
        dec cx                        ;every loop does -1, but we need -2: every element is 2 bytes

loop startA1

;====== Display first duplicate ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str2
        int 21h

        mov ax, [neededI]
        call intToStrAndDisp

;====== Display second duplicate ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str3
        int 21h

        mov ax, [neededJ]
        call intToStrAndDisp

;====== Do not exit ======;
        mov ah, 08h
        int 21h
        
ret

;====== IntToStr ======;
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
        str1 db "Array: 59, 8, 7, 6, 5, 59, 3, 2, 1$" ;display array
        str2 db "First duplicate: $" ;display dup
        str3 db "Second duplicate: $" ;display dup
        nums dw '0', 59, 8, 7, 6, 5, 59, 3, 2, 1      ;our array; '0' prevents from skipping the first element while loop breaks
        bytes dw 18                                 ;array elements * 2
        length dw 9                                 ;array elements
        newLine db 13, 10, '$'
        neededI dw 0
        neededJ dw 0
        savedI dw 0
        savedJ dw 0
        savedAI dw 0
        savedAJ dw 0  
