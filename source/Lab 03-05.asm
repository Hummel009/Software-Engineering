org 100h
;FIND THE BIGGEST 0- ELEMENT AND THE LEAST 0+ ELEMENT

;====== START ======;
        mov ah, 09h
        mov dx, str1
        int 21h

        mov cx, 2

cycle1:
        mov bx, cx
        mov ax, [nums+bx]
        mov [temp], ax

        cmp ax, 0
        jnl @F

        mov ah, 02h
        mov dx, '-'
        int 21h

        mov ax, [temp]
        mov bl, -1
        idiv bl

        @@:
        call intToStrAndDisp

        mov ah, 02h
        mov dx, ' '
        int 21h

        add cx, 2
        cmp cx, [bytes]

jbe cycle1

;====== LET IT BE THE START 0- ELEMENT =====;
        mov cx, [bytes]
cycle2:

        mov bx, cx
        mov ax, [nums+bx]
        cmp ax, 0
        jnl @F      

        mov [minus], ax

        @@:
        dec cx

loop cycle2

;====== LET IT BE THE START 0+ ELEMENT =====;
        mov cx, [bytes]
cycle3:

        mov bx, cx
        mov ax, [nums+bx]
        cmp ax, 0
        jl @F      

        mov [plus], ax

        @@:
        dec cx

loop cycle3

;====== COMPARE AND FIND MAX 0- ELEMENT =====;
        mov cx, [bytes]
cycle4:

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

loop cycle4

;====== COMPARE AND FIND MIN 0+ ELEMENT =====;
        mov cx, [bytes]
cycle5:

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

loop cycle5

;====== ABS OF THE ELEMENT =====;
        mov ax, [minus]
        mov bl, -1
        idiv bl
        mov [minus], ax

;====== DISPLAY 1 ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str2
        int 21h

        mov ax, [minus]
        call intToStrAndDisp

;====== DISPLAY 2 ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str3
        int 21h

        mov ax, [plus]
        call intToStrAndDisp

;====== DO NOT EXIT ======;
        mov ah, 08h
        int 21h
        
ret

;====== CONVERT ======;
intToStrAndDisp:
        aam

        add ax, '00'
        mov dl, ah
        mov dh, al

        mov ah, 02h
        int 21h

        mov dl, dh
        int 21h
ret

;====== VARIABLES ======;
        str1 db "Array: $"
        str2 db "Minus elem: -$"
        str3 db "Plus elem: $"
        nums dw 'f', -1, -2, -3, -4, 5, 6, 7, 8, 9
        bytes dw 18
        newLine db 13, 10, '$'
        minus dw 0
        plus dw 0
        temp dw 0