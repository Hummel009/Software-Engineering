org 100h

start:
        mov ah, 09h
        mov dx, str1
        int 21h

;====== Save random minus ======;
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


;====== Save random plus ======;
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

;====== Save max minus ======;
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

;====== Display 1st ======;

        mov ax, [minus]
        mov bl, -1
        idiv bl
        mov [minus], ax

        call newLine

        mov ah, 09h
        mov dx, str2
        int 21h

        mov ax, [minus]
        call intToStrAndDisp

;====== Display 2nd ======;

        call newLine

        mov ah, 09h
        mov dx, str3
        int 21h

        mov ax, [plus]
        call intToStrAndDisp

        mov ah, 08h
        int 21h
        
ret

newLine:
        mov ah, 02h
        mov dl, 10
        int 21h

        mov ah, 02h
        mov dl, 13
        int 21h
ret

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
        nums dw 'f', -1, -2, -3, -4, 5, 6, 7, 8, 1
        bytes dw 18

;====== Temp variables ======;
        minus dw 0
        plus dw 0   