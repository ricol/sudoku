unit Common;

interface

uses
  Messages, Windows;

type
  TColor = -$7FFFFFFF - 1 .. $7FFFFFFF;

const
  MAX = 100;
  NUM = 9;
  ADD = 5;
  MUL = 40;
  LEN = MUL;
  TIMEDELAY = 0;
  clBlack = TColor($000000);
  clMaroon = TColor($000080);
  clGreen = TColor($008000);
  clOlive = TColor($008080);
  clNavy = TColor($800000);
  clPurple = TColor($800080);
  clTeal = TColor($808000);
  clGray = TColor($808080);
  clSilver = TColor($C0C0C0);
  clRed = TColor($0000FF);
  clLime = TColor($00FF00);
  clYellow = TColor($00FFFF);
  clBlue = TColor($FF0000);
  clFuchsia = TColor($FF00FF);
  clAqua = TColor($FFFF00);
  clLtGray = TColor($C0C0C0);
  clDkGray = TColor($808080);
  clWhite = TColor($FFFFFF);
  WM_UPDATE = WM_USER + 1;
  LENHEIGHT = 40;
  AMPLIFYWIDTH = 20;
  AMPLIFYHEIGHT = 4;
  AMPLIFY = 20;
  STRCAPTION = 'SuDoKu - RICOL';

type
  TElement = record
    i, j, value: integer;
  end;

  TData = record
    value: integer;
    fixed: boolean;
  end;

  TDataArray = array [1 .. NUM, 1 .. NUM] of TData;

var
  GSpeedOfComputing: cardinal;
  GOK, GMaximumSpeed, GRunning, GStop, GExtend: boolean;
  GTime: cardinal;
  GOtherNumberColor, GNumberColor, GBackgroundColor, GMyPanelColor: TColor;

function IToY(const i: integer): integer;
function JToX(const j: integer): integer;
procedure CopyData(const dataSource: TDataArray; var dataTarget: TDataArray);

implementation

procedure CopyData(const dataSource: TDataArray; var dataTarget: TDataArray);
var
  i, j: integer;
begin
  for i := 1 to NUM do
    for j := 1 to NUM do
      dataTarget[i, j] := dataSource[i, j];
end;

function IToY(const i: integer): integer;
begin
  result := i * MUL + ADD;
end;

function JToX(const j: integer): integer;
begin
  result := j * MUL + ADD;
end;

end.
