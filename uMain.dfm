object frmMain: TfrmMain
  Left = 0
  Top = 0
  ActiveControl = eSource
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'PAPAGO Translate'
  ClientHeight = 319
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
    Top = 160
    Width = 70
    Height = 17
    Caption = #48264#50669#46108' '#45236#50857
  end
  object btnTranslate: TButton
    Left = 472
    Top = 281
    Width = 102
    Height = 27
    Caption = #48264#50669
    TabOrder = 5
    OnClick = btnTranslateClick
  end
  object eTarget: TMemo
    Left = 13
    Top = 183
    Width = 561
    Height = 88
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object eSource: TMemo
    Left = 13
    Top = 63
    Width = 561
    Height = 89
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
  object cbCopyToClipboard: TCheckBox
    Left = 13
    Top = 287
    Width = 220
    Height = 17
    Caption = #48264#50669#51060' '#50756#47308#46104#47732' '#53364#47549#48372#46300#50640' '#48373#49324
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
end
