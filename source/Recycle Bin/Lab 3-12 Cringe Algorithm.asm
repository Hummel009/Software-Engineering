org 100h

start:
        mov ah, 09h
        mov dx, str1
        int 21h

        mov cx, [bytes]               ;cx is needed for the loop
startA1:

        mov [savedI], cx              ;save cx, because second loop will change it
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
                call wordToByte
                mov [neededI], ax

                mov ax, [savedJ]
                call wordToByte
                mov [neededJ], ax

                dec cx                ;every loop does -1, but we need -2: every element is 2 bytes

        finishA1:
        loop startA2

        mov cx, [savedI]              ;load saved counter instead of corrupted one from A2
        dec cx                        ;every loop does -1, but we need -2: every element is 2 bytes

loop startA1
        call newLine

        mov ah, 09h
        mov dx, str2
        int 21h

        mov ax, [neededI]
        call intToStrAndDisp

        call newLine

        mov ah, 09h
        mov dx, str3
        int 21h

        mov ax, [neededJ]
        call intToStrAndDisp

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

;====== New Line ======;
newLine:
        mov ah, 02h
        mov dl, 10
        int 21h

        mov ah, 02h
        mov dl, 13
        int 21h
ret

;====== Extra Converter ======;
wordToByte:
        cmp ax, 2
        jne goto4
        call set1

        goto4:
        cmp ax, 4
        jne goto6
        call set2

        goto6:
        cmp ax, 6
        jne goto8
        call set3

        goto8:
        cmp ax, 8
        jne goto10
        call set4

        goto10:
        cmp ax, 10
        jne goto12
        call set5

        goto12:
        cmp ax, 12
        jne goto14
        call set6

        goto14:
        cmp ax, 14
        jne goto16
        call set7

        goto16:
        cmp ax, 16
        jne goto18
        call set8

        goto18:
        cmp ax, 18
        jne goto20
        call set9

        goto20:
ret
set1:
   mov ax, 1
ret
set2:
   mov ax, 2
ret
set3:
   mov ax, 3
ret
set4:
   mov ax, 4
ret
set5:
   mov ax, 5
ret
set6:
   mov ax, 6
ret
set7:
   mov ax, 7
ret
set8:
   mov ax, 8
ret
set9:
   mov ax, 9
ret
;====== Variables ======;
        str1 db "Array: 1, 2, 3, 7, 5, 6, 7, 8, 9$" ;display array
        str2 db "First duplicate: $" ;display dup
        str3 db "Second duplicate: $" ;display dup
        nums dw '0', 9, 8, 7, 6, 5, 4, 3, 2, 7      ;our array; '0' prevents from skipping the first element while loop breaks
        bytes dw 18                                 ;array elements * 2
        length dw 9                                 ;array elements

;====== Temp variables ======;
        neededI dw 0
        neededJ dw 0
        savedI dw 0
        savedJ dw 0
        savedAI dw 0
        savedAJ dw 0  
