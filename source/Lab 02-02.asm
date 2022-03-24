org 100h
;check if the word is correct

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

        cmp al, 5
        je test5

;====== FIND N ======;
        mov bh, [readln+1]
        mov [var], bh
        add [var], 1

        mov bp, readln-2
        mov dx, 0
        mov dl, [var]
        add bp, dx

jmp testN

;====== TEST 1, 5 AND N ======;
test5:
        mov bh, [readln+6]
        jmp testLet

testN:
        mov bh, [bp]
        jmp testLet

test1:
        mov bh, [readln+2]
        jmp testNum

;====== EVERYTHING IS OK ======;
res:
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

;====== CHECK IF IS LETTER ======;
testLet:
        cmp bh, 65
        jl skip

        cmp bh, 122
        jg skip

        cmp bh, 91
        je skip

        cmp bh, 92
        je skip

        cmp bh, 93
        je skip

        cmp bh, 94
        je skip

        cmp bh, 95
        je skip

        cmp bh, 96
        je skip

        cmp bh, 96
        je skip

jmp test1

;====== CHECK IF IS NUMBER ======;
testNum:
        cmp bh, 48
        jl skip

        cmp bh, 57
        jg skip

jmp res

;====== VARIABLES ======;
        writeln: db "Enter the text: $"
        readln db 8, 0, 8 dup ('$')
        yes db 'Yes, this word is allowed.$'
        no db 'No, this word is not allowed.$'
        var db 0
        newLine db 13, 10, '$'