object FormMain: TFormMain
  Left = 266
  Top = 112
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'SuDoKu - RICOL'
  ClientHeight = 411
  ClientWidth = 393
  Color = clGradientActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PanelLeft: TPanel
    Left = 0
    Top = 0
    Width = 377
    Height = 411
    Align = alLeft
    BevelOuter = bvNone
    Color = clGradientActiveCaption
    ParentBackground = False
    TabOrder = 1
    object PanelClient: TPanel
      Left = 0
      Top = 0
      Width = 377
      Height = 370
      Align = alClient
      BevelOuter = bvNone
      Color = clGradientActiveCaption
      ParentBackground = False
      TabOrder = 0
    end
    object PanelControl: TPanel
      Left = 0
      Top = 370
      Width = 377
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      Color = clGradientActiveCaption
      ParentBackground = False
      TabOrder = 1
      object BtnRetry: TSpeedButton
        Left = 12
        Top = 9
        Width = 81
        Height = 25
        Caption = '&Retry'
        Flat = True
        OnClick = BtnRetryClick
      end
      object BtnOK: TSpeedButton
        Left = 102
        Top = 9
        Width = 81
        Height = 25
        Caption = '&Ok'
        Flat = True
        OnClick = BtnOKClick
      end
      object SpeedButton1: TSpeedButton
        Left = 193
        Top = 9
        Width = 81
        Height = 25
        Caption = '&Speed'
        Flat = True
        OnClick = BtnSpeedClick
      end
      object BtnHelp: TSpeedButton
        Left = 284
        Top = 9
        Width = 81
        Height = 25
        Caption = '&Help'
        Flat = True
        OnClick = BtnHelpClick
      end
    end
  end
  object PanelRight: TPanel
    Left = 377
    Top = 0
    Width = 16
    Height = 411
    Align = alClient
    BevelOuter = bvNone
    Color = clGradientActiveCaption
    ParentBackground = False
    TabOrder = 0
    object PanelRightLeft: TPanel
      Left = 0
      Top = 0
      Width = 16
      Height = 411
      Align = alLeft
      BevelOuter = bvNone
      Color = clGradientActiveCaption
      ParentBackground = False
      TabOrder = 0
      object SBExtend: TSpeedButton
        Left = -1
        Top = 184
        Width = 18
        Height = 22
        Caption = '>>'
        Flat = True
        OnClick = SBExtendClick
      end
    end
    object PanelRightRight: TPanel
      Left = 16
      Top = 0
      Width = 0
      Height = 411
      Align = alClient
      BevelOuter = bvNone
      Color = clGradientActiveCaption
      ParentBackground = False
      TabOrder = 1
      object PanelRightBottom: TPanel
        Left = 0
        Top = 370
        Width = 0
        Height = 41
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Running Status'
        Color = clGradientActiveCaption
        ParentBackground = False
        TabOrder = 0
      end
      object PanelOther: TPanel
        Left = 0
        Top = 0
        Width = 0
        Height = 370
        Align = alTop
        BevelOuter = bvNone
        Color = clGradientActiveCaption
        ParentBackground = False
        TabOrder = 1
        object PaintBoxMain: TPaintBox
          Left = 0
          Top = 0
          Width = 0
          Height = 370
          Align = alClient
          Color = clGradientActiveCaption
          ParentColor = False
          OnPaint = PaintBoxMainPaint
        end
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 136
    Top = 200
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 200
    OnTimer = Timer2Timer
    Left = 168
    Top = 200
  end
end
