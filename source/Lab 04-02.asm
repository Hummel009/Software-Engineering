org 100h
;DISPLAY THE QUANTITY OF ITEMS MOD 5 = 0 AND DISPLAY THEM AS AN ARRAY
;NO SUPPORT FOR ARRAY WITH NUMBERS 0-

;====== START ======;
        mov ah, 09h
        mov dx, str1
        int 21h

        mov cx, 2

cycle1:
        mov bx, cx
        mov ax, [nums+bx]
        call intToStrAndDisp

        mov ah, 02h
        mov dx, ' '
        int 21h

        add cx, 2
        cmp cx, [bytes]

jbe cycle1
                
        mov [big], 0

;====== COUNT ELEMENTS ======;
        mov cx, [bytes]
cycle2:
        mov [saved], cx
        mov bx, cx

        mov ecx, 5
        mov eax, 0
        mov ax, [nums+bx]
        cdq
        idiv ecx
        test edx, edx
        jnz @F 

        add [big], 1

        @@:
        mov cx, [saved]
        dec cx

loop cycle2

;====== DISPLAY THE QUANTITY ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str2
        int 21h

        mov ax, [big]
        call intToStrAndDisp
        mov ah, 09h
        mov dx, newLine
        int 21h

;====== DISPLAY THE ARRAY ======;
        mov ah, 09h
        mov dx, str3
        int 21h

        mov cx, 2
cycle3:
        mov [saved], cx
        mov bx, cx

        mov ecx, 5
        mov eax, 0
        mov ax, [nums+bx]
        cdq
        idiv ecx
        test edx, edx
        jnz @F 

        mov ax, [nums+bx]
        call intToStrAndDisp

        mov ah, 02h
        mov dx, ' '
        int 21h

        @@:
        mov cx, [saved]
        add cx, 2
        cmp cx, [bytes]

jbe cycle3

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
        str2 db "Mod 5 = 0 elements: $"
        str3 db "New array: $"
        nums dw '0', 10, 17, 65, 99, 31, 45, 88, 34, 40
        bytes dw 18
        saved dw 0
        newLine db 13, 10, '$'
        big dw 0
        temp dw 0