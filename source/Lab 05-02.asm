org 100h
;CHECK IF THE WORD IS CORRECT
        
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
        mov al, '2'
        mov cx, 0
        mov ch, [writeln2+1]
        mov di, writeln2
        repne scasb
        jnz exit
        dec di
        mov byte[di], '0'
jmp again
        
;====== SHOW RESULT ======;
exit:
        mov ah, 09h
        mov dx, writeln4
        int 21h
        
        mov ah, 09h
        mov dx, writeln2
        int 21h
        
        mov ah, 08h
        int 21h
ret
        
;====== VARIABLES ======;
        writeln1 db "This is the string: $"
        writeln2 db "Abobus228$"
        writeln3 db "We will replace the symbol `b` with 0$"
        writeln4 db "Result: $"
        newLine db 13, 10, '$'