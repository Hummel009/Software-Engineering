org 100h
        mov ah, 09h
        mov dx, systemout
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

;===Skip if length not equals 5 or 6; choose right setter of the N-1th symbol===;

        mov al, [readln+1]
        mov bx, [readln+1]

        cmp al, 5
        je testNM1

        cmp al, 6
        je testNM1

        jmp skip

;===Setters of the 3rd and N-1th symbols===;
test3:
        mov al, [readln+4]
        mov bl, 3
        jmp testNum

testNM1:
        mov al, [readln+bx-1]

;===Skip if the N-1th symbol is not letter; go to the setter of the 3rd symbol, if it wasn't set already===;
testNum:
        cmp al, 65
        jl skip

        cmp al, 122
        jg skip

        cmp al, 91
        je skip

        cmp al, 92
        je skip

        cmp al, 93
        je skip

        cmp al, 94
        je skip

        cmp al, 95
        je skip

        cmp al, 96
        je skip

        cmp al, 96
        je skip

        cmp bl, 3
        jne test3

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

systemout: db "Enter the text: $"
readln: db 255 dup "$"
yes: db "Yes, this word is allowed.$"
no: db "No, this word isn't allowed.$"