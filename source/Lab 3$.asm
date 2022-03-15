org 100h

start:
        mov ah, 09h
        mov dx, writeln
        int 21h

        mov ah, 02h
        mov dl, 10
        int 21h

        mov ah, 02h
        mov dl, 13
        int 21h


        mov ax, nums
        mov bx, nums + 2
        cmp ax, bx

        je @F

        mov ah, 09h
        mov dx, noteq
        int 21h
@@:
        mov ah, 09h
        mov dx, eql
        int 21h

        mov ah, 08h
        int 21h

ret

writeln: db "Array: 34,  45,  56,  67,  75, 89,  67$"
eql: db "Equal$"
noteq: db "Not equal$"
nums dw  34,  45,  56,  67,  75, 89,  67