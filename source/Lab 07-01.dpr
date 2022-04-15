Program Lab0701;
//USE ASSEMBLER (TASM) INSERTS IN DELPHI 7

{$APPTYPE CONSOLE}

Uses
  SysUtils;

Var
  A: Array[1..1000] of Integer;
  Error, Temp, N, I: Integer;
  Spec: Integer;
  Input: String;
Begin
  Write('Enter the quantity of input array elements: ');
  ReadLn(N);

  For I:= 1 To N Do
  Begin
    Write('A[', I, ']=');
    ReadLn(A[I]);
  End;

  For I:= 1 to N do
  Begin
    Spec:=A[I];
    Begin
      asm
          mov eax, Spec
          cmp eax, 0
          jge @SUS
          
          mov ebx, -1
          idiv ebx

          @SUS:
      end;
    End;
  End;
      
  WriteLn;

  For I:= 1 to N - 1 do
  Begin

    Repeat

      If A[I] <> 0 then
      Begin

        If A[I] <= A[I + 1] then
        Begin
          A[I+1]:= A[I+1] mod A[I];
        end
        Else
        Begin
          Temp:=A[I];
          Spec:=A[I+1];
          asm
            mov eax, Temp
            mov ebx, Spec
            mov Spec, eax
            mov Temp, ebx;
          end;
          A[I]:=Temp;
          A[I+1]:= Spec;
        End;
      End
      Else
      Begin
        Temp:=A[I];
        Spec:=A[I+1];
        asm
          mov Temp, 0  
          mov Spec, 0
        end;
        A[I]:=Temp;
        A[I+1]:=Spec;
      End;
    Until (A[I] = 0);
  End;

  Write('GCD = ', A[N]);
  ReadLn;
End.