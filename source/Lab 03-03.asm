org 100h
;FIND THE POSITIONS OF TWO DUPLICATES IN ARRAY

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
                jne @F        

        ;====== FIND THE REAL POS ======;
                mov ax, [savedI]
                mov bl, 2
                div bl
                mov [pos1], ax

                mov ax, [savedJ]
                mov bl, 2
                div bl
                mov [pos2], ax

                @@:
                add cx, 2
                cmp cx, [bytes]
        jbe cycle3

        mov cx, [savedI]
        add cx, 2
        cmp cx, [bytes]

jbe cycle2

;====== DISPLAY DUPLICATE 1 ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str2
        int 21h

        mov ax, [pos1]
        call intToStrAndDisp

;====== DISPLAY DUPLICATE 2 ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str3
        int 21h

        mov ax, [pos2]
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
        str1 db "Array: $"
        str2 db "Dup Index 1: $" 
        str3 db "Dup Index 2: $" 
        nums dw '0', 59, 8, -7, 6, 5, 59, 3, 2, 1
        bytes dw 18                                
        length dw 9                                
        newLine db 13, 10, '$'
        pos1 dw 0
        pos2 dw 0
        savedI dw 0
        savedJ dw 0
        savedAI dw 0
        savedAJ dw 0
        temp dw 0 