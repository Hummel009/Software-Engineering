org 100h

; start
  mov ah, 09h
  mov dx, str1
  int 21h

; loop: show the array
  mov cx, 2
Cycle1:
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
  jbe Cycle1
; end loop

; loop 1
  mov cx, 2
Cycle2:
  mov [savedI], cx

  ; loop 2
  mov cx, [savedI]
  Cycle3:
    mov [savedJ], cx

    mov bx, [savedI]
    mov dx, [arr+bx]
    mov [savedAI], dx

    mov bx, [savedJ]
    mov dx, [arr+bx]
    mov [savedAJ], dx

    mov dx, [savedI]

    cmp dx, [savedJ]
    je @F

    mov dx, [savedAI]

    cmp dx, [savedAJ]
    jne @F

  ; real pos
    mov ax, [savedI]
    mov bl, 2
    div bl
    mov [pos1], ax

    mov ax, [savedJ]
    mov bl, 2
    div bl
    mov [pos2], ax

  @@:
    add cx, 2

    cmp cx, [arrSize]
    jbe Cycle3
  ; end loop 2

  mov cx, [savedI]
  add cx, 2
  cmp cx, [arrSize]

  jbe Cycle2
; end loop 1

; display duplicate 1
  mov ah, 09h
  mov dx, newLine
  int 21h

  mov ah, 09h
  mov dx, str2
  int 21h

  mov ax, [pos1]
  call IntToStrAndDisp

; display duplicate 2
  mov ah, 09h
  mov dx, newLine
  int 21h

  mov ah, 09h
  mov dx, str3
  int 21h

  mov ax, [pos2]
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
  str2    db "Dup Index 1: $"
  str3    db "Dup Index 2: $"
  arr     dw '0', 59, 8, -7, 6, 5, 59, 3, 2, 1
  arrSize dw 18
  newLine db 13, 10, '$'
  pos1    dw 0
  pos2    dw 0
  savedI  dw 0
  savedJ  dw 0
  savedAI dw 0
  savedAJ dw 0
  temp    dw 0