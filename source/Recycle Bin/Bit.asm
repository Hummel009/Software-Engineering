org 100h

        mov bx, 0
cycle1:

        and [arr+bx], 11000000b
        cmp [arr+bx], 11000000b
        jne skip

        inc [aboba]

        skip:
        add bx, 2
        cmp bx, 18
jng cycle1

        mov ah, 02h
        mov dx, [aboba]
        add dx, '0'
        int 21h

        mov ah, 08h
        int 21h
        
ret
        arr dw 0, 1, 2, 3, 4, 5, 6, 7, 8, 195
        aboba dw 0
                       