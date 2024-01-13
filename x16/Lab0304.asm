org 100h

; start
  mov ah, 09h
  mov dx, str1
  int 21h

; loop: show the array
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
  call IntToStrAndDisp

  mov ah, 02h
  mov dx, ' '
  int 21h

  add cx, 2

  cmp cx, [arrSize]
  jbe cycle1
; end loop

  mov [big], 0

; loop: find items that are > 7
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
; end loop

  mov ah, 09h
  mov dx, newLine
  int 21h

  mov ah, 09h
  mov dx, str3
  int 21h

; loop: display the array
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
  call IntToStrAndDisp

  mov ah, 02h
  mov dx, ' '
  int 21h

  add cx, 2

  cmp cx, [arrSize]
  jbe cycle3
; end loop

; display the quantity
  mov ah, 09h
  mov dx, newLine
  int 21h

  mov ah, 09h
  mov dx, str2
  int 21h

  mov ax, [big]
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
  str1    db "Start array: $"
  str2    db "Elements bigger than 7: $"
  str3    db "New array: $"
  arr     dw '0', 9, 2, 9, -4, 7, 6, 7, 8, 9
  arrSize dw  18
  newLine db  13, 10, '$'
  big     dw 0
  temp    dw 0