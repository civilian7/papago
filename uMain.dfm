object frmMain: TfrmMain
  Left = 0
  Top = 0
  ActiveControl = eSource
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'PAPAGO Translate'
  ClientHeight = 342
  ClientWidth = 587
  Color = clBtnFace
  Font.Charset = HANGEUL_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #47569#51008' '#44256#46357
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 17
  object sbSwitch: TSpeedButton
    Left = 165
    Top = 13
    Width = 41
    Height = 28
    Caption = '--->'
    OnClick = sbSwitchClick
  end
  object lbSource: TLabel
    Left = 13
    Top = 42
    Width = 70
    Height = 17
    Caption = #48264#50669#54624' '#45236#50857
  end
  object lbTarget: TLabel
    Left = 13
    Top = 171
    Width = 70
    Height = 17
    Caption = #48264#50669#46108' '#45236#50857
  end
  object btnTranslate: TButton
    Left = 472
    Top = 300
    Width = 102
    Height = 27
    Caption = #48264#50669
    TabOrder = 6
    OnClick = btnTranslateClick
  end
  object eTarget: TMemo
    Left = 13
    Top = 194
    Width = 561
    Height = 98
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object eSource: TMemo
    Left = 13
    Top = 63
    Width = 561
    Height = 99
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object cbSource: TComboBox
    Left = 13
    Top = 14
    Width = 145
    Height = 25
    Style = csDropDownList
    DropDownCount = 13
    TabOrder = 0
  end
  object cbTarget: TComboBox
    Left = 213
    Top = 14
    Width = 145
    Height = 25
    Style = csDropDownList
    DropDownCount = 13
    TabOrder = 1
  end
  object cbMonitor: TCheckBox
    Left = 13
    Top = 310
    Width = 132
    Height = 17
    Caption = #53364#47549#48372#46300' '#47784#45768#53552#47553
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object btnClear: TButton
    Left = 365
    Top = 300
    Width = 102
    Height = 27
    Caption = #51648#50864#44592
    TabOrder = 5
    OnClick = btnClearClick
  end
end
