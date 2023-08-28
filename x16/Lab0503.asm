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

  cmp al, 'A'
  jle ToSmallLetter

  cmp al, 'a'
  jge ToBigLetter

; set converter data
ToBigLetter:
  mov al, [str5+2]
  sub al, 32
  mov [saved], al
  jmp Find

ToSmallLetter:
  mov al, [str5+2]
  add al, 32
  mov [saved], al
  jmp Find

; prepare to find symbol
Find:
  mov al, [str5+2]
  mov di, str2
  mov cx, 0
  mov cl, 6

; find symbol
Cycle:
  repne scasb
  jnz Finish

  dec di
  mov bl, [saved]
  mov byte[di], bl
  jmp Cycle

; show the result
Finish:
  mov ah, 09h
  mov dx, str4
  int 21h

  mov ah, 09h
  mov dx, newLine
  int 21h

  mov ah, 09h
  mov dx, str2
  int 21h

  mov ah, 08h
  int 21h

ret

; variables
str1     db "This is the string: $"
str2     db "Abobus$"
str3     db "Enter the symbol: $"
str4     db "Result: $"
str5     db 255 dup ('$')
newLine  db 13, 10, '$'
saved    db 0 