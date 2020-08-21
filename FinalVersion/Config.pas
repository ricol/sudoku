unit Config;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons;

type
  TFormSpeed = class(TForm)
    TrackBar1: TTrackBar;
    CBMaximum: TCheckBox;
    lbValue: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    BtnOK: TSpeedButton;
    BtnCancel: TSpeedButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure CBMaximumClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure RePosition();
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  Common;

procedure TFormSpeed.BitBtn1Click(Sender: TObject);
begin
  GOK := true;
  Self.Close;
end;

procedure TFormSpeed.BitBtn2Click(Sender: TObject);
begin
  GOK := false;
  Self.Close;
end;

procedure TFormSpeed.CBMaximumClick(Sender: TObject);
begin
  TrackBar1.Enabled := not CBMaximum.Checked;
  if CBMaximum.Checked then
  begin
    TrackBar1.SliderVisible := false;
    lbValue.Caption := 'Maximum';
    RePosition;
  end
  else
  begin
    TrackBar1.SliderVisible := true;
    lbValue.Caption := IntToStr(TrackBar1.Position);
    RePosition;
  end;
end;

procedure TFormSpeed.RePosition;
begin
  lbValue.Left := Label1.Left + Label1.Width +
    (Label2.Left - Label1.Left - Label1.Width) div 2 - lbValue.Width div 2;
end;

procedure TFormSpeed.TrackBar1Change(Sender: TObject);
begin
  lbValue.Caption := IntToStr(TrackBar1.Position);
  RePosition;
end;

procedure TFormSpeed.FormActivate(Sender: TObject);
begin
  RePosition;
end;

procedure TFormSpeed.FormCreate(Sender: TObject);
begin
  Self.Color := GBackgroundColor;
end;

end.
