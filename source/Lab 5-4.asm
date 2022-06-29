org 100h
;FIND LETTER POS
        
;====== START ======;
        mov ah, 09h
        mov dx, str1
        int 21h

        mov ah, 09h
        mov dx, str2
        int 21h
        
        mov ah, 09h
        mov dx, newLine
        int 21h
        
        mov ah, 09h
        mov dx, str3
        int 21h
        
        mov ah, 0ah
        mov dx, str5
        int 21h
        
        mov ah, 09h
        mov dx, newLine
        int 21h

;====== LOAD CONVERTER DATA ======;
        mov al, [str5+2]
        mov [saved], al

;====== PREPARE TO FIND SYMBOL ======;
find:
        mov al, [str5+2]
        mov di, str2
        mov cx, 0
        mov cl, 6
        mov [length], 6

;====== FIND SYMBOL ======;
again:
        repne scasb
        jnz exit

        mov bx, 0
        mov bl, [length]
        sub bl, cl
        mov [pos], bl
jmp again

;====== SHOW RESULT ======;
exit:
        mov ah, 09h
        mov dx, str4
        int 21h

        mov ax, 0
        mov al, [pos]
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
        str1 db "This is the string: $"
        str2 db "Abobus$"
        str3 db "Enter the symbol: $"
        str4 db "Result: $"
        str5 db 255 dup ('$')
        newLine db 13, 10, '$'
        saved db 0
        length db 0
        pos db 0