program aboba;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  nums: array[1..9] of Integer;
  sus, amogus, i: Integer;

begin
  randomize;    
  for i:= 1 to 9 do
    nums[i]:=random(200);

  for i:= 1 to 9 do
    write(nums[i], ' ');
    
  writeln;
  
  asm
    mov ecx, 0
  @Cycle:
    mov eax, dword[nums+ecx]
    cmp eax, 100
    jng @Skip

    add sus, eax
    add amogus, 1

    @Skip:
    add ecx, 4  //every int is 4 bytes
    cmp ecx, 36 //9 ints = 36 bytes
  jl @Cycle
  end;

  writeln;
  write('The sum of elements bigger then 100: ', sus);    
  writeln;
  write('The amount of elements bigger then 100: ', amogus);

  readln;
end.