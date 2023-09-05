format PE64 Console 5.0
entry Start

include 'win64a.inc'

section '.text' code readable executable

Start:
  invoke SetConsoleTitleA, conTitle
  test eax, eax
  jz Exit

  invoke GetStdHandle, [STD_OUTP_HNDL]
  mov [hStdOut], eax

  invoke GetStdHandle, [STD_INP_HNDL]
  mov [hStdIn], eax

  invoke WriteConsoleA, [hStdOut], str1, str1Len, chrsWritten, 0
  invoke WriteConsoleA, [hStdOut], newLine, newLineLen, chrsWritten, 0
     
  invoke WriteConsoleA, [hStdOut], str2, str2Len, chrsWritten, 0
  invoke WriteConsoleA, [hStdOut], newLine, newLineLen, chrsWritten, 0
  
  invoke ReadConsoleA, [hStdIn], readBuf, 255, chrsRead, 0
    
  mov al, '3'
  mov edi, readBuf
  mov ecx, [chrsRead]

; loop: find symbol
Cycle:
  repne scasb
  jnz BreakCycle

  inc [tempByte]
  jmp Cycle
; end loop
    
BreakCycle:   
  add [tempByte], '0'                                                     
  invoke WriteConsoleA, [hStdOut], str3, str3Len, chrsWritten, 0   
  invoke WriteConsoleA, [hStdOut], tempByte, 1, chrsWritten, 0
     
; prevent from closing
Finish:     
  invoke ReadConsoleA, [hStdIn], readBuf, 1, chrsRead, 0

Exit:
  invoke  ExitProcess, 0

section '.data' data readable writeable

  conTitle   db 'Hummel009', 0
  newLine    db 13, 10, 0
  newLineLen = $-newLine
  wsp        db " ", 0
  wspLen     = $-wsp
  tempWord   dw 0
  tempByte   db 0
                
  str1     db 'We will count the symbol `3`.', 0
  str1Len  = $-str1
  str2     db 'Enter the text:', 0
  str2Len  = $-str2  
  str3     db 'The quantity of symbols: ', 0
  str3Len  = $-str3

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