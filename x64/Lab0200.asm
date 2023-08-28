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
  
;====== Skip IF 3 <> 5 ======;
  mov al, [readBuf+2]
  mov bl, [readBuf+4]
  
  cmp al, bl
  jne Skip

;====== Skip IF N < 5 ======;
  sub [chrsRead], 2

  cmp [chrsRead], 5
  jl Skip

;====== FIND AND TEST N-1 ======;
  mov bx, 0
  mov bl, [str2+1]
  mov al, [str2+bx]

  cmp al, 'A'
  jl Skip

  cmp al, 'z'
  jg Skip

;====== FIND AND TEST 3 ======; 
  mov al, [readBuf+2]

  cmp al, 'A'
  jl Skip

  cmp al, 'z'
  jg Skip    

;====== FIND LENGTH ======; 
  mov ebx, 0
  jmp Iter

Sus:
  inc ebx

Iter:
  cmp [readBuf+ebx], 0
  jne Sus

  sub ebx, 2
  mov [readLen], bl
  cmp [readLen], 10
  jnl Skip
  
  add [readLen], '0'

  ;invoke WriteConsoleA, [hStdOut], readLen, 1, chrsWritten, 0   
  ;invoke WriteConsoleA, [hStdOut], newLine, newLineLen, chrsWritten, 0
  
;====== Skip IF N < 5 ======;
  cmp [readLen], 5
  jl Skip
  
;====== FIND AND TEST N-1 ======;
  movzx ebx, [readLen]
  mov al, [readBuf+ebx]

  cmp al, 'A'
  jl Skip

  cmp al, 'z'
  jg Skip
  
;====== EVERYTHING IS OK ======;
        
  invoke WriteConsoleA, [hStdOut], allowed, allowedLen, chrsWritten, 0

  jmp Finish
    
;====== EVERYTHING IS NOT OK ======;
Skip:
  invoke WriteConsoleA, [hStdOut], disallowed, disallowedLen, chrsWritten, 0

;====== DO NOT CLOSE ======;
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