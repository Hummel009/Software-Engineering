org 100h
;FIND THE QUANTITY OF 7+ ELEMENTS AND REPLACE THEM WITH 7

;====== START ======;
        mov ah, 09h
        mov dx, str1
        int 21h

        mov cx, 2

cycle1:
        mov bx, cx
        mov ax, [arr+bx]
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
        cmp cx, [arrSize]

jbe cycle1
  
        mov [big], 0

;====== FIND ELEMENTS BIGGER THAN SEVEN ======;
        mov cx, 2
cycle2:

        mov bx, cx
        cmp [arr+bx], 7
        jng @F 

        add [big], 1
        mov [arr+bx], 7

        @@:
        add cx, 2
        cmp cx, [arrSize]

jbe cycle2

;====== DISPLAY THE ARRAY ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str3
        int 21h

        mov cx, 2
cycle3:
        mov bx, cx
        mov ax, [arr+bx]
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
        cmp cx, [arrSize]

jbe cycle3

;====== DISPLAY THE QUANTITY ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str2
        int 21h

        mov ax, [big]
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
        str1 db "Start array: $"
        str2 db "Elements bigger than 7: $"
        str3 db "New array: $"
        arr dw '0', 9, 2, 9, -4, 7, 6, 7, 8, 9
        arrSize dw 18
        newLine db 13, 10, '$'
        big dw 0   
        temp dw 0