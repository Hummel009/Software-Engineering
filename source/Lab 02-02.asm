org 100h
;check if the word is correct

;====== Start ======;
        mov ah, 09h
        mov dx, writeln
        int 21h

        mov ah, 0ah
        mov dx, readln
        int 21h

        mov ah, 09h
        mov dx, newLine
        int 21h

;====== Skip if 1rd symbol not equals 3th symbol ======;
        mov al, [readln+2]
        mov bl, [readln+4]

        cmp al, bl
        jne skip

;====== Skip if length lesser then 3 ======;
        mov al, [readln+1]

        cmp al, 3
        jl skip

        cmp al, 5
        je test5

;====== Find symbol N ======;
        mov bh, [readln+1]
        mov [var], bh
        add [var], 1

        mov bp, readln-2
        mov dx, 0
        mov dl, [var]
        add bp, dx

jmp testN

;====== Test 1 and N ======;
test5:
        mov bh, [readln+6]
        jmp testLet

testN:
        mov bh, [bp]
        jmp testLet

test1:
        mov bh, [readln+2]
        jmp testNum

;====== Everything is ok ======;
res:
        mov ah, 09h
        mov dx, yes
        int 21h

        mov ah, 08h
        int 21h

ret

;====== Everything is shit ======;
skip:
        mov ah, 09h
        mov dx, no
        int 21h

        mov ah, 08h
        int 21h

ret

;====== Our conditions for symbol ======;
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

;====== Our conditions for symbol ======;
testNum:
        cmp bh, 48
        jl skip

        cmp bh, 57
        jg skip

jmp res

;====== Variables ======;
        writeln: db "Enter the text: $"
        readln db 8, 0, 8 dup ('$')
        yes db 'Yes, this word is allowed.$'
        no db 'No, this word is not allowed.$'
        var db 0
        newLine db 13, 10, '$'