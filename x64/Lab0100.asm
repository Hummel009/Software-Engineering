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
  
  mov al, [readBuf+8]
  mov bl, [readBuf+9]
  mov [readBuf+8], bl
  mov [readBuf+9], al   
  
  mov al, [readBuf+2]
  mov bl, [readBuf+5]
  mov cl, [readBuf+8]
  sub al, bl
  add al, cl
  mov [readBuf+4], al
                          
  sub [chrsRead], 2

  invoke WriteConsoleA, [hStdOut], readBuf, [chrsRead], chrsWritten, 0    

  invoke ReadConsoleA, [hStdIn], readBuf, 1, chrsRead, 0 

Exit:
  invoke  ExitProcess, 0

section '.data' data readable writeable

  conTitle    db 'Hummel009', 0
  msg         db 'Enter the text:', 0
  msgLen      = $-msg
  newLine     db 13, 10, 0  
  newLineLen  = $-newLine

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
