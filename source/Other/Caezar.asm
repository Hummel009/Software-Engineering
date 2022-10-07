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

        mov bx, 1
cycle:
        cmp [str1+bx+1], ' '
        je skip

        cmp [str1+bx+1], 'X'
        jge decthis

        add [str1+bx+1], 3
        jmp skip

        decthis:

        sub [str1+bx+1], 23

        skip:
        add bx, 1
        mov ax, 0
        mov al, [str1+1]
        cmp bx, ax
jng cycle

        mov ah, 09h
        mov dx, str1+2
        int 21h

        mov ah, 08h
        int 21h
        
ret
        str1 db 255 dup ("$")    