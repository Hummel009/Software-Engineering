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

        mov bx, 2
cycle1:
        mov al, [str1+bx]
        call testIt

        add bx, 1
        mov ax, bx
        cmp al, [str1+1]
jng cycle1

        cmp [errors], 0
        je okay

        mov ah, 02h
        mov dx, '0'
        int 21h
        jmp finish

        okay:

        mov ah, 02h
        mov dx, '1'
        int 21h

        finish:

        mov ah, 08h
        int 21h
        
ret

testIt:
        cmp al, ' '
        je skip

        cmp al, '0'
        jl notNum
        cmp al, '9'
        jg notNum
        jmp skip

        notNum:
        inc [errors]
        skip:
ret
        str1 db 255 dup '$'
        errors db 0 