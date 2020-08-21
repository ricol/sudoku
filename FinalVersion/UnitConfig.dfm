object FormSpeed: TFormSpeed
  Left = 430
  Top = 234
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Speed'
  ClientHeight = 87
  ClientWidth = 297
  Color = clGradientActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbValue: TLabel
    Left = 83
    Top = 6
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label1: TLabel
    Left = 16
    Top = 6
    Width = 20
    Height = 13
    Caption = 'Low'
  end
  object Label2: TLabel
    Left = 160
    Top = 6
    Width = 22
    Height = 13
    Caption = 'High'
  end
  object BtnOK: TSpeedButton
    Left = 214
    Top = 14
    Width = 75
    Height = 25
    Caption = '&Ok'
    Flat = True
    OnClick = BitBtn1Click
  end
  object BtnCancel: TSpeedButton
    Left = 214
    Top = 45
    Width = 75
    Height = 25
    Caption = '&Cancel'
    Flat = True
    OnClick = BitBtn2Click
  end
  object TrackBar1: TTrackBar
    Left = 8
    Top = 22
    Width = 185
    Height = 33
    LineSize = 1000
    PageSize = 1
    Position = 1
    TabOrder = 0
    OnChange = TrackBar1Change
  end
  object CBMaximum: TCheckBox
    Left = 16
    Top = 62
    Width = 169
    Height = 17
    Caption = 'Maximum Speed Of Computing'
    TabOrder = 1
    OnClick = CBMaximumClick
  end
end
