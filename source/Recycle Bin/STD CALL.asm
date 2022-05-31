org 100h
        push 18
        push 2
        push 0
        call procedure1
ret

procedure1:
        push bp
        mov bp, sp

        mov bx, [bp+4]

cycle:
        mov ah, 02h
        mov dx, [arr+bx]
        add dx, '0'
        int 21h

        mov ah, 02h
        mov dx, ' '
        int 21h

        add bx, [bp+6]
        cmp bx, [bp+8]
jng cycle

        mov ah, 08h
        int 21h

        pop bp

ret 6

        arr dw 0,1,2,3,4,5,6,7,8,9    