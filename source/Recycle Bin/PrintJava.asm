org 100h

;====== Line 1 ======;
        mov ah, 09h
        mov dx, line1
        int 21h

        mov dx, newLine
        int 21h

;====== Line 2 ======;
        mov dx, line2
        int 21h

        mov dx, newLine
        int 21h

;====== Line 3 ======;
        mov dx, line3
        int 21h

;====== Do not exit ======;
        mov ah, 08h
        int 21h

ret

;====== Variables ======;
        line1: db "for (int i = 1; i <= 256; ++i){$"
        line2: db "     i += 1;$"
        line3: db "}$"
        newLine: db 10, 13, "$"
