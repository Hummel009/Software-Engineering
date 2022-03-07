org 100h

mov ah, 09h
mov dx, aboba1
int 21h

mov ah, 02h
mov dx, 10
int 21h

mov ah, 02h
mov dx, 13
int 21h

mov ah, 09h
mov dx, aboba2
int 21h

mov ah, 02h
mov dx, 10
int 21h

mov ah, 02h
mov dx, 13
int 21h

mov ah, 09h
mov dx, aboba3
int 21h

mov ah, 02h
mov dx, 10
int 21h

mov ah, 02h
mov dx, 13
int 21h

mov ah, 08h
int 21h

ret

aboba1: db "for (int i = 1; i<=256; ++i){$"
aboba2: db "i+=1;$"
aboba3: db "}$"