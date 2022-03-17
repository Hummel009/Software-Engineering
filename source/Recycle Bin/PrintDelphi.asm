org 100h

        mov ah, 09h
        
;====== Line 1 ======;
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

        mov dx, newLine
        int 21h

;====== Line 4 ======;
        mov dx, line4
        int 21h

;====== Do not exit ======;
        mov ah, 08h
        int 21h

ret

;====== Variables ======;
        line1: db "For I:= 1 to 256 do$"
        line2: db "Begin$"
        line3: db "  Inc(I);$"
        line4: db "End.$"
        newLine: db 10, 13, "$"
