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

; loop: detect at least one 0- element
  mov cx, 2
cycle2:
  mov bx, cx
  mov ax, [arr+bx]

  cmp ax, 0
  jnl @F

  mov [minus], ax

@@:
  add cx, 2

  cmp cx, [arrSize]
  jbe cycle2
; end loop

; loop: detect at least one 0+ element
  mov cx, 2
cycle3:
  mov bx, cx
  mov ax, [arr+bx]

  cmp ax, 0
  jl @F

  mov [plus], ax

@@:
  add cx, 2

  cmp cx, [arrSize]
  jbe cycle3
; end loop

; loop: compare and find max 0- element
  mov cx, 2
cycle4:
  mov bx, cx
  mov ax, [arr+bx]
  mov dx, [minus]

  cmp ax, dx
  jl @F

  cmp ax, 0
  jnl @F

  mov [minus], ax

@@:
  add cx, 2

  cmp cx, [arrSize]
  jbe cycle4
; end loop

; loop: compare and find min 0+ element
  mov cx, 2
cycle5:
  mov bx, cx
  mov ax, [arr+bx]
  mov dx, [plus]

  cmp ax, dx
  jnl @F

  cmp ax, 0
  jl @F

  mov [plus], ax

@@:
  add cx, 2

  cmp cx, [arrSize]
  jbe cycle5
; end loop

; abs of the element
  mov ax, [minus]
  mov bl, -1
  idiv bl
  mov [minus], ax

; display first
  mov ah, 09h
  mov dx, newLine
  int 21h

  mov ah, 09h
  mov dx, str2
  int 21h

  mov ax, [minus]
  call IntToStrAndDisp

; display second
  mov ah, 09h
  mov dx, newLine
  int 21h

  mov ah, 09h
  mov dx, str3
  int 21h

  mov ax, [plus]
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
  str1    db "Array: $"
  str2    db "Minus elem: -$"
  str3    db "Plus elem: $"
  arr     dw 'f', -1, -2, -3, -4, 5, 6, 7, 8, 9
  arrSize dw 18
  newLine db 13, 10, '$'
  minus   dw 0
  plus    dw 0
  temp    dw 0