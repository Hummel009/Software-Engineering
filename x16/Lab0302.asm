org 100h

; start
  mov ah, 09h
  mov dx, str1
  int 21h

  mov cx, 0

; loop: show the array
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
  jng Cycle1
; end loop

  mov cx, 0

; loop 1
Cycle2:
  mov [savedI], cx
  mov [broken], 0

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

  ; destroy element
    mov bx, [savedJ]
    mov [arr+bx], 'ff'

    mov [broken], 1

  @@:
    add cx, 2

    cmp cx, [arrSize]
    jbe Cycle3
  ; end loop 2

  mov ax, [broken]

  cmp ax, 0
  je @F

  mov bx, [savedI]
  mov [arr+bx], 'ff'

@@:
  mov cx, [savedI]
  add cx, 2

  cmp cx, [arrSize]
  jng Cycle2
; end loop 1

; calculate the quantity of unique elements
  mov cx, 0

; loop
Cycle4:
  mov bx, cx
  mov ax, [arr+bx]

  cmp ax, 'ff'
  jne @F

  sub [unique], 1

@@:
  add cx, 2

  cmp cx, [arrSize]
  jng Cycle4
; end loop

  mov ah, 09h
  mov dx, newLine
  int 21h

  mov ah, 09h
  mov dx, str2
  int 21h

  mov cx, 0

; loop
Cycle5:
  mov bx, cx
  mov ax, [arr+bx]
  mov [temp], ax

  cmp ax, 'ff'
  je Skip

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

Skip:
  add cx, 2

  cmp cx, [arrSize]
  jng Cycle5
; end loop


; display the quantity
  mov ah, 09h
  mov dx, newLine
  int 21h

  mov ah, 09h
  mov dx, str3
  int 21h

  mov ax, [unique]
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
  str1    db "Start array: $"
  str2    db "No duplicat: $"
  str3    db "Unique elements: $"
  arr     dw 2, 2, -3, 5, 7, 4, 7, 2, 9
  arrSize dw 16
  newLine db 13, 10, '$'
  unique  dw 9
  savedI  dw 0
  savedJ  dw 0
  savedAI dw 0
  savedAJ dw 0
  temp    dw 0
  broken  dw 0 