org 100h

        mov ah, 0ah
        mov dx, str1
        int 21h

        mov ax, 0
        mov al, [str1+2]
        sub ax, '0'
        mov [num], ax
        add [num], ax

        mov ah, 09h
        mov dx, newLine
        int 21h

        mov bx, 0
cycle1:
        cmp bx, [num]
        jge breaks1

        mov [arr+bx], 1

        add bx, 4
jmp cycle1

breaks1:

        mov bx, 2
cycle2:
        cmp bx, [num]
        jge breaks2

        mov [arr+bx], -1

        add bx, 4
jmp cycle2

breaks2:

        mov bx, 0
cycle3:
        cmp [arr+bx], 0
        jnl posit

        mov dx, 0
        mov ax, [arr+bx]
        mov cx, -1
        div cx
        mov [arr+bx], ax

        mov ah, 02h
        mov dx, '-'
        int 21h

        posit:
        mov ah, 02h
        mov dx, [arr+bx]
        add dx, '0'
        int 21h

        mov ah, 02h
        mov dx, ' '
        int 21h

        add bx, 2
        cmp bx, 18
jng cycle3

        mov ah, 08h
        int 21h
        
ret
        arr dw 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
        str1 db "$"
        num dw 0
        newLine db 13, 10, "$"   