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

;====== SKIP IF 3 <> 5 ======;
        mov al, [str2+4]
        mov bl, [str2+6]

        cmp al, bl
        jne skip

;====== SKIP IF N < 5 ======;
        mov al, [str2+1]

        cmp al, 5
        jl skip

;====== FIND AND TEST N-1 ======;
        mov bx, 0
        mov bl, [str2+1]
        mov al, [str2+bx]

        cmp al, 65
        jl skip

        cmp al, 122
        jg skip

;====== FIND AND TEST 3 ======;
        mov al, [str2+4]

        cmp al, 'A'
        jl skip

        cmp al, 'z'
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
        str2 db 7, 0, 7 dup ('$')
        str3 db 'Yes, this word is allowed.$'
        str4 db 'No, this word is not allowed.$'
        newLine db 13, 10, '$'    
