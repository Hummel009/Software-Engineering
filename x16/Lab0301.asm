org 100h

; start
  mov ah, 09h
  mov dx, str1
  int 21h

; show arr
  mov bx, 0

Cycle1:
  mov ah, 02h
  mov dx, [arr+bx]
  add dx, '0'
  int 21h

  add bx, 2

  cmp bx, [arrSize]
  jng Cycle1

  mov ah, 09h
  mov dx, newLine
  int 21h

  mov ah, 09h
  mov dx, str2
  int 21h

; display needed items
  mov bx, 0

Cycle2:
  mov cx, 4
  mov ax, bx
  mov dx, 0
  div cx

  cmp dx, 0
  jne Skip

  mov ax, [arr+bx]
  add [mods], ax
  mov dx, [arr+bx]
  add dx, '0'
  mov ah, 02h
  int 21h

Skip:
  add bx, 2

  cmp bx, [arrSize]
  jng Cycle2

; display quantity
  mov ah, 09h
  mov dx, newLine
  int 21h

  mov ah, 09h
  mov dx, str3
  int 21h

  mov ax, [mods]
  call IntToStrAndDisp

; prevent from closing
  mov ah, 08h
  int 21h

ret

; convert
IntToStrAndDisp:
  aam
  add ax, '00'
  mov dl, ah
  mov dh, al

  mov ah, 02h
  int 21h

  mov dl, dh
  int 21h

ret

; variables
str1     db "Start array: $"
str2     db "New array: $"
str3     db "The sum of items mod 2 = 0: $"
arr      dw 1, 2, 3, 4, 5, 6, 7, 8, 9
newLine  db 13, 10, '$'
mods     dw 0
arrSize  dw 16