Program Lab0702;
//USE ASSEMBLER (TASM) INSERTS IN DELPHI 7

{$APPTYPE CONSOLE}

Uses
  SysUtils;

Var
  Temp, Temp2, I, J: Integer;
  savedI, savedJ, savedAI, savedAJ, bytes: Integer;
  A: Array[1..10] of Word;
  Sorted: Boolean;
  N: Integer = 10;

Begin
  For I:=1 to 10 do
    A[I]:=Random(10);

  For I:=1 to 10 do
    Write(A[I], ' ');
  WriteLn;

  For I:=1 to N-1 Do
  Begin
    For J:= 1 To N - I Do
    begin
      Temp:=A[J];
      Temp2:=A[J+1];
      asm
        mov eax, Temp
        mov ebx, Temp2
        cmp eax, ebx
        jng @SKIP
        mov Temp, ebx
        mov Temp2, eax
        @SKIP:
      end;
      A[J]:=Temp;
      A[J+1]:=Temp2;
    End;
  End;

  For I:=1 to 10 do
    Write(A[I], ' ');

  WriteLn;

  ReadLn;
End.