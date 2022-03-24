org 100h
;do operation on symbols and display the new word

;====== START ======;
        mov ah, 09h
        mov dx, str1
        int 21h

        mov ah, 0ah
        mov dx, str2
        int 21h

        mov ah, 09h
        mov dx, newLine
        int 21h

;====== CHANGE SYMBOLS ======;
        mov al, [str2+9]
        mov bl, [str2+10]
        mov [str2+9], bl
        mov [str2+10], al

        mov al, [str2+2]
        mov bl, [str2+5]
        mov cl, [str2+8]
        sub al, bl
        add al, cl
        mov [str2+4], al

;====== DISPLAY THE STRING ======;
        mov ah, 09h
        mov dx, str2+2
        int 21h

;====== DO NOT EXIT ======;
        mov ah, 08h
        int 21h

ret

;====== VARIABLES ======;
        str1: db "Enter the text: $"
        str2: db 255 dup "$"
        newLine db 13, 10, '$'