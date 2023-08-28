org 100h

; start
  mov ah, 09h
  mov dx, str1
  int 21h

  mov ah, 09h
  mov dx, str2
  int 21h

  mov ah, 09h
  mov dx, newLine
  int 21h

  mov ah, 09h
  mov dx, str3
  int 21h

  mov ah, 0ah
  mov dx, str5
  int 21h

  mov ah, 09h
  mov dx, newLine
  int 21h

; load converter data
  mov al, [str5+2]
  mov [saved], al

; prepare to find the first symbol
  mov al, [str5+2]
  mov di, str2
  mov cx, 0
  mov cl, 15
  mov [len], 15

; find symbol
  repne scasb

  mov bx, 0
  mov bl, [len]
  sub bl, cl
  mov [pos1], bl

; prepare to find the last symbol
  mov al, [str5+2]
  mov di, str2
  mov cx, 0
  mov cl, 15
  mov [len], 15

; find symbol
Cycle:
  repne scasb
  jnz Finish

  mov bx, 0
  mov bl, [len]
  sub bl, cl
  mov [pos2], bl
  jmp Cycle

; show the result
Finish:
  mov ah, 09h
  mov dx, str4
  int 21h

  mov ax, 0
  mov al, [pos2]
  sub al, [pos1]
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
str1     db "This is the string: $"
str2     db "abbbacddceffffe$"
str3     db "Enter the symbol: $"
str4     db "Result: $"
str5     db 255 dup ('$')
newLine  db 13, 10, '$'
saved    db 0
len      db 0
pos1     db 0
pos2     db 0