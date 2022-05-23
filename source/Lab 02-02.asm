org 100h
;CHECK IF THE WORD IS CORRECT

;====== START ======;
        mov ah, 09h
        mov dx, writeln
        int 21h

        mov ah, 0ah
        mov dx, readln
        int 21h

        mov ah, 09h
        mov dx, newLine
        int 21h

;====== SKIP IF 1 <> 3 ======;
        mov al, [readln+2]
        mov bl, [readln+4]

        cmp al, bl
        jne skip

;====== SKIP IF N < 3 ======;
        mov al, [readln+1]

        cmp al, 3
        jl skip

;====== FIND AND TEST N ======;
        mov bx, 0
        mov bl, [readln+1]
        mov al, [readln+bx+1]

        cmp al, 'A'
        jl skip

        cmp al, 'z'
        jg skip

;====== FIND AND TEST 5 ======;
        mov al, [readln+6]

        cmp al, 'A'
        jl skip

        cmp al, 'z'
        jg skip

;====== FIND AND TEST 1 ======;
        mov al, [readln+2]

        cmp al, '0'
        jl skip

        cmp al, '9'
        jg skip

;====== EVERYTHING IS OK ======;
        mov ah, 09h
        mov dx, yes
        int 21h

        mov ah, 08h
        int 21h

ret

;====== EVERYTHING IS SHIT ======;
skip:
        mov ah, 09h
        mov dx, no
        int 21h

        mov ah, 08h
        int 21h

ret

;====== VARIABLES ======;
        writeln db "Enter the text: $"
        readln db 8, 0, 8 dup ('$')
        yes db 'Yes, this word is allowed.$'
        no db 'No, this word is not allowed.$'
        newLine db 13, 10, '$'    
