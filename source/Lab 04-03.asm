org 100h
;display the quantity of el mod 5 = 0 elements and display them

;====== Start ======;
        mov ah, 09h
        mov dx, str1
        int 21h
        mov [big], 0

;====== First loop: count 0- ======;
        mov cx, [bytes]
startA1:
        mov [saved], cx
        mov bx, cx

        mov ecx, 5
        mov eax, 0
        mov ax, [nums+bx]
        cdq
        idiv ecx
        test edx, edx
        jnz @F ;if mod <>0, then skip increment

        add [big], 1

        @@:
        mov cx, [saved]
        dec cx

loop startA1

;====== Display 1st ======;
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

;====== Display arr ======;
        mov ah, 09h
        mov dx, str3
        int 21h

        mov cx, 2
cycle:
        mov [saved], cx
        mov bx, cx

        mov ecx, 5
        mov eax, 0
        mov ax, [nums+bx]
        cdq
        idiv ecx
        test edx, edx
        jnz @F ;if mod <>0, then skip disp

        mov ax, [nums+bx]

        call intToStrAndDisp

        mov ah, 02h
        mov dx, ' '
        int 21h

        @@:
        mov cx, [saved]
        add cx, 2
        cmp cx, [bytes]

jbe cycle

;====== Do not exit ======;
        mov ah, 08h
        int 21h

ret

;====== IntToStrAndDisp ======;
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

;====== Variables ======;
        str1 db "Array: 10, 17, 65, 99, 31, 45, 88, 34, 12$"
        str2 db "Found (mod 5 = 0)  elements: $"
        str3 db "New array: $"
        nums dw '0', 10, 17, 65, 99, 31, 45, 88, 34, 40
        bytes dw 18
        saved dw 0
        newLine db 13, 10, '$'
        big dw 0