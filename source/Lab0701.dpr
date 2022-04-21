program aboba;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  nums: array[1..9] of byte;
  sus, amogus, i: byte;

begin
  randomize;    
  for i:= 1 to 9 do
    nums[i]:=random(10);

  for i:= 1 to 9 do
    write(nums[i], ' ');
    
  writeln;
  
  asm
    mov ecx, 0
  @cycle:
    mov al, byte[nums+ecx]
    cmp al, 5
    jng @skip

    add sus, al
    add amogus, 1

    @skip:
    add ecx, 1
    cmp ecx, 9
  jl @cycle
  end;

  writeln;
  write('The sum of elements bigger then 5: ', sus);    
  writeln;
  write('The amount of elements bigger then 5: ', amogus);

  readln;
end.