org 100h

start:
        mov ah, 09h
        mov dx, writeln
        int 21h

        mov ah, 0ah
        mov dx, readln
        int 21h     

        mov ah, 02h
        mov dl, 10
        int 21h

        mov ah, 02h
        mov dl, 13
        int 21h

;===Skip if 3rd symbol not equals 5th symbol===;

        mov al, [readln+4]
        mov bl, [readln+6]

        cmp al, bl
        jne skip

;===Skip if length lesser then 5===;

        mov al, [readln+1]

        cmp al, 5
        jl skip

;===Find symbol N-1===;

        mov bh, [readln+1]
        mov [var], bh

        mov bp, readln-2
        mov dx, 0
        mov dl, [var]
        add bp, dx

        mov bh, [bp]
        jmp testNum

set3:
        mov bh, [readln+4]
        mov bl, 3

;===Skip if the N-1th symbol is not letter; go to the setter of the 3rd symbol, if it wasn't set already===;

testNum:
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

        cmp bl, 3
        jne set3

;===Everything is ok===;

        mov ah, 09h
        mov dx, yes
        int 21h

        mov ah, 08h
        int 21h

ret

;===Everything is shit===;

skip:
        mov ah, 09h
        mov dx, no
        int 21h

        mov ah, 08h
        int 21h

ret

writeln: db "Enter the text: $"
readln db 7, 0, 7 dup ('$')
yes db 'Yes, this word is allowed.$'
no db 'No, this word is not allowed.$'
var db 0    