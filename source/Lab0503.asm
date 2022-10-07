org 100h
;REPLACE LETTER SIZE IN LINE
        
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

        cmp al, 'A'
        jle intoSmallLetter

        cmp al, 'a'
        jge intoBigLetter

;====== SET CONVERTER DATA ======;
intoBigLetter:
        mov al, [str5+2]
        sub al, 32
        mov [saved], al
        jmp find

intoSmallLetter:
        mov al, [str5+2]
        add al, 32
        mov [saved], al
        jmp find

;====== PREPARE TO FIND SYMBOL ======;
find:
        mov al, [str5+2]
        mov di, str2
        mov cx, 0
        mov cl, 6

;====== FIND SYMBOL ======;
again:
        repne scasb
        jnz exit

        dec di
        mov bl, [saved]
        mov byte[di], bl
jmp again
        
;====== SHOW RESULT ======;
exit:
        mov ah, 09h
        mov dx, str4
        int 21h
        
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str2
        int 21h
        
        mov ah, 08h
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