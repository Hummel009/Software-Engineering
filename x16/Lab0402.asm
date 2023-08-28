org 100h

; start
  mov ah, 09h
  mov dx, str1
  int 21h

; loop: show arr
  mov bx, 0
Cycle1:
  mov ah, 02h
  mov dx, [arr+bx]
  add dx, '0'
  int 21h

  add bx, 2

  cmp bx, [arrSize]
  jng Cycle1
; end loop

  mov ah, 09h
  mov dx, newLine
  int 21h

  mov ah, 09h
  mov dx, str2
  int 21h

; loop: display needed items
  mov bx, 0
Cycle2:
  mov cx, 2
  mov ax, [arr+bx]
  mov dx, 0
  div cx

  cmp dx, 0
  jne @F

  add [mods], 1
  mov dx, [arr+bx]
  add dx, '0'
  mov ah, 02h
  int 21h

@@:
  add bx, 2

  cmp bx, [arrSize]
  jng Cycle2
; end loop

; display the quantity
  mov ah, 09h
  mov dx, newLine
  int 21h

  mov ah, 09h
  mov dx, str3
  int 21h

  mov ah, 02h
  mov dx, [mods]
  add dx, '0'
  int 21h

; prevent from closing
  mov ah, 08h
  int 21h

ret

; variables
  str1    db "Start array: $"
  str2    db "New array: $"
  str3    db "Quantity of items mod 2 = 0: $"
  arr     dw 1, 2, 3, 4, 5, 6, 7, 8, 9
  newLine db 13, 10, '$'
  mods    dw 0
  arrSize dw 16