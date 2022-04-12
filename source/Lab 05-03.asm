org 100h
;REPLACE LETTER SIZE IN LINE
        
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
        
        mov ah, 0ah
        mov dx, readln
        int 21h
        
        mov ah, 09h
        mov dx, newLine
        int 21h

;====== LOAD CONVERTER DATA ======;
        mov al, [readln+2]

        cmp al, 'A'
        jle intoSmallLetter

        cmp al, 'a'
        jge intoBigLetter

;====== SET CONVERTER DATA ======;
intoBigLetter:
        mov al, [readln+2]
        sub al, 32
        mov [saved], al
        jmp find

intoSmallLetter:
        mov al, [readln+2]
        add al, 32
        mov [saved], al
        jmp find

;====== PREPARE TO FIND SYMBOL ======;
find:
        mov al, [readln+2]
        mov di, writeln2
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
        mov dx, writeln4
        int 21h
        
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, writeln2
        int 21h
        
        mov ah, 08h
        int 21h
ret
        
;====== VARIABLES ======;
        writeln1 db "This is the string: $"
        writeln2 db "Abobus$"
        writeln3 db "Enter the symbol: $"
        writeln4 db "Result: $"
        newLine db 13, 10, '$'
        readln db 255 dup ('$')
        saved db 0 