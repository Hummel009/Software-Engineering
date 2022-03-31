org 100h
;COUNT SYMBOL IN LINE
        
;====== START ======;
        mov ah, 09h
        mov dx, writeln1
        int 21h
        
        mov ah, 09h
        mov dx, writeln2
        int 21h
        
        mov ah, 09h
        mov dx, newLine
        int 21h
        
        mov ah, 09h
        mov dx, writeln3
        int 21h
        
        mov ah, 09h
        mov dx, newLine
        int 21h
        
;====== FIND SYMBOL ======;
again:
        mov al, 'm'
        mov cx, 0
        mov ch, [writeln2+1]
        mov di, writeln2
        repne scasb
        jnz exit
        
        dec di
        add [save], 1
        mov byte[di], '0'
jmp again
        
;====== SHOW RESULT ======;
exit:
        mov ah, 09h
        mov dx, writeln4
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
        writeln1 db "This is the string: $"
        writeln2 db "Amomus1488$"
        writeln3 db "We will count the symbol `m`$"
        writeln4 db "Result: $"
        newLine db 13, 10, '$'
        save dw -4
