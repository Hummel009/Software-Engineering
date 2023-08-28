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

  invoke WriteConsoleA, [hStdOut], msg, msgLen, chrsWritten, 0   
  invoke WriteConsoleA, [hStdOut], newLine, newLineLen, chrsWritten, 0
  invoke ReadConsoleA, [hStdIn], readBuf, 255, chrsRead, 0
  
; skip if 3 <> 5
  mov al, [readBuf+2]
  mov bl, [readBuf+4]
  
  cmp al, bl
  jne Skip

; skip if N < 5
  mov eax, [chrsRead]
  sub eax, 2 ; true length

  cmp eax, 5
  jl Skip

; find and test N-1
  mov ebx, eax
  sub ebx, 2 ; n - 1 -> indexing from 0 and sub 1
  
  mov al, [readBuf+ebx]

  cmp al, 'A'
  jl Skip

  cmp al, 'z'
  jg Skip

; find and test 3rd
  mov al, [readBuf+2]

  cmp al, 'A'
  jl Skip

  cmp al, 'z'
  jg Skip    
  
; success
  invoke WriteConsoleA, [hStdOut], allowed, allowedLen, chrsWritten, 0

  jmp Finish
    
; error
Skip:
  invoke WriteConsoleA, [hStdOut], disallowed, disallowedLen, chrsWritten, 0

; prevent from closing
Finish:    
  invoke ReadConsoleA, [hStdIn], readBuf, 1, chrsRead, 0

Exit:
  invoke  ExitProcess, 0

section '.data' data readable writeable

  conTitle          db 'Hummel009', 0
  msg               db 'Enter the text:', 0
  msgLen            = $-msg
  newLine           db 13, 10, 0  
  newLineLen        = $-newLine
  allowed           db 'Yes, this word is allowed.'
  allowedLen        = $-allowed
  disallowed        db 'No, this word is not allowed.'
  disallowedLen     = $-disallowed

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