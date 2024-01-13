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
  invoke WriteConsoleA, [hStdOut], newLine, newLineLen, chrsWritten, 0
  invoke ReadConsoleA, [hStdIn], readBuf, 255, chrsRead, 0

; swap letters
  mov al, [readBuf+8] ; indexing from 0, so 9th symbol = 8
  mov bl, [readBuf+9]
  mov [readBuf+8], bl
  mov [readBuf+9], al

; do manipulations on letters
  mov al, [readBuf+2]
  mov bl, [readBuf+5]
  mov cl, [readBuf+8]
  sub al, bl
  add al, cl
  mov [readBuf+4], al

  invoke WriteConsoleA, [hStdOut], readBuf, [chrsRead], chrsWritten, 0

; prevent from closing
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

  str1    db 'Enter the text:', 0
  str1Len = $-str1

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