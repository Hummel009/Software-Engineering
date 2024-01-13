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

; skip if 3 <> 5
  mov al, [readBuf+2]
  mov bl, [readBuf+4]

  cmp al, bl
  jne skip

; skip if N < 5
  mov eax, [chrsRead]
  sub eax, 2 ; true length, if skip \r\n

  cmp eax, 5
  jl skip

; find and test N-1
  mov ebx, eax
  sub ebx, 2 ; n - 1 -> indexing from 0 and sub 1

  mov al, [readBuf+ebx]

  cmp al, 'A'
  jl skip

  cmp al, 'z'
  jg skip

; find and test 3
  mov al, [readBuf+2]

  cmp al, 'A'
  jl skip

  cmp al, 'z'
  jg skip

; success
  invoke WriteConsoleA, [hStdOut], str2, str2Len, chrsWritten, 0

  jmp finish

; error
skip:
  invoke WriteConsoleA, [hStdOut], str3, str3Len, chrsWritten, 0

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

  str1    db 'Enter the text:', 0
  str1Len = $-str1
  str2    db 'Yes, this word is str2.', 0
  str2Len = $-str2
  str3    db 'No, this word is not str2.', 0
  str3Len = $-str3

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