program Sudu;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const
  MAX = 1000;
  NUM = 9;

type
  TElement = record
    i, j, value: integer;
  end;

  TData = record
    value: integer;
    fixed: boolean;
  end;

var
  GData: array[1..NUM, 1..NUM] of TData;
  GStack: array[1..MAX] of TElement;
  GFlag: integer;
  i, j, value: integer;
  bContinue: boolean;
  GChar: Char;

procedure InitStack();
begin
  GFlag := 0;
end;

function Push(i, j, value: integer): boolean;
var
  element: TElement;
begin
  if GFlag < Max then
  begin
    element.i := i;
    element.j := j;
    element.value := value;
    Inc(GFlag);
    GStack[GFlag] := element;
    result := true;
  end else
    result := false;
end;

function Pop(var i, j, value: integer): boolean;
var
  element: TElement;
begin
  if GFlag > 0 then
  begin
    element := GStack[GFlag];
    i := element.i;
    j := element.j;
    value := element.value;
    Dec(GFlag);
    Result := true;
  end else
    Result := false;
end;

function StackIsFull(): boolean;
begin
  if GFlag >= MAX then Result := True
  else Result := false;
end;

function StackIsEmpty(): boolean;
begin
  if GFlag <= 0 then result := True
  else Result := false;
end;

function StackSizeNow(): integer;
begin
  result := GFlag;
end;

function NextIJ(var m, n: integer): Boolean;
begin
  if m < NUM then
  begin
    if n < NUM then
      Inc(n)
    else
    begin
      Inc(m);
      n := 1;
    end;
    Result := true;
  end else begin
    if n < NUM then
    begin
      Inc(n);
      Result := true;
    end else
      Result := false;
  end;
end;

function NextIJ_(var m, n: Integer): boolean;
var
  r: boolean;
  i, j: integer;
begin
  i := m;
  j := n;
  repeat
    r := NextIJ(i, j);
  until (not GData[i, j].fixed) or (not r);
  m := i;
  n := j;
  result := r;
end;

function GetLow(const num: Integer): integer;
begin
  result := ((num - 1) div 3 + 1) * 3 - 2;
end;

function GetHigh(const num: Integer): integer;
begin
  result := ((num - 1) div 3 + 1) * 3;
end;

function GetMax(const i, j: Integer): integer;
begin
  if i > j then result := i
  else result := j;
end;

function GetMin(const i, j: integer): integer;
begin
  if i > j then result := j
  else result := i;
end;

function CheckColumn(const i, j, value: integer): boolean;
var
  k: integer;
begin
  result := true;
  for k := 1 to NUM do
  begin
    if GData[k, j].value = value then
    begin
      result := false;
      break;
    end;
  end;
end;

function CheckLine(const i, j, value: Integer): boolean;
var
  k: integer;
begin
  result := true;
  for k := 1 to NUM do
  begin
    if GData[i, k].value = value then
    begin
      result := false;
      break;
    end;
  end;
end;

function CheckCube(const m, n, value: integer): Boolean;
var
  i, j, LowI, LowJ, HighI, HighJ: integer;
begin
  result := true;
  LowI := GetLow(m);
  LowJ := GetLow(n);
  HighI := GetHigh(m);
  HighJ := GetHigh(n);
  for i := LowI to HighI do
    for j := LowJ to HighJ do
      if GData[i, j].value = value then
      begin
        result := False;
        exit;
      end;
end;

function FindNextValue(const i, j: Integer; var value: integer): boolean;
var
  bLine, bColumn, bCube: boolean;
begin
  result := true;
  bLine := false;
  bCube := false;
  repeat
    if value >= NUM then
    begin
      result := false;
      exit;
    end;
    Inc(value);
    bColumn := CheckColumn(i, j, value);
    if bColumn then
    begin
      bLine := CheckLine(i, j, value);
      if bLine then
      begin
        bCube := CheckCube(i, j, value);
        if bCube then
        begin
          result := true;
          exit;
        end;
      end;
    end;
  until bColumn and bLine and bCube;
end;

procedure PrintAll();
var
  i, j: integer;
begin
  writeln;
  for i := 1 to NUM do
  begin
    for j := 1 to NUM do
      if GData[i, j].fixed then
        Write('  [', GData[i, j].value:-3, ']')
      else
        Write(GData[i, j].value: 5);
    WriteLn;
  end;
end;

function GetNextBlank(var i, j: integer): boolean;
var
  m, n: integer;
begin
  result := false;
  for m := 1 to NUM do
    for n := 1 to NUM do
      if not GData[m, n].fixed then
      begin
        i := m; j := n;
        result := True;
        exit;
      end;
end;

procedure InitData();
var
  i, j: integer;
begin
  for i := 1 to NUM do
    for j := 1 to NUM do
    begin
      GData[i, j].value := 0;
      GData[i, j].fixed := false;
    end;
//  GData[1, 1].value := 4;
//  GData[1, 1].fixed := true;
//  GData[1, 9].value := 8;
//  GData[1, 9].fixed := true;
//  GData[2, 4].value := 3;
//  GData[2, 4].fixed := true;
//  GData[2, 5].value := 4;
//  GData[2, 5].fixed := true;
//  GData[3, 3].value := 9;
//  GData[3, 3].fixed := true;
//  GData[3, 4].value := 8;
//  GData[3, 4].fixed := true;
//  GData[3, 5].value := 7;
//  GData[3, 5].fixed := true;
//  GData[3, 7].value := 6;
//  GData[3, 7].fixed := true;
//  GData[4, 7].value := 5;
//  GData[4, 7].fixed := true;
//  GData[4, 8].value := 8;
//  GData[4, 8].fixed := true;
//  GData[5, 2].value := 3;
//  GData[5, 2].fixed := true;
//  GData[5, 3].value := 7;
//  GData[5, 3].fixed := true;
//  GData[5, 5].value := 2;
//  GData[5, 5].fixed := true;
//  GData[5, 7].value := 4;
//  GData[5, 7].fixed := true;
//  GData[5, 8].value := 1;
//  GData[5, 8].fixed := true;
//  GData[6, 2].value := 6;
//  GData[6, 2].fixed := true;
//  GData[6, 3].value := 8;
//  GData[6, 3].fixed := true;
//  GData[7, 3].value := 5;
//  GData[7, 3].fixed := true;
//  GData[7, 5].value := 1;
//  GData[7, 5].fixed := true;
//  GData[7, 6].value := 2;
//  GData[7, 6].fixed := true;
//  GData[7, 7].value := 3;
//  GData[7, 7].fixed := true;
//  GData[8, 5].value := 6;
//  GData[8, 5].fixed := true;
//  GData[8, 6].value := 5;
//  GData[8, 6].fixed := true;
//  GData[9, 1].value := 2;
//  GData[9, 1].fixed := true;
//  GData[9, 9].value := 9;
//  GData[9, 9].fixed := true;
end;

begin
  { TODO -oUser -cConsole Main : Insert code here }
  InitData();
  InitStack();
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
      begin
        GData[i, j].value := value;
        GData[i, j].fixed := true;
      end;
    until (value >= 1) and (value <= 9);
    Writeln('Continue to input data?[''y'' or ''Y'' to confirm!]');
    Readln(GChar);
    if (GChar = 'y') or (GChar = 'Y') then bContinue := True
    else bContinue := false;
  end;   
  Writeln('Initiate data value...');
  PrintAll;
  Writeln;
  Write('Searching...');
  value := 1;
  GetNextBlank(i, j);
  GData[i, j].value := value;
  Push(i, j, value);
  repeat
    if not NextIJ_(i, j) then
    begin
      PrintAll;
      Writeln('Complete.');
      Readln;
      exit;
    end;
    value := 0;
    while not FindNextValue(i, j, value) do
    begin
      GData[i, j].value := 0;
      Pop(i, j, value);
    end;
    GData[i, j].value := value;
    Push(i, j, value);
  until false;
end.
