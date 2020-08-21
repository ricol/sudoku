program SuDuKu;

uses
  Forms,
  UnitMain in 'UnitMain.pas' {FormMain},
  UnitCommon in 'UnitCommon.pas',
  UnitTStack in 'UnitTStack.pas',
  UnitTTable in 'UnitTTable.pas',
  UnitTMySpeedButton in 'UnitTMySpeedButton.pas',
  UnitConfig in 'UnitConfig.pas' {FormSpeed},
  UnitAbout in 'UnitAbout.pas' {FormAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.

