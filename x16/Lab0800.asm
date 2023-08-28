org 100h

; load mode
  mov ax, 0013h
  int 10h

  push $A000
  pop es

  mov cx, 320 * 200
  mov di, 0
  mov si, 320

; loop
DrawLoop:
  sub ax, 160 ; move screen up/down
  sub dx, 160 ; move screen left/right

  mov al, 60h ; fill screen with color

  mov ax, di  ; smth random

  xor ax, dx  ; smth random
  imul ax, ax ; smth random

; add here xor,and,or,mov,imul etc with ax, dx, di and si to get arts

  stosb
  loop DrawLoop
; end loop

  mov ah, 08h
  int 21h

ret