org 100h

EntryPoint:
        mov bx, 255
        call PrintHex

        mov ah, $09
        mov dx, strCRLF
        int 21h

        mov bx, 14122
        call PrintHex

        mov ax, $0C08
        int 21h
        test al, al
        jnz @F
        mov ah, $08
        int 21h
@@:
        ret

strCRLF db 13, 10, '$'
; Prints hex representation of a number.
;
; Input:
;   BX - Number to be printed
; Output:
;   None
PrintHex:
        push ax
        push cx
        push dx

        mov cx, 4
.PrintLoop:
        rol bx, 4
        mov ax, bx
        and ax, $000F

        cmp al, 10
        sbb al, $69
        das

        mov ah, $02
        mov dl, al
        int 21h

        loop .PrintLoop

        pop dx
        pop cx
        pop ax
        ret