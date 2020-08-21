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

var
  GData: array[1..NUM, 1..NUM] of integer;
  GStack: array[1..MAX] of TElement;
  GFlag: integer;
  i, j, value: integer;

procedure InitStack();
begin
  GFlag := 0;
end;

function Push(i, j, value: integer): boolean;
var
  tmpElement: TElement;
begin
  if GFlag < Max then
  begin
    tmpElement.i := i;
    tmpElement.j := j;
    tmpElement.value := value;
    Inc(GFlag);
    GStack[GFlag] := tmpElement;
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

function NextIJ(var i, j: integer): Boolean;
begin
  if i < NUM then
  begin
    if j < NUM then
      Inc(j)
    else
    begin
      Inc(i);
      j := 1;
    end;
    Result := true;
  end else begin
    if j < NUM then
    begin
      Inc(j);
      Result := true;
    end else
      Result := false;
  end;
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
  for k := 1 to i - 1 do
  begin
    if GData[k, j] = value then
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
  for k := 1 to j - 1 do
  begin
    if GData[i, k] = value then
    begin
      result := false;
      break;
    end;
  end;
end;

function CheckCube(const m, n, value: integer): Boolean;
var
  i, j, LowI, LowJ, HighJ: integer;
begin
  result := true;
  LowI := GetLow(m);
  LowJ := GetLow(n);
  HighJ := GetHigh(n);
  for i := LowI to m - 1 do
    for j := LowJ to HighJ do
      if GData[i, j] = value then
      begin
        result := False;
        exit;
      end;
  for j := LowJ to n - 1 do
    if GData[m, j] = value then
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
      Write(GData[i, j]: 3);
    WriteLn;
  end;
end;

begin
  { TODO -oUser -cConsole Main : Insert code here }
  InitStack();
  Write('Searching...');
  i := 1;
  j := 1;
  value := 0;
  GData[1, 1] := 1;
  repeat
    if not NextIJ(i, j) then
    begin
      PrintAll;
      Writeln('Complete.');
      Readln;
      exit;
    end;
    value := 0;
    while not FindNextValue(i, j, value) do
    begin
      GData[i, j] := 0;
      Pop(i, j, value);
    end;
    GData[i, j] := value;
    Push(i, j, value);
  until false;   
end.
