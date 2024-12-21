object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'ROM Extractor (for KONAMI ANTIQUES MSX COLLECTION)'
  ClientHeight = 320
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 30
  object lblStateSaveFile: TLabel
    Left = 16
    Top = 20
    Width = 134
    Height = 30
    Caption = '&State Save file:'
    FocusControl = edStateSaveFile
  end
  object lblStartAddress: TLabel
    Left = 16
    Top = 112
    Width = 127
    Height = 30
    Caption = 'Start &Address:'
    FocusControl = stStartAddress
  end
  object edStateSaveFile: TEdit
    Left = 16
    Top = 56
    Width = 550
    Height = 38
    TabOrder = 0
  end
  object btnStateSaveFile: TButton
    Left = 572
    Top = 56
    Width = 46
    Height = 38
    Caption = #8230
    TabOrder = 1
    OnClick = btnStateSaveFileClick
  end
  object rgRomSize: TRadioGroup
    Left = 16
    Top = 160
    Width = 289
    Height = 140
    Caption = '&ROM Size'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      '16KB'
      '32KB'
      '64KB'
      '128KB'
      '256KB')
    TabOrder = 3
  end
  object btnExtract: TButton
    Left = 500
    Top = 210
    Width = 120
    Height = 40
    Caption = '&Extract'
    TabOrder = 5
    OnClick = btnExtractClick
  end
  object btnExit: TButton
    Left = 500
    Top = 260
    Width = 120
    Height = 40
    Caption = 'E&xit'
    TabOrder = 6
    OnClick = btnExitClick
  end
  object stStartAddress: TStaticText
    Left = 149
    Top = 112
    Width = 103
    Height = 34
    Caption = '< NONE >'
    TabOrder = 2
  end
  object btnSearch: TButton
    Left = 500
    Top = 160
    Width = 120
    Height = 40
    Caption = 'Sear&ch'
    TabOrder = 4
    OnClick = btnSearchClick
  end
  object fodStateSaveFile: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = []
    Left = 564
    Top = 12
  end
end
