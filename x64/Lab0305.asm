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
  cmp [tempWord], 0
  jg @F

  mov ax, [tempWord]
  mov cl, -1
  idiv cl ; make it > 0 and display "-" separately  
  mov [tempWord], ax
  invoke WriteConsoleA, [hStdOut], min, minLen, chrsWritten, 0

@@:      
  add [tempWord], '0'
  invoke WriteConsoleA, [hStdOut], tempWord, 1, chrsWritten, 0
  invoke WriteConsoleA, [hStdOut], wsp, wspLen, chrsWritten, 0

  add ebx, 2
  cmp ebx, [arrSize]
  jng cycle1
; end loop

; loop: find at least one element < 0
  mov ebx, 0
cycle2:
  mov dx, [arr+ebx]
  cmp dx, 0
  jge @F

  mov [zeroMaxL], dx
  jmp breakCycle2

@@:
  add ebx, 2
  cmp ebx, [arrSize]
  jng cycle2
; end loop

breakCycle2:
   
; loop: find at least one element >= 0
  mov ebx, 0
cycle3:
  mov dx, [arr+ebx]
  cmp dx, 0
  jl @F

  mov [zeroMinGE], dx
  jmp breakCycle3
  
@@:
  add ebx, 2
  cmp ebx, [arrSize]
  jng cycle3
; end loop

breakCycle3:

; loop: find athe biggest element < 0
  mov ebx, 0
cycle4:
  mov dx, [arr+ebx]
  cmp dx, 0
  jge @F
  
  cmp dx, [zeroMaxL]
  jle @F
            
  mov [zeroMaxL], dx
  
@@:
  add ebx, 2
  cmp ebx, [arrSize]
  jng cycle4
; end loop

; loop: find the least element >= 0
  mov ebx, 0
cycle5:
  mov dx, [arr+ebx]
  cmp dx, 0
  jl @F
  
  cmp dx, [zeroMinGE]
  jge @F

  mov [zeroMinGE], dx
  
@@:
  add ebx, 2
  cmp ebx, [arrSize]
  jng cycle5
; end loop

  invoke WriteConsoleA, [hStdOut], newLine, newLineLen, chrsWritten, 0
  invoke WriteConsoleA, [hStdOut], str2, str2Len, chrsWritten, 0 
  mov ax, [zeroMaxL]
  mov cl, -1
  idiv cl ; make it > 0 and display "-" separately  
  mov [zeroMaxL], ax 
  add [zeroMaxL], '0'
  invoke WriteConsoleA, [hStdOut], min, minLen, chrsWritten, 0  
  invoke WriteConsoleA, [hStdOut], zeroMaxL, 1, chrsWritten, 0

  invoke WriteConsoleA, [hStdOut], newLine, newLineLen, chrsWritten, 0
  invoke WriteConsoleA, [hStdOut], str3, str3Len, chrsWritten, 0   
  add [zeroMinGE], '0'
  invoke WriteConsoleA, [hStdOut], zeroMinGE, 1, chrsWritten, 0

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

  str1      db "Start array: ", 0
  str1Len   = $-str1
  str2      db "The biggest element < 0: ", 0
  str2Len   = $-str2
  str3      db "The smallest element >= 0: ", 0
  str3Len   = $-str3
  arr       dw -9, 8, -7, 6, -5, 4, -3, 2, -1
  mods      dw 0
  arrSize   dd 16
  min       db "-", 0
  minLen    = $-min
  zeroMaxL  dw 0
  zeroMinGE dw 0

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