program SuDuKu;

uses
  Forms,
  Main in 'Main.pas' {FormMain},
  Common in 'Common.pas',
  uStack in 'uStack.pas',
  uTable in 'uTable.pas',
  MySpeedButton in 'MySpeedButton.pas',
  Config in 'Config.pas' {FormSpeed},
  About in 'About.pas' {FormAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.

