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

;====== SKIP IF 3 <> 5 ======;
        mov al, [readln+4]
        mov bl, [readln+6]

        cmp al, bl
        jne skip

;====== SKIP IF N < 5 ======;
        mov al, [readln+1]

        cmp al, 5
        jl skip

;====== FIND AND TEST N-1 ======;
        mov bx, 0
        mov bl, [readln+1]
        mov al, [readln+bx]

        cmp al, 65
        jl skip

        cmp al, 122
        jg skip

;====== FIND AND TEST 3 ======;
        mov al, [readln+4]

        cmp al, 'A'
        jl skip

        cmp al, 'z'
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
        readln db 7, 0, 7 dup ('$')
        yes db 'Yes, this word is allowed.$'
        no db 'No, this word is not allowed.$'
        newLine db 13, 10, '$'    
