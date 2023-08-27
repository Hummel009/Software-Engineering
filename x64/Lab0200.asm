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
  
;====== SKIP IF 3 <> 5 ======;
  ;invoke WriteConsoleA, [hStdOut], readBuf+2, 1, chrsWritten, 0   
  ;invoke WriteConsoleA, [hStdOut], newLine, newLineLen, chrsWritten, 0
  ;invoke WriteConsoleA, [hStdOut], readBuf+4, 1, chrsWritten, 0 
  ;invoke WriteConsoleA, [hStdOut], newLine, newLineLen, chrsWritten, 0

  mov al, [readBuf+2]
  mov bl, [readBuf+4]
  cmp al, bl
  jne skip
		     
;====== FIND AND TEST 3 ======; 
  mov al, [readBuf+2]

  cmp al, 'A'
  jl skip

  cmp al, 'z'
  jg skip    
                    
;====== FIND LENGTH ======; 
  mov ebx, 0
  jmp iter

sus:
  inc ebx

iter:
  cmp [readBuf+ebx], 0
  jne sus

  sub ebx, 2
  mov [readLen], bl
  cmp [readLen], 10
  jnl skip
  
  add [readLen], '0'

  ;invoke WriteConsoleA, [hStdOut], readLen, 1, chrsWritten, 0   
  ;invoke WriteConsoleA, [hStdOut], newLine, newLineLen, chrsWritten, 0
  
;====== SKIP IF N < 5 ======;
  cmp [readLen], 5
  jl skip
  
;====== FIND AND TEST N-1 ======;
  movzx ebx, [readLen]
  mov al, [readBuf+ebx]

  cmp al, 'A'
  jl skip

  cmp al, 'z'
  jg skip
  
;====== EVERYTHING IS OK ======;
        
	invoke WriteConsoleA, [hStdOut], allowed, allowedLen, chrsWritten, 0

	jmp finish
		
;====== EVERYTHING IS NOT OK ======;
  skip:
	invoke WriteConsoleA, [hStdOut], disallowed, disallowedLen, chrsWritten, 0

;====== DO NOT CLOSE ======;
  finish:		
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
