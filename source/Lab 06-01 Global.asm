format MZ
entry code_seg:entryPoint
stack 200h
;CALCULATE FORMULA WITH 8-BIT NUMBERS USING CALL WITH GLOBAL PARAMETERS

segment data_seg

;====== VARIABLES ======;
        str1 db "Enter the number A: $"
        str2 db "Enter the number B: $"
        str3 db 2, 0, 2 dup "$"
        str4 db 2, 0, 2 dup "$"
        newLine db 13, 10, '$'
        savedA db 0
        savedB db 0

segment code_seg

;====== START ======;
entryPoint:
        mov ax, data_seg
        mov ds, ax

        mov ah, 09h
        mov dx, str1
        int 21h

        mov ah, 0ah
        mov dx, str3
        int 21h

        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str2
        int 21h

        mov ah, 0ah
        mov dx, str4
        int 21h

        mov ah, 09h
        mov dx, newLine
        int 21h

;====== STR TO INT ======;
        mov al, [str3+2]
        sub al, '0'

        mov bl, [str4+2]
        sub bl, '0'

;====== PREPARING CALL ======;
        mov [savedA], al
        mov [savedB], bl

        call far calc_seg:operations

;====== SHOW ======;
        mov ah, 0
        aam

        add ax, '00'
        mov dl, ah
        mov dh, al
                
        mov ah, 02h
        int 21h
                
        mov dl, dh
        int 21h

        mov ah, 08h
        int 21h

        mov ax, 4C00h
        int 21h

segment calc_seg

;====== OPERATIONS ======;
operations:
        mov al, [savedA]

        mov bl, [savedA]
        mul bl

        mov bl, [savedB]
        div bl

        mov bl, [savedA]
        add al, bl
retf