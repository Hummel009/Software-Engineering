org 100h
;REPLACE SYMBOL IN LINE
        
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
        
        mov ah, 09h
        mov dx, newLine
        int 21h
        
;====== FIND SYMBOL ======;
again:
        mov al, '2'
        mov cx, 0
        mov ch, [str2+1]
        mov di, str2
        repne scasb
        jnz exit
        dec di
        mov byte[di], '0'
jmp again
        
;====== SHOW RESULT ======;
exit:
        mov ah, 09h
        mov dx, str4
        int 21h
        
        mov ah, 09h
        mov dx, str2
        int 21h
        
        mov ah, 08h
        int 21h
ret
        
;====== VARIABLES ======;
        str1 db "This is the string: $"
        str2 db "Abobus228$"
        str3 db "We will replace the symbol `b` with 0$"
        str4 db "Result: $"
        newLine db 13, 10, '$'
