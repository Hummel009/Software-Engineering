org 100h

start:
        mov ah, 09h
        mov dx, str1
        int 21h

        mov ah, 02h
        mov dl, 10
        int 21h

        mov ah, 02h
        mov dl, 13
        int 21h

        mov ah, 09h
        mov dx, str2
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

                mov bx, [savedI]
                mov [nums+bx], 'f'    ;broke element to remove it from potential duplicates

                sub [dups], 1         ;decrement the quantity

                dec cx                ;every loop does -1, but we need -2: every element is 2 bytes

        finishA1:
        loop startA2

        mov cx, [savedI]              ;load saved counter instead of corrupted one from A2
        dec cx                        ;every loop does -1, but we need -2: every element is 2 bytes

loop startA1

        cmp [dups], 9                 ;first two duplicates have +1, but need +2, so one is lost
        jnl skip                      ;...but zero needs zero

        dec [dups];                   ;decrement one lost duplicate, if not zero

skip:

;====== IntToStr ======;
        mov ax, [dups]
        aam
        add ax, 3030h
        mov dl, ah
        mov dh, al
		
        mov ah, 02h
        int 21h
		
        mov dl, dh
        int 21h

        mov ah, 08h
        int 21h
        
ret

;====== Variables ======;
        str1 db "Array: 1, 2, 3, 4, 7, 6, 7, 8, 9$" ;display array
        str2 db "Found unique elements: $"          ;display the quantity of unique elements
        nums dw '0', 1, 2, 3, 4, 7, 6, 7, 8, 9      ;our array; '0' prevents from skipping the first element while loop breaks
        bytes dw 18                                 ;array elements * 2
        length dw 9                                 ;array elements
        dups dw 9

;====== Temp variables ======;
        savedI dw 0
        savedJ dw 0
        savedAI dw 0
        savedAJ dw 0  
