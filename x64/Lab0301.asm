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
  
; loop: show the array
  mov ebx, 0
Cycle1:
  mov dx, [arr+ebx]
  mov [tempWord], dx
  add [tempWord], '0' 
  invoke WriteConsoleA, [hStdOut], tempWord, 1, chrsWritten, 0    
  invoke WriteConsoleA, [hStdOut], wsp, wspLen, chrsWritten, 0

  add ebx, 2
  cmp ebx, [arrSize]
  jng Cycle1
; end loop

  invoke WriteConsoleA, [hStdOut], newLine, newLineLen, chrsWritten, 0
  
  invoke WriteConsoleA, [hStdOut], str2, str2Len, chrsWritten, 0
  
; loop: show needed items
  mov ebx, 0
Cycle2:
  mov dx, [arr+ebx]
  mov [tempWord], dx
          
  shr dx, 1 ; shift -> 1 bit
  jc @F ; jump if older bit is not 0, it means jump if not even
      
  mov dx, [tempWord]
  add [mods], dx
  add [tempWord], '0'
  
  invoke WriteConsoleA, [hStdOut], tempWord, 1, chrsWritten, 0    
  invoke WriteConsoleA, [hStdOut], wsp, wspLen, chrsWritten, 0

@@:
  add ebx, 2
  cmp ebx, [arrSize]
  jng Cycle2
; end loop   
        
  invoke WriteConsoleA, [hStdOut], newLine, newLineLen, chrsWritten, 0
  
  invoke WriteConsoleA, [hStdOut], str3, str3Len, chrsWritten, 0
  
; convert number into 2 symbols
  mov al, byte[mods]
  mov ah, 0
  mov bl, 10
  div bl ; now AL has result, AH has rest
    
  add al, '0'
  mov [tempByte], al 
  invoke WriteConsoleA, [hStdOut], tempByte, 1, chrsWritten, 0 
    
  add ah, '0'
  mov [tempByte], ah  
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
  
  str1     db "Start array: ", 0
  str1Len  = $-str1
  str2     db "New array: ", 0
  str2Len  = $-str2
  str3     db "The sum of items mod 2 = 0: ", 0 
  str3Len  = $-str3
  arr      dw 1, 2, 3, 4, 5, 6, 7, 8, 9
  mods     dw 0
  arrSize  dd 16 
  wsp      db " ", 0
  wspLen   = $-wsp
  tempWord dw 0
  tempByte db 0

  hStdIn      dd 0
  hStdOut     dd 0
  chrsRead    dd 0
  chrsWritten dd 0

  STD_INP_HNDL  dd -10
  STD_OUTP_HNDL dd -11

section '.bss' readable writeable

  readBuf  db ? 
  readLen  db ?    

section '.idata' import data readable

  library kernel,'KERNEL32.DLL'

import kernel,\
  SetConsoleTitleA, 'SetConsoleTitleA',\
  GetStdHandle, 'GetStdHandle',\
  WriteConsoleA, 'WriteConsoleA',\
  ReadConsoleA, 'ReadConsoleA',\
  ExitProcess, 'ExitProcess'