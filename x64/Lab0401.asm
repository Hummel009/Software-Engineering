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

; loop 1: bubble sort outer 
  mov [savedI], 0
Cycle2:    
  ; loop 2: bubble sort inner
    mov [savedJ], 2
  Cycle3: 
    mov ebx, [savedJ]
    mov dx, [arr+ebx-2]
    mov [savedAJM1], dx
    
    mov ebx, [savedJ]
    mov dx, [arr+ebx]
    mov [savedAJM0], dx
   
    mov dx, [savedAJM1]
    cmp dx, [savedAJM0] 
    jle @F ; arr[j-1] <= arr[j] -> skip
                
    mov ax, [savedAJM0]
    mov ebx, [savedJ] 
    mov [arr+ebx-2], ax
                
    mov ax, [savedAJM1]
    mov ebx, [savedJ] 
    mov [arr+ebx], ax

  @@:    
    add [savedJ], 2
    
    mov ecx, [arrSize]
    sub ecx, [savedI]

    cmp [savedJ], ecx
    jng Cycle3
  ; end loop 2

  add [savedI], 2
  mov ecx, [arrSize]

  cmp [savedI], ecx
  jng Cycle2
; end loop 1
         
  invoke WriteConsoleA, [hStdOut], newLine, newLineLen, chrsWritten, 0  
  invoke WriteConsoleA, [hStdOut], str2, str2Len, chrsWritten, 0
 
; loop: show the array
  mov ebx, 0
Cycle4:
  mov dx, [arr+ebx]
  mov [tempWord], dx
  add [tempWord], '0'
  invoke WriteConsoleA, [hStdOut], tempWord, 1, chrsWritten, 0
  invoke WriteConsoleA, [hStdOut], wsp, wspLen, chrsWritten, 0

  add ebx, 2
  cmp ebx, [arrSize]
  jng Cycle4
; end loop

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

  str1      db "Start array:  ", 0
  str1Len   = $-str1
  str2      db "Sorted array: ", 0
  str2Len   = $-str2
  arr       dw 1, 9, 8, 7, 6, 5, 4, 3, 2
  mods      dw 0
  arrSize   dd 16
  savedI    dd 0
  savedJ    dd 0
  savedAJM0 dw 0
  savedAJM1 dw 0
  temp      dd 0

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