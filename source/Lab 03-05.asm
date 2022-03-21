org 100h
;find the biggest 0- element and the least 0+ element

;====== Start ======;
        mov ah, 09h
        mov dx, str1
        int 21h

;====== Save random 0- =====;
        mov cx, [bytes]
startA1:

        mov bx, cx
        mov ax, [nums+bx]
        cmp ax, 0
        jnl @F        ;if <0, then skip saving

        mov [minus], ax

        @@:
        dec cx

loop startA1

;====== Save random 0+ =====;
        mov cx, [bytes]
startA2:

        mov bx, cx
        mov ax, [nums+bx]
        cmp ax, 0
        jl @F        ;if <0, then skip saving

        mov [plus], ax

        @@:
        dec cx

loop startA2

;====== Save max minus =====;
        mov cx, [bytes]
startA3:

        mov bx, cx
        mov ax, [nums+bx]
        mov dx, [minus]

        cmp ax, dx
        jl @F
        cmp ax, 0
        jnl @F

        mov [minus], ax

        @@:
        dec cx

loop startA3

;====== Save min plus ======;
        mov cx, [bytes]
startA4:

        mov bx, cx
        mov ax, [nums+bx]
        mov dx, [plus]
        cmp ax, dx
        jnl @F
        cmp ax, 0
        jl @F

        mov [plus], ax

        @@:
        dec cx

loop startA4

;====== We can't display 0-, so we will display 0+ with the symbol "-" ======;
        mov ax, [minus]
        mov bl, -1
        idiv bl
        mov [minus], ax

;====== Display 1st ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str2
        int 21h

        mov ax, [minus]
        call intToStrAndDisp

;====== Display 2nd ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str3
        int 21h

        mov ax, [plus]
        call intToStrAndDisp

;====== Do not exit ======;
        mov ah, 08h
        int 21h
        
ret

;====== IntToStrAndDisp ======;
intToStrAndDisp:
        aam

        add ax, 3030h
        mov dl, ah
        mov dh, al
                
        mov ah, 02h
        int 21h
                
        mov dl, dh
        int 21h
ret

;====== Variables ======;
        str1 db "Array:  -1, -2, -3, -4, 5, 6, 7, 8, 9$"
        str2 db "Minus elem: -$"
        str3 db "Plus elem: $"
        nums dw 'f', -1, -2, -3, -4, 5, 6, 7, 8, 9
        bytes dw 18
        newLine db 13, 10, '$'
        minus dw 0
        plus dw 0   
