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
        mov di, str1+2
        mov al, ' '
        mov cl, [str1+1]

searcht:
        repne scasb
        jnz exit

        mov bx, 0
        mov bl, [str1+1]
        sub bl, cl
        sub [str1+bx+2], 'a'-'A'

jmp searcht
exit:
        mov ah, 09h
        mov dx, str1+2
        int 21h

        mov ah, 08h
        int 21h
        
ret
        str1 db 255 dup '$'      