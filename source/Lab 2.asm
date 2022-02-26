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

;===Скип, если символ 3 не равен символу 5===;

        mov al, [readln+4]
        mov bl, [readln+6]

        cmp al, bl
        jne skip

;===Скип, если букв не 5 и не 6===;

        mov al, [readln+1]

        cmp al, 5
        je test4

        cmp al, 6
        je test5

        jmp skip

;===Выбираем, какой символ проверяем на небытие буквой===;
test3:
        mov al, [readln+4]
        mov bl, 3
        jmp testNum

test4:
        mov al, [readln+5]
        jmp testNum

test5:
        mov al, [readln+6]
        jmp testNum

;===Скип, если символ не является буквой===;
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

;===Сообщение, что подходит===;

        mov ah, 09h
        mov dx, yes
        int 21h

        mov ah, 08h
        int 21h

ret

;===Сообщение, что не подходит===;

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