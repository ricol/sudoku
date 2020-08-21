unit UnitAbout;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, jpeg;

type
  TFormAbout = class(TForm)
    Bevel1: TBevel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblMailTo: TLabel;
    SpeedButton1: TSpeedButton;
    procedure lblMailToClick(Sender: TObject);
    procedure lblMailToMouseEnter(Sender: TObject);
    procedure lblMailToMouseLeave(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  ShellAPI, UnitCommon;

procedure TFormAbout.FormCreate(Sender: TObject);
begin
  Self.Color := GBackgroundColor;
end;

procedure TFormAbout.lblMailToClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, PChar('open'),
    PChar('mailto: wangxinghe1983@gmail.com'), nil, nil, SW_NORMAL);
end;

procedure TFormAbout.lblMailToMouseEnter(Sender: TObject);
begin
  lblMailTo.Font.Color := clRed;
end;

procedure TFormAbout.lblMailToMouseLeave(Sender: TObject);
begin
  lblMailTo.Font.Color := clBlack;
end;

procedure TFormAbout.SpeedButton1Click(Sender: TObject);
begin
  Self.Close;
end;

end.
