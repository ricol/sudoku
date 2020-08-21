unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,
  UnitCommon, UnitTStack, UnitTTable, UnitTMySpeedButton, UnitConfig, UnitAbout;

type
  TFormMain = class(TForm)
    PanelLeft: TPanel;
    PanelClient: TPanel;
    PanelControl: TPanel;
    PanelRight: TPanel;
    Timer1: TTimer;
    Timer2: TTimer;
    PanelRightLeft: TPanel;
    PanelRightRight: TPanel;
    PanelRightBottom: TPanel;
    PanelOther: TPanel;
    PaintBoxMain: TPaintBox;
    SBExtend: TSpeedButton;
    BtnRetry: TSpeedButton;
    BtnOK: TSpeedButton;
    SpeedButton1: TSpeedButton;
    BtnHelp: TSpeedButton;
    procedure BtnRetryClick(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnHelpClick(Sender: TObject);
    procedure BtnSpeedClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer2Timer(Sender: TObject);
    procedure SBExtendClick(Sender: TObject);
    procedure PaintBoxMainPaint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    procedure SpeedButtonMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ProcessMessage_WM_UPDATE(var msg: TMessage); message WM_UPDATE;
    procedure ShowData();
    procedure UpdataPaintBox();
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

var
  GBtnArray: array [1 .. NUM, 1 .. NUM] of TMySpeedButton;
  GTable: TTable;
  GData: TDataArray;
  GFlag: Integer;

procedure TFormMain.BtnRetryClick(Sender: TObject);
var
  i, j, Value: Integer;
  bFixed: boolean;
begin
  FreeAndNil(GTable);
  GTable := TTable.Create;
  // begin debug
  // for i := 1 to NUM do
  // GTable.SetValue(1, i, i, true);
  GTable.SetValue(1, 1, 9, true);
  GTable.SetValue(2, 6, 6, true);
  GTable.SetValue(2, 8, 8, true);
  GTable.SetValue(3, 4, 4, true);
  GTable.SetValue(4, 2, 2, true);
  GTable.SetValue(5, 6, 9, true);
  GTable.SetValue(7, 2, 9, true);
  GTable.SetValue(7, 7, 7, true);
  GTable.SetValue(9, 3, 7, true);
  GTable.SetValue(9, 9, 9, true);
  // end debug
  GTable.Member := Self.Handle;
  GTable.Count := GSpeedOfComputing;
  for i := 1 to NUM do
    for j := 1 to NUM do
    begin
      FreeAndNil(GBtnArray[i, j]);
      GBtnArray[i, j] := TMySpeedButton.Create(Self);
      GBtnArray[i, j].Hide;
      GBtnArray[i, j].OnMouseUp := Self.SpeedButtonMouseUp;
      GBtnArray[i, j].Parent := PanelClient;
      GBtnArray[i, j].Tag := i * 10 + j;
      GBtnArray[i, j].Left := JToX(j - 1);
      GBtnArray[i, j].Top := IToY(i - 1);
      GBtnArray[i, j].Width := LEN;
      GBtnArray[i, j].Height := LEN;
      GBtnArray[i, j].Flat := true;
      GBtnArray[i, j].Font.Size := 14;
      GBtnArray[i, j].Font.Charset := 254;
      GBtnArray[i, j].Show;
      GTable.GetValue(i, j, Value, bFixed);
      if bFixed then
        GBtnArray[i, j].Font.Color := GNumberColor
      else
        GBtnArray[i, j].Font.Color := GOtherNumberColor;
    end;
  ShowData();
  PanelRightBottom.Caption := 'Running Status';
end;

procedure TFormMain.BtnOKClick(Sender: TObject);
begin
  if GRunning then
  begin
    GStop := true;
    Timer1.Enabled := false;
    Timer2.Enabled := false;
    Application.ProcessMessages;
    exit;
  end;
  if GTable = nil then
    exit;
  GTable.RearrangeData;
  if not GTable.AllCheck then
  begin
    MessageBox(Self.Handle, 'Sorry, Please recheck the data you have inputed!',
      'Message', MB_OK or MB_ICONINFORMATION);
    exit;
  end;
  BtnRetry.Enabled := false;
  Application.ProcessMessages;
  GTable.Solved := false;
  PanelRightBottom.Caption := 'Running...';
  ShowData;
  GTime := 0;
  GFlag := 0;
  Timer1.Enabled := true;
  Timer2.Enabled := true;
  BtnOK.Caption := '&Abort';
  GRunning := true;
  GTable.Run;
  GRunning := false;
  BtnOK.Caption := '&Ok';
  Timer1.Enabled := false;
  Timer2.Enabled := false;
  Self.Caption := STRCAPTION;
  PanelRightBottom.Caption := 'Complete.[time: ' + IntToStr(GTime) + ']';
  BtnRetry.Enabled := true;
  if (not GStop) and (not GTable.Solved) then
    MessageBox(Self.Handle, 'There is no answer for this table!', 'Result',
      MB_OK or MB_ICONINFORMATION)
  else if (not GStop) then
    ShowData;
  GStop := false;
  Application.ProcessMessages;
end;

procedure TFormMain.SpeedButtonMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  btn: TSpeedButton;
  s: string;
  i, j, num, value: Integer;
  bFixed, bResult: boolean;
begin
  btn := Sender as TMySpeedButton;
  num := btn.Tag;
  i := num div 10;
  j := num - i * 10;
  if Button = mbLeft then
  begin
    GTable.GetValue(i, j, value, bFixed);
    repeat
      s := IntToStr(value);
      bResult := InputQuery('Input Dialog', 'Value = ', s);
      if not bResult then
        exit;
      num := StrToInt(s);
      if (num > 9) or (num < 1) then
        MessageBox(Self.Handle, 'Out of range[1..9]!, Please input again!',
          'Message', MB_OK);
    until (num <= 9) and (num >= 1);
    GTable.SetValue(i, j, num, true);
    btn.Font.Color := GNumberColor;
    btn.Caption := s;
  end
  else
  begin
    GTable.SetValue(i, j, 0, false);
    GBtnArray[i, j].Font.Color := clBlack;
    GBtnArray[i, j].Caption := '0';
  end;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(GTable);
end;

procedure TFormMain.BtnHelpClick(Sender: TObject);
var
  fAbout: TFormAbout;
  bInitTime: boolean;
begin
  bInitTime := false;
  if Timer1.Enabled then
  begin
    bInitTime := true;
    Timer1.Enabled := false;
    Timer2.Enabled := false;
  end;
  try
    fAbout := TFormAbout.Create(nil);
    fAbout.Left := Self.Left + Self.Width div 2 -
      fAbout.Width div 2;
    fAbout.Top := Self.Top + Self.Height div 2 -
      fAbout.Height div 2;
    fAbout.ShowModal;
    if bInitTime then
    begin
      Timer1.Enabled := true;
      Timer2.Enabled := true;
    end;
  finally
    FreeAndNil(fAbout);
  end;
end;

procedure TFormMain.ProcessMessage_WM_UPDATE(var msg: TMessage);
var
  i, j, value, number, newValue: Integer;
  bFixed, bNewFixed: boolean;
begin
  if GMaximumSpeed then
  begin
    // PaintBoxMain.Canvas.Pen.Color := clBtnFace;
    // PaintBoxMain.Canvas.Rectangle(0, 0, PaintBoxMain.Width - 1, PaintBoxMain.Height - 1);
    Application.ProcessMessages;
    exit;
  end;
  PaintBoxMain.Canvas.Pen.Color := GBackgroundColor;
  for i := 1 to NUM do
    for j := 1 to NUM do
    begin
      number := i * 10 + j;
      value := GData[i, j].Value;
      GTable.GetValue(i, j, newValue, bNewFixed);
      begin
        if (value <> 0) and (value <> newValue) then
        begin
          PaintBoxMain.Canvas.MoveTo(0, number * AMPLIFYHEIGHT - LENHEIGHT);
          PaintBoxMain.Canvas.LineTo(value * AMPLIFYWIDTH,
            number * AMPLIFYHEIGHT - LENHEIGHT);
        end;
      end;
    end;
  CopyData(GTable.DataArray, GData);
  for i := 1 to NUM do
    for j := 1 to NUM do
    begin
      number := i * 10 + j;
      value := GData[i, j].Value;
      bFixed := GData[i, j].fixed;
      if bFixed then
        PaintBoxMain.Canvas.Pen.Color := GNumberColor
      else
        PaintBoxMain.Canvas.Pen.Color := GOtherNumberColor;
      if value <> 0 then
      begin
        PaintBoxMain.Canvas.MoveTo(0, number * AMPLIFYHEIGHT - LENHEIGHT);
        PaintBoxMain.Canvas.LineTo(value * AMPLIFYWIDTH,
          number * AMPLIFYHEIGHT - LENHEIGHT);
      end;
    end;
  Application.ProcessMessages;
end;

procedure TFormMain.ShowData;
var
  i, j, value: Integer;
  bFixed: boolean;
begin
  for i := 1 to NUM do
    for j := 1 to NUM do
    begin
      GTable.GetValue(i, j, value, bFixed);
      if bFixed then
        GBtnArray[i, j].Font.Color := GNumberColor
      else
        GBtnArray[i, j].Font.Color := GOtherNumberColor;
      GBtnArray[i, j].Caption := IntToStr(value);
    end;
  PaintBoxMain.Canvas.Pen.Color := GBackgroundColor;
  PaintBoxMain.Canvas.Rectangle(0, 0, PaintBoxMain.Width - 1,
    PaintBoxMain.Height - 1);
  UpdataPaintBox;
end;

procedure TFormMain.BtnSpeedClick(Sender: TObject);
var
  fConfig: TFormSpeed;
  bInitTime: boolean;
begin
  GOK := false;
  bInitTime := false;
  if Timer1.Enabled then
  begin
    bInitTime := true;
    Timer1.Enabled := false;
    Timer2.Enabled := false;
  end;
  try
    fConfig := TFormSpeed.Create(Self);
    fConfig.TrackBar1.Position := GSpeedOfComputing;
    fConfig.CBMaximum.Checked := GMaximumSpeed;
    if GMaximumSpeed then
      fConfig.lbValue.Caption := 'Maximum'
    else
      fConfig.lbValue.Caption := IntToStr(GSpeedOfComputing);
    fConfig.Left := Self.Left + Self.Width div 2 -
      fConfig.Width div 2;
    fConfig.Top := Self.Top + Self.Height div 2 -
      fConfig.Height div 2;
    fConfig.ShowModal;
    if bInitTime then
    begin
      Timer1.Enabled := true;
      Timer2.Enabled := true;
    end;
    if GOK then
    begin
      GSpeedOfComputing := fConfig.TrackBar1.Position;
      GMaximumSpeed := fConfig.CBMaximum.Checked;
      if GTable <> nil then
        GTable.Count := GSpeedOfComputing;
    end;
  finally
    FreeAndNil(fConfig);
  end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  i, j: Integer;
begin
  GBackgroundColor := RGB(100, 200, 100);
  GNumberColor := RGB(0, 0, 255);
  GOtherNumberColor := RGB(0, 0, 0);
  GMyPanelColor := RGB(0, 0, 0);
  PanelRight.Color := GBackgroundColor;
  PanelLeft.Color := GBackgroundColor;
  PanelClient.Color := GBackgroundColor;
  PanelControl.Color := GBackgroundColor;
  PanelRightLeft.Color := GBackgroundColor;
  PanelRightRight.Color := GBackgroundColor;
  PanelOther.Color := GBackgroundColor;
  PanelRightBottom.Color := GBackgroundColor;
  PaintBoxMain.Color := GBackgroundColor;
  GSpeedOfComputing := 0;
  GTime := 0;
  GMaximumSpeed := true;
  GRunning := false;
  GStop := false;
  GExtend := false;
  Self.Caption := STRCAPTION;
  Application.Title := STRCAPTION;
  GFlag := 0;
  for i := 1 to NUM do
    for j := 1 to NUM do
    begin
      GData[i, j].Value := 0;
      GData[i, j].fixed := false;
    end;
end;

procedure TFormMain.Timer1Timer(Sender: TObject);
begin
  inc(GTime);
  PanelRightBottom.Caption := 'Running... [Time: ' + IntToStr(GTime) + ']';
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if GRunning then
  begin
    Action := caNone;
    MessageBox(Self.Handle, 'Please stop caculating first!', 'Message', MB_OK);
  end;
end;

procedure TFormMain.Timer2Timer(Sender: TObject);
begin
  case GFlag of
    0:
      Self.Caption := STRCAPTION + ' - ¡ª';
    1:
      Self.Caption := STRCAPTION + ' - \';
    2:
      Self.Caption := STRCAPTION + ' - |';
    3:
      Self.Caption := STRCAPTION + ' - /';
  end;
  inc(GFlag);
  if GFlag > 3 then
    GFlag := 0;
end;

procedure TFormMain.UpdataPaintBox;
var
  i, j, number, value: Integer;
  bFixed: boolean;
begin
  if GTable = nil then
    exit;
  for i := 1 to NUM do
    for j := 1 to NUM do
    begin
      GTable.GetValue(i, j, value, bFixed);
      number := i * 10 + j;
      if bFixed then
        PaintBoxMain.Canvas.Pen.Color := GNumberColor
      else
        PaintBoxMain.Canvas.Pen.Color := GOtherNumberColor;
      if value <> 0 then
      begin
        PaintBoxMain.Canvas.MoveTo(0, number * AMPLIFYHEIGHT - LENHEIGHT);
        PaintBoxMain.Canvas.LineTo(value * AMPLIFYWIDTH,
          number * AMPLIFYHEIGHT - LENHEIGHT);
      end;
    end;
end;

procedure TFormMain.SBExtendClick(Sender: TObject);
begin
  GExtend := not GExtend;
  if GExtend then
  begin
    Self.Width := 585;
    SBExtend.Caption := '<<';
  end
  else
  begin
    Self.Width := 399;
    SBExtend.Caption := '>>';
  end;
end;

procedure TFormMain.PaintBoxMainPaint(Sender: TObject);
begin
  if GTable <> nil then
  begin
    UpdataPaintBox();
  end
  else
  begin
    PaintBoxMain.Canvas.Pen.Color := clBlack;
    PaintBoxMain.Canvas.Rectangle(0, 0, PaintBoxMain.Width - 1,
      PaintBoxMain.Height - 1);
  end;
end;

procedure TFormMain.FormActivate(Sender: TObject);
begin
  BtnRetryClick(nil);
end;

end.
