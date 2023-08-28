org 100h

; start
  mov ah, 09h
  mov dx, str1
  int 21h

  mov ah, 09h
  mov dx, newLine
  int 21h

  mov ah, 09h
  mov dx, str2
  int 21h

  mov ah, 0ah
  mov dx, str4
  int 21h

  mov ah, 09h
  mov dx, newLine
  int 21h

  mov al, '3'
  mov di, str4+2
  mov cx, 0
  mov cl, [str4+1]

; loop: find symbol
Cycle:
  repne scasb
  jnz Finish

  add [save], 1
  jmp Cycle
; end loop

; show the result
Finish:
  mov ah, 09h
  mov dx, str3
  int 21h

  mov ax, [save]
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
  str1    db "We will count the symbol `3`$"
  str2    db "Enter the string: $"
  str3    db "Result: $"
  str4    db 255 dup ('$')
  newLine db 13, 10, '$'
  save    dw 0    