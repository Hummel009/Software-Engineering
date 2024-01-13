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

  mov [res], 0
; loop: show needed items
  mov ebx, 0
cycle2:
  mov ecx, ebx
  shr ecx, 1 ; shift -> 1 bit: our indexes are 0, 2, 4... -> 0, 1, 2...
  inc ecx    ; inc: our indexes are 1, 2, 3...
  shr ecx, 1 ; test mod 2
  jc @F ; jump if older bit is not 0, it means jump if not even
              
  mov dx, [arr+ebx]  
  add [res], dx
  mov [tempWord], dx
  add [tempWord], '0'

  invoke WriteConsoleA, [hStdOut], tempWord, 1, chrsWritten, 0
  invoke WriteConsoleA, [hStdOut], wsp, wspLen, chrsWritten, 0

@@:
  add ebx, 2
  cmp ebx, [arrSize]
  jng cycle2
; end loop

  invoke WriteConsoleA, [hStdOut], newLine, newLineLen, chrsWritten, 0

  invoke WriteConsoleA, [hStdOut], str3, str3Len, chrsWritten, 0

  movzx eax, [res]
  mov ebx, 10
  mov edx, 0 ; clear future place of the rest
  div ebx    ; EAX has the result now, EDX has the rest now
    
  mov [save1], eax
  mov [save2], edx
  
  add [save1], '0'
  invoke WriteConsoleA, [hStdOut], save1, 1, chrsWritten, 0

  add [save2], '0'
  invoke WriteConsoleA, [hStdOut], save2, 1, chrsWritten, 0

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
  str3     db "The sum of items with indexes mod 2 = 0: ", 0
  str3Len  = $-str3
  arr      dw 2, 1, 4, 3, 6, 5, 8, 7, 9
  res      dw 0
  arrSize  dd 16
  
  save1 dd 0
  save2 dd 0

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