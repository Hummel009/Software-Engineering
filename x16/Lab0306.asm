org 100h

; start
  mov ah, 09h
  mov dx, str1
  int 21h

; display 1st
  mov cx, 2

Cycle0:
  mov bx, cx
  mov ax, [arr1+bx]
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
  jbe Cycle0

  mov ah, 09h
  mov dx, newLine
  int 21h

  mov ah, 09h
  mov dx, str2
  int 21h

; display 2nd
  mov cx, 2

Cycle1:
  mov bx, cx
  mov ax, [arr2+bx]
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
  jbe Cycle1

; first loop
  mov cx, 2
Cycle2:

  mov [savedI], cx

  ; second loop
  mov cx, 2

  Cycle3:
    mov [savedJ], cx    

    mov bx, [savedI]
    mov dx, [arr1+bx]
    mov [savedAI], dx    

    mov bx, [savedJ]
    mov dx, [arr2+bx]
    mov [savedAJ], dx

    mov dx, [savedAI]
	
    cmp dx, [savedAJ]
    jne @F

  ; save duplicate
    mov bx, [savedDupPos]
    mov dx, [savedAJ]
    mov [arr3+bx], dx

    add [savedDupPos], 2

  @@:
    add cx, 2
	
    cmp cx, [arrSize]
    jbe Cycle3

  mov cx, [savedI]
  add cx, 2

  cmp cx, [arrSize]
  jbe Cycle2

  mov ah, 09h
  mov dx, newLine
  int 21h

  mov ah, 09h
  mov dx, str3
  int 21h

  mov cx, 2

Cycle5:
  mov bx, cx
  mov ax, [arr3+bx]
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

  cmp cx, [savedDupPos]
  jb Cycle5


; display the quantity
  mov ah, 09h
  mov dx, newLine
  int 21h

  mov ah, 09h
  mov dx, str4
  int 21h

  mov ax, [savedDupPos]
  sub ax, 2
  mov bl, 2
  idiv bl

  call IntToStrAndDisp

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
str1         db "1st array: $"
str2         db "2nd array: $"
str3         db "Duplicates: $"
str4         db "Duplicates quantity: $"
arr1         dw '0', 1, 2, 3, 4, 5, 6, 7, 8, 9
arr2         dw '0', -1, -2, 3, 4, -5, 6, 7, 8, 9
arr3         dw '0', 0, 0, 0, 0, 0, 0, 0, 0, 0
arrSize      dw 18
newLine      db 13, 10, '$'
savedI       dw 0
savedJ       dw 0
savedAI      dw 0
savedAJ      dw 0 
temp         dw 0
savedDupPos  dw 2 