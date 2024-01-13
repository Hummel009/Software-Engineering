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

; load converter data
  mov al, [symbolSrc]

  cmp al, 'Z'
  jle toSmallLetter

  cmp al, 'a'
  jge toBigLetter

; set converter data
toBigLetter:
  mov al, [symbolSrc]
  sub al, 32
  mov [symbolDest], al
  jmp find

toSmallLetter:
  mov al, [symbolSrc]
  add al, 32
  mov [symbolDest], al
  jmp find

find:   
  mov al, [symbolSrc]
  mov bl, [symbolDest] 
  mov edi, readBuf
  mov ecx, [chrsRead]
  sub ecx, 1

; loop: find symbol   
cycle:    
  repne scasb
  jnz breakCycle

  mov byte[edi-1], bl
  jmp cycle
; end loop
   
breakCycle:                                                        
  invoke WriteConsoleA, [hStdOut], readBuf, [chrsRead], chrsWritten, 0
   
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
  str3     db 'Enter the symbol dest:', 0
  str3Len  = $-str3  

  hStdIn      dd 0
  hStdOut     dd 0
  chrsRead    dd 0
  chrsWritten dd 0 
  
  symbolSrc  db 0 
  symbolDest db 0 

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