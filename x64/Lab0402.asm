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

  invoke WriteConsoleA, [hStdOut], newLine, newLineLen, chrsWritten, 0

  invoke WriteConsoleA, [hStdOut], str2, str2Len, chrsWritten, 0

; loop: show needed items
  mov ebx, 0
cycle2:
  mov dx, [arr+ebx]

  shr dx, 1 ; shift -> 1 bit
  jc @F ; jump if older bit is not 0, it means jump if not even

  mov dx, [arr+ebx]  
  inc [qua]
  
  mov [tempWord], dx
  add [tempWord], '0'

  invoke WriteConsoleA, [hStdOut], tempWord, 1, chrsWritten, 0
  invoke WriteConsoleA, [hStdOut], wsp, wspLen, chrsWritten, 0

@@:
  add ebx, 2
  cmp ebx, [arrSize]
  jng cycle2
; end loop

  add [qua], '0'
  
  invoke WriteConsoleA, [hStdOut], newLine, newLineLen, chrsWritten, 0
  invoke WriteConsoleA, [hStdOut], str3, str3Len, chrsWritten, 0
  invoke WriteConsoleA, [hStdOut], qua, 1, chrsWritten, 0

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
  str2     db "New array: ", 0
  str2Len  = $-str2
  str3     db "The quantity of items with values mod 2 = 0: ", 0
  str3Len  = $-str3
  arr      dw 2, 1, 4, 3, 6, 5, 8, 7, 9
  qua      dw 0
  arrSize  dd 16

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