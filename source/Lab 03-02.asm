org 100h
;find the quantity of unique elements in the array

;====== Start ======;
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

;====== First loop ======;
        mov cx, [bytes]             
cycle2:

        mov [savedI], cx

        ;====== Second loop ======;
        mov cx, [bytes]               
        cycle3:
                mov [savedJ], cx    

                mov bx, [savedI]
                mov dx, [nums+bx]
                mov [savedAI], dx    

                mov bx, [savedJ]
                mov dx, [nums+bx]
                mov [savedAJ], dx  

                mov bx, [savedI]
                cmp bx, [savedJ]
                je @F         

                mov dx, [savedAI]
                cmp dx, [savedAJ]
                jne @F        

        ;====== Break element ======;
                mov bx, [savedI]
                mov [nums+bx], 'f'  

                sub [unique], 1     

                dec cx              

        @@:
        loop cycle3

        mov cx, [savedI]        
        dec cx                     

loop cycle2

        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str2
        int 21h

;====== Add lost element ======;
        cmp [unique], 9              
        jnl @F                    

        dec [unique];                  

        @@:
        mov ax, [unique]
        call intToStrAndDisp

        mov ah, 08h
        int 21h

ret

;====== IntToStrAndDisp ======;
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
        str1 db "Array: $"
        str2 db "Unique elements: $"
        nums dw '0', 1, 2, 3, 4, 7, 6, 7, 8, 9
        bytes dw 18
        length dw 9
        unique dw 9
        newLine db 13, 10, '$'
        savedI dw 0
        savedJ dw 0
        savedAI dw 0
        savedAJ dw 0   