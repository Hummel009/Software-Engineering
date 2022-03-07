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

mov ah, 09h
mov dx, aboba4
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

aboba1: db "for i:= 1 to 256 do$"
aboba2: db "Begin$"
aboba3: db "Inc(I);$"
aboba4: db "End.$"