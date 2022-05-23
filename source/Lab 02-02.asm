org 100h
;CHECK IF THE WORD IS CORRECT

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

;====== SKIP IF 1 <> 3 ======;
        mov al, [str2+2]
        mov bl, [str2+4]

        cmp al, bl
        jne skip

;====== SKIP IF N < 3 ======;
        mov al, [str2+1]

        cmp al, 3
        jl skip

;====== FIND AND TEST N ======;
        mov bx, 0
        mov bl, [str2+1]
        mov al, [str2+bx+1]

        cmp al, 'A'
        jl skip

        cmp al, 'z'
        jg skip

;====== FIND AND TEST 5 ======;
        mov al, [str2+6]

        cmp al, 'A'
        jl skip

        cmp al, 'z'
        jg skip

;====== FIND AND TEST 1 ======;
        mov al, [str2+2]

        cmp al, '0'
        jl skip

        cmp al, '9'
        jg skip

;====== EVERYTHING IS OK ======;
        mov ah, 09h
        mov dx, str3
        int 21h

        mov ah, 08h
        int 21h

ret

;====== EVERYTHING IS SHIT ======;
skip:
        mov ah, 09h
        mov dx, str4
        int 21h

        mov ah, 08h
        int 21h

ret

;====== VARIABLES ======;
        str1 db "Enter the text: $"
        str2 db 8, 0, 8 dup ('$')
        str3 db 'Yes, this word is allowed.$'
        str4 db 'No, this word is not allowed.$'
        newLine db 13, 10, '$'
