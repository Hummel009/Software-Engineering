org 100h
;COUNT SYMBOL IN LINE
        
;====== START ======;
        mov ah, 09h
        mov dx, writeln1
        int 21h
        
        mov ah, 09h
        mov dx, newLine
        int 21h
        
        mov ah, 09h
        mov dx, writeln2
        int 21h

        mov ah, 0ah
        mov dx, readln
        int 21h
        
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov al, '3'
        mov di, readln+2
        mov cx, 0
        mov cl, [readln+1]

;====== FIND SYMBOL ======;
again:
        repne scasb
        jnz exit
        
        dec di
        mov byte[di], '0'
        add [save], 1
jmp again
        
;====== SHOW RESULT ======;
exit:
        mov ah, 09h
        mov dx, writeln3
        int 21h
        
        mov ax, [save]
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
        writeln1 db "We will count the symbol `3`$"
        writeln2 db "Enter the string: $"
        writeln3 db "Result: $"
        readln db 255 dup ('$')
        newLine db 13, 10, '$'
        save dw 0