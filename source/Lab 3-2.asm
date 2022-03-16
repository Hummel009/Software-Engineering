org 100h

start:
        mov ah, 09h
        mov dx, str1
        int 21h

        mov cx, [bytes]
startA1:

        mov bx, cx
        cmp [nums+bx], 0
        jnl finishA1

        add [minus], 1

        finishA1:
        dec cx

loop startA1

        mov cx, [bytes]
startA2:

        mov bx, cx
        cmp [nums+bx], 0
        jl finishA2
        mov ax, [nums+bx]

        add [plus], ax

        finishA2:
        dec cx

loop startA2

        mov ah, 02h
        mov dl, 10
        int 21h

        mov ah, 02h
        mov dl, 13
        int 21h

        mov ah, 09h
        mov dx, str2
        int 21h

        mov ax, [minus]
        aam
        add ax,3030h
        mov dl,ah
        mov dh,al
        mov ah,02
        int 21h
        mov dl,dh
        int 21h

;====== IntToStr ======;

        mov ah, 02h
        mov dl, 10
        int 21h

        mov ah, 02h
        mov dl, 13
        int 21h

        mov ah, 09h
        mov dx, str3
        int 21h

        mov ax, [plus]
        aam
        add ax,3030h
        mov dl,ah
        mov dh,al
        mov ah,02
        int 21h
        mov dl,dh
        int 21h

        mov ah, 08h
        int 21h
        
ret

;====== Variables ======;
        str1 db "Array:  -1, -2, 3, 4, 7, 6, 7, 8, 9$"
        str2 db "Found 0- elements: $"
        str3 db "The sum of 0+ elements: $"
        nums dw '0', -1, -2, 3, 4, 7, 6, 7, 8, 9
        bytes dw 18

;====== Temp variables ======;
        minus dw 0
        plus dw 0 