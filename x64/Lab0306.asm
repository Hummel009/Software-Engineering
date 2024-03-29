format PE64 Console 5.0
entry start

include 'win64a.inc'

section '.text' code readable executable

start:
  invoke SetConsoleTitleA, conTitle

  invoke GetStdHandle, [STD_OUTP_HNDL]
  mov [hStdOut], eax

  invoke GetStdHandle, [STD_INP_HNDL]
  mov [hStdIn], eax

  invoke WriteConsoleA, [hStdOut], str1, str1Len, chrsWritten, 0

; loop: show the array
  mov ebx, 0
cycle1:
  mov dx, [arr+ebx]
  mov [tempWord], dx
  add [tempWord], '0'
  invoke WriteConsoleA, [hStdOut], tempWord, 1, chrsWritten, 0
  invoke WriteConsoleA, [hStdOut], wsp, wspLen, chrsWritten, 0

  add ebx, 2
  cmp ebx, [arrSize]
  jng cycle1
; end loop

; loop 1 
  mov ecx, 0
cycle2:
  mov [savedI], ecx
  mov eax, 0

  ; loop 2
  mov ecx, [savedI]
  cycle3:
    mov [savedJ], ecx

    mov ebx, [savedI]
    mov dx, [arr+ebx]
    mov [savedAI], dx

    mov ebx, [savedJ]
    mov dx, [arr+ebx]
    mov [savedAJ], dx

    mov edx, [savedI]

    cmp edx, [savedJ]
    je @F

    mov dx, [savedAI]

    cmp dx, [savedAJ]
    jne @F

  ; destroy element
    mov ebx, [savedJ]
    mov [arr+ebx], 'ff'

    inc eax

  @@:
    add ecx, 2

    cmp ecx, [arrSize]
    jbe cycle3
  ; end loop 2

  cmp eax, 0
  je @F

  mov ebx, [savedI]
  mov [arr+ebx], 'ff'

@@:
  mov ecx, [savedI]
  add ecx, 2

  cmp ecx, [arrSize]
  jng cycle2
; end loop 1

  invoke WriteConsoleA, [hStdOut], newLine, newLineLen, chrsWritten, 0
    
  invoke WriteConsoleA, [hStdOut], str2, str2Len, chrsWritten, 0  

; loop: show the array
  mov ebx, 0
cycle4:
  mov dx, [arr+ebx] 
  cmp dx, 'ff'
  je @F
  jmp continue
  
@@:
  inc [duplic]

  mov dx, [img+ebx]
  mov [tempWord], dx
  add [tempWord], '0'
  invoke WriteConsoleA, [hStdOut], tempWord, 1, chrsWritten, 0
  invoke WriteConsoleA, [hStdOut], wsp, wspLen, chrsWritten, 0

continue:
  add ebx, 2
  cmp ebx, [arrSize]
  jng cycle4
; end loop

  add [duplic], '0'

  invoke WriteConsoleA, [hStdOut], newLine, newLineLen, chrsWritten, 0

  invoke WriteConsoleA, [hStdOut], str3, str3Len, chrsWritten, 0  
  invoke WriteConsoleA, [hStdOut], duplic, 1, chrsWritten, 0 

; prevent from closing
finish:
  invoke ReadConsoleA, [hStdIn], readBuf, 1, chrsRead, 0

exit:
  invoke  ExitProcess, 0

section '.data' data readable writeable

  conTitle   db 'Hummel009', 0
  newLine    db 13, 10, 0
  newLineLen = $-newLine
  wsp        db " ", 0
  wspLen     = $-wsp
  tempWord   dw 0
  tempByte   db 0

  str1     db "Start array: ", 0
  str1Len  = $-str1
  str2     db "Not unique elements: ", 0
  str2Len  = $-str2
  str3     db "The quantity of not unique elements: ", 0
  str3Len  = $-str3
  arr      dw 1, 2, 3, 4, 5, 5, 7, 8, 9   
  img      dw 1, 2, 3, 4, 5, 5, 7, 8, 9 
  mods     dw 0
  arrSize  dd 16
  duplic   dd 0
  savedI   dd 0
  savedJ   dd 0
  savedAI  dw 0
  savedAJ  dw 0
  temp     dd 0

  hStdIn      dd 0
  hStdOut     dd 0
  chrsRead    dd 0
  chrsWritten dd 0

  STD_INP_HNDL  dd -10
  STD_OUTP_HNDL dd -11

section '.bss' readable writeable

  readBuf  db ?

section '.idata' import data readable

  library kernel,'KERNEL32.DLL'

import kernel,\
  SetConsoleTitleA, 'SetConsoleTitleA',\
  GetStdHandle, 'GetStdHandle',\
  WriteConsoleA, 'WriteConsoleA',\
  ReadConsoleA, 'ReadConsoleA',\
  ExitProcess, 'ExitProcess'