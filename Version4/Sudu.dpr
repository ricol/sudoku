program Sudu;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  UnitTStack in 'UnitTStack.pas',
  UnitCommon in 'UnitCommon.pas',
  UnitTTable in 'UnitTTable.pas';

var
  GTable: TTable;
  GChar: char;
  bContinue: boolean;
  i, j, value: integer;

begin
  { TODO -oUser -cConsole Main : Insert code here }
  GTable := TTable.Create();
  Writeln('Do you want to input data?[''y'' or ''Y'' to confirm]');
  Readln(GChar);
  if (GChar = 'y') or (GChar = 'Y') then bContinue := true
  else bContinue := false;
  while bContinue do
  begin
    repeat
      Writeln('Please input i = ');
      Readln(i);
      if (i < 1) or (i > 9) then
      begin
        writeln('The value must between 1 and 9');
        Writeln('Retry');
      end;
    until (i >= 1) and (i <= 9);
    repeat
      Writeln('Please input j = ');
      Readln(j);
      if (j < 1) or (j > 9) then
      begin
        writeln('The value must between 1 and 9');
        Writeln('Retry');
      end;
    until (j >= 1) and (j <= 9);
    repeat
      Writeln('Please input data of [', i, ',', j, ']');
      Readln(value);
      if (value < 1) or (value > 9) then
      begin
        writeln('The value must between 1 and 9');
        Writeln('Retry');
      end else
        GTable.SetValue(i, j, value, true);
    until (value >= 1) and (value <= 9);
    Writeln('Continue to input data?[''y'' or ''Y'' to confirm!]');
    Readln(GChar);
    if (GChar = 'y') or (GChar = 'Y') then bContinue := True
    else bContinue := false;
  end;
  Writeln('Initiate data...');
  GTable.PrintAll;
  Writeln('Searching...');
  GTable.Run;
  GTable.PrintAll;
  Writeln('Complete.');
  Readln;
  GTable.Solved := false;
  GTable.Run;
  GTable.PrintAll;
  Writeln('Complete.');
  GTable.Free;
  Readln;
end.
