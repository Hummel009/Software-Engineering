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

  invoke WriteConsoleA, [hStdOut], str2, str2Len, chrsWritten, 0
  invoke WriteConsoleA, [hStdOut], newLine, newLineLen, chrsWritten, 0
  invoke ReadConsoleA, [hStdIn], symbolSrc, 3, chrsRead, 0     

  invoke WriteConsoleA, [hStdOut], str1, str1Len, chrsWritten, 0
  invoke WriteConsoleA, [hStdOut], newLine, newLineLen, chrsWritten, 0
  invoke ReadConsoleA, [hStdIn], readBuf, 255, chrsRead, 0  

  mov al, [symbolSrc]
  mov edi, readBuf
  mov ecx, [chrsRead]
  sub ecx, 1

; find first symbol  
  repne scasb
  jnz breakCycle

  mov ebx, [chrsRead]
  sub ebx, ecx
  mov [pos1], ebx
 
  mov al, [symbolSrc]
  mov edi, readBuf
  mov ecx, [chrsRead]
  sub ecx, 1

; loop: find last symbol   
cycle:    
  repne scasb
  jnz breakCycle

  mov ebx, [chrsRead]
  sub ebx, ecx
  mov [pos2], ebx
  jmp cycle
; end loop
   
breakCycle:

  mov eax, [pos2]
  sub eax, [pos1]
  mov [diff], eax
  add [diff], '0'
  
  add [pos1], '0'
  dec [pos1]

  add [pos2], '0'
  dec [pos2]

  invoke WriteConsoleA, [hStdOut], str3, str3Len, chrsWritten, 0                                                    
  invoke WriteConsoleA, [hStdOut], pos1, 1, chrsWritten, 0 
  invoke WriteConsoleA, [hStdOut], newLine, newLineLen, chrsWritten, 0 

  invoke WriteConsoleA, [hStdOut], str4, str3Len, chrsWritten, 0                                                    
  invoke WriteConsoleA, [hStdOut], pos2, 1, chrsWritten, 0 
  invoke WriteConsoleA, [hStdOut], newLine, newLineLen, chrsWritten, 0

  invoke WriteConsoleA, [hStdOut], str5, str5Len, chrsWritten, 0                                                    
  invoke WriteConsoleA, [hStdOut], diff, 1, chrsWritten, 0 
   
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

  str1     db 'Enter the text:', 0
  str1Len  = $-str1  
  str2     db 'Enter the symbol src:', 0
  str2Len  = $-str2     
  str3     db 'The 1st position of the symbol: ', 0
  str3Len  = $-str3   
  str4     db 'The 2nd position of the symbol: ', 0
  str4Len  = $-str4   
  str5     db 'The distance between 1st and 2nd: ', 0
  str5Len  = $-str5  

  hStdIn      dd 0
  hStdOut     dd 0
  chrsRead    dd 0
  chrsWritten dd 0 
  
  symbolSrc  db 0 
  pos1       dd 0 
  pos2       dd 0 
  diff       dd 0 

  STD_INP_HNDL  dd -10
  STD_OUTP_HNDL dd -11

section '.bss' readable writeable

  readBuf    db ? 

section '.idata' import data readable

  library kernel,'KERNEL32.DLL'

import kernel,\
  SetConsoleTitleA, 'SetConsoleTitleA',\
  GetStdHandle, 'GetStdHandle',\
  WriteConsoleA, 'WriteConsoleA',\
  ReadConsoleA, 'ReadConsoleA',\
  ExitProcess, 'ExitProcess'