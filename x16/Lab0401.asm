org 100h

; start
  mov ah, 09h
  mov dx, str1
  int 21h

; loop
  mov cx, 2
Cycle1:
  mov bx, cx
  mov ax, [arr+bx]
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

    mov dx, [savedAI]
	
    cmp dx, [savedAJ]
    jl @F

  ; swap
    mov ax, [savedAJ]
    mov bx, [savedI]
    mov [arr+bx], ax

    mov ax, [savedAI]
    mov bx, [savedJ]
    mov [arr+bx], ax

    mov cx, [savedJ]

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

  mov ah, 09h
  mov dx, newLine
  int 21h

; show the array
  mov ah, 09h
  mov dx, str2
  int 21h

  mov cx, 2

; loop
Cycle4:
  mov bx, cx
  mov ax, [arr+bx]
  call IntToStrAndDisp

  mov ah, 02h
  mov dx, ' '
  int 21h

  add cx, 2

  cmp cx, [arrSize]
  jbe Cycle4
; end loop

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
  str2    db "Sorted array: $"
  arr     dw '0', 9, 5, 17, 6, 8, 4, 3, 2, 1
  arrSize dw 18 
  newLine db 13, 10, '$'
  neededI dw 0
  neededJ dw 0
  savedI  dw 0
  savedJ  dw 0
  savedAI dw 0
  savedAJ dw 0