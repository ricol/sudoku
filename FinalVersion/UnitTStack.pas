unit UnitTStack;

interface

uses UnitCommon;

type
  TStack = class
  private
    FStack: array [1 .. MAX] of TElement;
    FFlag: integer;
  public
    constructor Create();
    function Push(i, j, value: integer): boolean;
    function Pop(var i, j, value: integer): boolean;
    function StackIsFull(): boolean;
    function StackIsEmpty(): boolean;
    function StackSizeNow(): integer;
  end;

implementation

{ TStack }

constructor TStack.Create;
var
  i: integer;
begin
  FFlag := 0;
  for i := 1 to MAX do
  begin
    FStack[i].i := 0;
    FStack[i].j := 0;
    FStack[i].value := 0;
  end;
end;

function TStack.Pop(var i, j, value: integer): boolean;
var
  element: TElement;
begin
  if FFlag > 0 then
  begin
    element := FStack[FFlag];
    i := element.i;
    j := element.j;
    value := element.value;
    Dec(FFlag);
    result := true;
  end
  else
    result := false;
end;

function TStack.Push(i, j, value: integer): boolean;
var
  element: TElement;
begin
  if FFlag < MAX then
  begin
    element.i := i;
    element.j := j;
    element.value := value;
    Inc(FFlag);
    FStack[FFlag] := element;
    result := true;
  end
  else
    result := false;
end;

function TStack.StackIsEmpty: boolean;
begin
  if FFlag <= 0 then
    result := true
  else
    result := false;
end;

function TStack.StackIsFull: boolean;
begin
  if FFlag >= MAX then
    result := true
  else
    result := false;
end;

function TStack.StackSizeNow: integer;
begin
  result := FFlag;
end;

end.
