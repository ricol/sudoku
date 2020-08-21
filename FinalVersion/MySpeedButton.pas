unit MySpeedButton;

interface

uses
  Messages, Windows, Buttons, Common;

type
  TMySpeedButton = class(TSpeedButton)
  private
    procedure ProcessMessage_WM_PAINT(var msg: Tmessage); message WM_PAINT;
  end;

implementation

{ TMySpeedButton }

procedure TMySpeedButton.ProcessMessage_WM_PAINT(var msg: Tmessage);
const
  NUM = 4;
begin
  inherited;
  Self.Canvas.Pen.Color := GMyPanelColor;
  Self.Canvas.MoveTo(0, 0);
  Self.Canvas.LineTo(Self.Width - NUM, 0);
  Self.Canvas.LineTo(Self.Width - NUM, Self.Height - NUM);
  Self.Canvas.LineTo(Self.Width - NUM, Self.Height - NUM);
  Self.Canvas.LineTo(0, Self.Height - NUM);
  Self.Canvas.LineTo(0, 0);
end;

end.
