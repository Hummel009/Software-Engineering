program aboba;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  nums: array[1..19] of Integer;
  sus, amogus, i: Integer;

begin
  randomize;    
  for i:= 1 to 19 do
    nums[i]:=random(100);

  for i:= 1 to 19 do
    write(nums[i], ' ');
    
  writeln;
  
  asm
    mov ecx, 0
  @cycle:
    mov eax, dword[nums+ecx]
    cmp eax, 50
    jnl @skip

    add sus, eax
    add amogus, 1

    @skip:
    add ecx, 4  //every int is 4 bytes
    cmp ecx, 76 //19 ints = 76 bytes
  jl @cycle
  end;

  writeln;
  write('The amount of elements lesser then 50: ', amogus); 
  writeln;
  write('The sum of elements lesser then 50: ', sus);   

  readln;
end.