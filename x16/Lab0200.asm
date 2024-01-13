org 100h

; start
  mov ah, 09h
  mov dx, str1
  int 21h

  mov ah, 0ah
  mov dx, str2
  int 21h

  mov ah, 09h
  mov dx, newLine
  int 21h

; skip if 3 <> 5
  mov al, [str2+4]
  mov bl, [str2+6]

  cmp al, bl
  jne skip

; skip if N < 5
  mov al, [str2+1]

  cmp al, 5
  jl skip

; find and test N-1
  mov bx, 0
  mov bl, [str2+1]
  mov al, [str2+bx]

  cmp al, 'A'
  jl skip

  cmp al, 'z'
  jg skip

; find and test 3
  mov al, [str2+4]

  cmp al, 'A'
  jl skip

  cmp al, 'z'
  jg skip

; success
  mov ah, 09h
  mov dx, str3
  int 21h

  jmp finish

; error
skip:
  mov ah, 09h
  mov dx, str4
  int 21h

; prevent from closing
finish:
  mov ah, 08h
  int 21h

ret

; variables
  str1    db "Enter the text: $"
  str2    db 7, 0, 7 dup ('$')
  str3    db 'Yes, this word is allowed.$'
  str4    db 'No, this word is not allowed.$'
  newLine db 13, 10, '$'