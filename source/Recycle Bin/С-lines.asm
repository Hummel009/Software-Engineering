org 100h
        mov ah, 0ah
        mov dx, str1
        int 21h

        mov ah, 02h
        mov dx, 13
        int 21h

        mov ah, 02h
        mov dx, 10
        int 21h

        mov ah, 0ah
        mov dx, str2
        int 21h

        mov ah, 02h
        mov dx, 13
        int 21h

        mov ah, 02h
        mov dx, 10
        int 21h

        mov al, [str1+1]
        mov ah, [str2+1]
        cmp al, ah
        jne endNotOk

        mov bx, 2
cycle1:
        mov al, [str1+bx]
        mov ah, [str2+bx]
        cmp al, ah
        jne endNotOk

        add bx, 1
        mov ax, bx
        cmp al, [str1+1]
jng cycle1

        endOk:

        mov ah, 02h
        mov dx, '1'
        int 21h

        jmp endt

        endNotOk:

        mov ah, 02h
        mov dx, '0'
        int 21h

        endt:

        mov ah, 08h
        int 21h
        
ret
        str1 db 255 dup ('$')
        str2 db 255 dup ('$')   