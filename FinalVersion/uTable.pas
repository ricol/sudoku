unit uTable;

interface

uses
  Messages, Windows, SysUtils, Common, uStack;

type
  TTable = class
  private
    FData: TDataArray;
    FSolved: Boolean;
    FMember: THandle;
    FCount: cardinal;
    FNow: cardinal;
    FStop: Boolean;
    function NextIJ(var i, j: integer): Boolean;
    function GetNextIJ(var m, n: integer): Boolean;
    function GetLow(const num: integer): integer;
    function GetHigh(const num: integer): integer;
    function CheckColumn(const i, j, value: integer): Boolean;
    function CheckLine(const i, j, value: integer): Boolean;
    function CheckCube(const m, n, value: integer): Boolean;
    function FindNextValue(const i, j: integer;
      var value: integer): Boolean;
    function GetNextBlank(var i, j: integer): Boolean;
    procedure SetSolved(const Value: Boolean);
    procedure SetMember(const Value: THandle);
    procedure SetCount(const Value: cardinal);
    procedure SendMessageToMember();
    function ErrorCheckLine(const line: integer): Boolean;
    function ErrorCheckColumn(const column: integer): Boolean;
    function ErrorCheckCube(const cube: integer): Boolean;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure SetValue(const i, j, value: integer;
      const bFixed: Boolean);
    procedure GetValue(const i, j: integer; var value: integer;
      var bFixed: Boolean);
    procedure Run();
    property Solved: Boolean read FSolved write SetSolved;
    property Member: THandle read FMember write SetMember;
    property Count: cardinal read FCount write SetCount;
    function AllCheck(): Boolean;
    procedure RearrangeData();
    property DataArray: TDataArray read FData;
  end;

implementation

{ TTable }

function TTable.AllCheck: Boolean;
var
  i: integer;
begin
  result := true;
  for i := 1 to num do
  begin
    if (not ErrorCheckLine(i)) or (not ErrorCheckColumn(i)) or
      (not ErrorCheckCube(i)) then
    begin
      result := false;
      exit;
    end;
  end;
end;

function TTable.CheckColumn(const i, j, value: integer): Boolean;
var
  k: integer;
begin
  result := true;
  for k := 1 to num do
  begin
    if FData[k, j].Value = value then
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
      if FData[i, j].Value = value then
      begin
        result := false;
        exit;
      end;
end;

function TTable.CheckLine(const i, j, value: integer): Boolean;
var
  k: integer;
begin
  result := true;
  for k := 1 to num do
  begin
    if FData[i, k].Value = value then
    begin
      result := false;
      break;
    end;
  end;
end;

function TTable.ErrorCheckLine(const line: integer): Boolean;
var
  i, j, k: integer;
begin
  result := true;
  for i := 1 to num do
  begin
    k := FData[line, i].Value;
    for j := 1 to num do
    begin
      if i = j then
        Continue
      else if k = 0 then
        Continue
      else if k = FData[line, j].Value then
      begin
        result := false;
        MessageBox(Self.Member, PChar(Format('Line %d Error!', [line])),
          'Message', MB_OK);
        exit;
      end;
    end;
  end;
end;

constructor TTable.Create;
var
  i, j: integer;
begin
  inherited;
  for i := 1 to num do
    for j := 1 to num do
    begin
      FData[i, j].Value := 0;
      FData[i, j].fixed := false;
    end;
  FSolved := false;
  FMember := 0;
  FCount := 0;
  FNow := 0;
  FStop := false;
end;

destructor TTable.Destroy;
begin
  inherited;
end;

function TTable.FindNextValue(const i, j: integer;
  var value: integer): Boolean;
var
  bLine, bColumn, bCube: Boolean;
begin
  result := true;
  bLine := false;
  bCube := false;
  repeat
    if value >= num then
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

function TTable.GetHigh(const num: integer): integer;
begin
  result := ((num - 1) div 3 + 1) * 3;
end;

function TTable.GetLow(const num: integer): integer;
begin
  result := ((num - 1) div 3 + 1) * 3 - 2;
end;

function TTable.GetNextBlank(var i, j: integer): Boolean;
var
  m, n: integer;
begin
  result := false;
  for m := 1 to num do
    for n := 1 to num do
      if not FData[m, n].fixed then
      begin
        i := m;
        j := n;
        result := true;
        exit;
      end;
end;

procedure TTable.GetValue(const i, j: integer; var value: integer;
  var bFixed: Boolean);
begin
  value := FData[i, j].Value;
  bFixed := FData[i, j].fixed;
end;

function TTable.NextIJ(var i, j: integer): Boolean;
begin
  if i < num then
  begin
    if j < num then
      Inc(j)
    else
    begin
      Inc(i);
      j := 1;
    end;
    result := true;
  end
  else
  begin
    if j < num then
    begin
      Inc(j);
      result := true;
    end
    else
      result := false;
  end;
end;

function TTable.GetNextIJ(var m, n: integer): Boolean;
var
  r: Boolean;
  i, j: integer;
begin
  i := m;
  j := n;
  repeat
    r := NextIJ(i, j);
  until (not FData[i, j].fixed) or (not r);
  m := i;
  n := j;
  result := r;
end;

procedure TTable.Run;
var
  stack: TStack;
  i, j, Value: integer;
begin
  FStop := false;
  if FSolved then
    exit;
  if not GetNextBlank(i, j) then
  begin
    FSolved := true;
    exit;
  end;
  Value := 0;
  if not FindNextValue(i, j, Value) then
  begin
    exit;
  end;
  stack := TStack.Create();
  FData[i, j].Value := Value;
  stack.Push(i, j, Value);
  repeat
    if FStop then
    begin
      stack.Free;
      exit;
    end;
    if not GetNextIJ(i, j) then
    begin
      stack.Free;
      FSolved := true;
      exit;
    end;
    Value := 0;
    while not FindNextValue(i, j, Value) do
    begin
      if FStop then
      begin
        stack.Free;
        exit;
      end;
      FData[i, j].Value := 0;
      if not GMaximumSpeed then
        SendMessageToMember;
      if stack.StackIsEmpty then
      begin
        stack.Free;
        exit;
      end
      else
        stack.Pop(i, j, Value)
    end;
    FData[i, j].Value := Value;
    stack.Push(i, j, Value);
    if not GMaximumSpeed then
      SendMessageToMember;
  until false;
end;

procedure TTable.SendMessageToMember;
begin
  Inc(FNow);
  Windows.Sleep(TIMEDELAY);
  if FNow >= FCount then
  begin
    SendMessage(FMember, WM_UPDATE, 0, 0);
    FNow := 0;
  end;
  if GStop then
    FStop := true;
end;

procedure TTable.SetCount(const Value: cardinal);
begin
  FCount := Value;
end;

procedure TTable.SetMember(const Value: THandle);
begin
  FMember := Value;
end;

procedure TTable.SetSolved(const Value: Boolean);
begin
  FSolved := Value;
end;

procedure TTable.SetValue(const i, j, value: integer;
  const bFixed: Boolean);
begin
  FData[i, j].Value := value;
  FData[i, j].fixed := bFixed;
  FSolved := false;
end;

function TTable.ErrorCheckColumn(const column: integer): Boolean;
var
  i, j, k: integer;
begin
  result := true;
  for i := 1 to num do
  begin
    k := FData[i, column].Value;
    for j := 1 to num do
    begin
      if i = j then
        Continue
      else if k = 0 then
        Continue
      else if k = FData[j, column].Value then
      begin
        result := false;
        MessageBox(Self.Member, PChar(Format('Column %d Error!', [column])),
          'Message', MB_OK);
        exit;
      end;
    end;
  end;
end;

function TTable.ErrorCheckCube(const cube: integer): Boolean;
var
  i, j, m, n, minI, maxI, minJ, maxJ, k: integer;
begin
  result := true;
  case cube of
    1:
      begin
        minI := 1;
        maxI := 3;
        minJ := 1;
        maxJ := 3;
      end;
    2:
      begin
        minI := 1;
        maxI := 3;
        minJ := 4;
        maxJ := 6;
      end;
    3:
      begin
        minI := 1;
        maxI := 3;
        minJ := 7;
        maxJ := 9;
      end;
    4:
      begin
        minI := 4;
        maxI := 6;
        minJ := 1;
        maxJ := 3;
      end;
    5:
      begin
        minI := 4;
        maxI := 6;
        minJ := 4;
        maxJ := 6;
      end;
    6:
      begin
        minI := 4;
        maxI := 6;
        minJ := 7;
        maxJ := 9;
      end;
    7:
      begin
        minI := 7;
        maxI := 9;
        minJ := 1;
        maxJ := 3;
      end;
    8:
      begin
        minI := 7;
        maxI := 9;
        minJ := 4;
        maxJ := 6;
      end;
    9:
      begin
        minI := 7;
        maxI := 9;
        minJ := 7;
        maxJ := 9;
      end;
  else
    begin
      minI := 0;
      maxI := 0;
      minJ := 0;
      maxJ := 0;
    end;
  end;
  for i := minI to maxI do
    for j := minJ to maxJ do
    begin
      k := FData[i, j].Value;
      for m := minI to maxI do
        for n := minJ to maxJ do
        begin
          if (m = i) and (n = j) then
            Continue
          else if k = 0 then
            Continue
          else if k = FData[m, n].Value then
          begin
            result := false;
            MessageBox(Self.Member, PChar(Format('Cube %d Error!', [cube])),
              'Message', MB_OK);
            exit;
          end;
        end;
    end;
end;

procedure TTable.RearrangeData;
var
  i, j: integer;
begin
  for i := 1 to num do
    for j := 1 to num do
      if not FData[i, j].fixed then
        FData[i, j].Value := 0;
end;

end.
