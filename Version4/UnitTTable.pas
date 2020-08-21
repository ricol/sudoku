unit UnitTTable;

interface

uses
  UnitCommon, UnitTStack;

type
  TTable = class
  private
    FData: array[1..NUM, 1..NUM] of TData;
    FSolved: Boolean;
    function NextIJ(var i, j: integer): Boolean;
    function NextIJ_(var m, n: Integer): boolean;
    function GetLow(const num: Integer): integer;
    function GetHigh(const num: Integer): integer;
    function CheckColumn(const i, j, value: integer): boolean;
    function CheckLine(const i, j, value: Integer): boolean;
    function CheckCube(const m, n, value: integer): Boolean;
    function FindNextValue(const i, j: Integer; var value: integer): boolean;
    function GetNextBlank(var i, j: integer): boolean;
    procedure SetSolved(const Value: Boolean);
  public
    constructor Create();
    destructor Destroy(); override;
    procedure SetValue(const i, j, value: integer; const bFixed: boolean);
    procedure GetValue(const i, j: Integer; var value: Integer; var bFixed: boolean);
    procedure Run();
    procedure PrintAll();
    property Solved: Boolean read FSolved write SetSolved;
  end;

implementation

{ TTable }

function TTable.CheckColumn(const i, j, value: integer): boolean;
var
  k: integer;
begin
  result := true;
  for k := 1 to NUM do
  begin
    if FData[k, j].value = value then
    begin
      result := false;
      break;
    end;
  end;
end;

function TTable.CheckCube(const m, n, value: integer): Boolean;
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
      if FData[i, j].value = value then
      begin
        result := False;
        exit;
      end;
end;

function TTable.CheckLine(const i, j, value: Integer): boolean;
var
  k: integer;
begin
  result := true;
  for k := 1 to NUM do
  begin
    if FData[i, k].value = value then
    begin
      result := false;
      break;
    end;
  end;
end;

constructor TTable.Create;
var
  i, j: integer;
begin
  for i := 1 to NUM do
    for j := 1 to NUM do
    begin
      FData[i, j].value := 0;
      FData[i, j].fixed := false;
    end;
  FData[1, 1].value := 4;
  FData[1, 1].fixed := true;
  FData[1, 9].value := 8;
  FData[1, 9].fixed := true;
  FData[2, 4].value := 3;
  FData[2, 4].fixed := true;
  FData[2, 5].value := 4;
  FData[2, 5].fixed := true;
  FData[3, 3].value := 9;
  FData[3, 3].fixed := true;
  FData[3, 4].value := 8;
  FData[3, 4].fixed := true;
  FData[3, 5].value := 7;
  FData[3, 5].fixed := true;
  FData[3, 7].value := 6;
  FData[3, 7].fixed := true;
  FData[4, 7].value := 5;
  FData[4, 7].fixed := true;
  FData[4, 8].value := 8;
  FData[4, 8].fixed := true;
  FData[5, 2].value := 3;
  FData[5, 2].fixed := true;
  FData[5, 3].value := 7;
  FData[5, 3].fixed := true;
  FData[5, 5].value := 2;
  FData[5, 5].fixed := true;
  FData[5, 7].value := 4;
  FData[5, 7].fixed := true;
  FData[5, 8].value := 1;
  FData[5, 8].fixed := true;
  FData[6, 2].value := 6;
  FData[6, 2].fixed := true;
  FData[6, 3].value := 8;
  FData[6, 3].fixed := true;
  FData[7, 3].value := 5;
  FData[7, 3].fixed := true;
  FData[7, 5].value := 1;
  FData[7, 5].fixed := true;
  FData[7, 6].value := 2;
  FData[7, 6].fixed := true;
  FData[7, 7].value := 3;
  FData[7, 7].fixed := true;
  FData[8, 5].value := 6;
  FData[8, 5].fixed := true;
  FData[8, 6].value := 5;
  FData[8, 6].fixed := true;
  FData[9, 1].value := 2;
  FData[9, 1].fixed := true;
  FData[9, 9].value := 9;
  FData[9, 9].fixed := true;
  FSolved := false;
end;

destructor TTable.Destroy;
begin
  inherited;
end;

function TTable.FindNextValue(const i, j: Integer;
  var value: integer): boolean;
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

function TTable.GetHigh(const num: Integer): integer;
begin
  result := ((num - 1) div 3 + 1) * 3;
end;

function TTable.GetLow(const num: Integer): integer;
begin
  result := ((num - 1) div 3 + 1) * 3 - 2;
end;

function TTable.GetNextBlank(var i, j: integer): boolean;
var
  m, n: integer;
begin
  result := false;
  for m := 1 to NUM do
    for n := 1 to NUM do
      if not FData[m, n].fixed then
      begin
        i := m;
        j := n;
        result := True;
        exit;
      end;
end;
procedure TTable.GetValue(const i, j: Integer; var value: Integer;
  var bFixed: boolean);
begin
  value := FData[i, j].value;
  bFixed := FData[i, j].fixed;
end;

function TTable.NextIJ(var i, j: integer): Boolean;
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

function TTable.NextIJ_(var m, n: Integer): boolean;
var
  tmpR: boolean;
  i, j: integer;
begin
  i := m;
  j := n;
  repeat
    tmpR := NextIJ(i, j);
  until (not FData[i, j].fixed) or (not tmpR);
  m := i;
  n := j;
  result := tmpR;
end;

procedure TTable.PrintAll;
var
  i, j: integer;
begin
  writeln;
  for i := 1 to NUM do
  begin
    for j := 1 to NUM do
      if FData[i, j].fixed then
        Write('  [', FData[i, j].value:-3, ']')
      else
        Write(FData[i, j].value: 5);
    WriteLn;
  end;
end;

procedure TTable.Run;
var
  stack: TStack;
  i, j, value: integer;
begin
  if FSolved then exit;
  for i := 1 to NUM do
    for j := 1 to NUM do
      if not FData[i, j].fixed then FData[i, j].value := 0;
  stack := TStack.Create();
  value := 1;
  GetNextBlank(i, j);
  FData[i, j].value := value;
  stack.Push(i, j, value);
  repeat
    if not NextIJ_(i, j) then
    begin
      stack.Free;
      FSolved := true;
      exit;
    end;
    value := 0;
    while not FindNextValue(i, j, value) do
    begin
      FData[i, j].value := 0;
      stack.Pop(i, j, value)
    end;
    FData[i, j].value := value;
    stack.Push(i, j, value);
  until false;
end;

procedure TTable.SetSolved(const Value: Boolean);
begin
  FSolved := Value;
end;

procedure TTable.SetValue(const i, j, value: integer; const bFixed: boolean);
begin
  FData[i, j].value := value;
  FData[i, j].fixed := bFixed;
  FSolved := false;
end;

end.
