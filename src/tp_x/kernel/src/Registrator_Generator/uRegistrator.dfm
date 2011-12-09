object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1056#1077#1108#1089#1090#1088#1072#1090#1086#1088' '#1050#1086#1085#1082#1091#1088#1077#1085#1090'-'#1051' ('#1057#1082#1083#1072#1076')'
  ClientHeight = 330
  ClientWidth = 470
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 24
    Top = 16
    Width = 127
    Height = 13
    Caption = #1050#1086#1076' '#1097#1086' '#1074#1110#1076#1087#1088#1072#1074#1083#1103#1108#1090#1100#1089#1103' :'
  end
  object edShopCode: TMaskEdit
    Left = 24
    Top = 35
    Width = 256
    Height = 21
    CharCase = ecUpperCase
    ReadOnly = True
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 72
    Width = 281
    Height = 65
    Caption = #1056#1077#1108#1089#1090#1088#1072#1094#1110#1081#1085#1080#1081' '#1082#1086#1076': '
    TabOrder = 1
    object edCode: TMaskEdit
      Left = 16
      Top = 27
      Width = 255
      Height = 21
      CharCase = ecUpperCase
      EditMask = 'aaaa-aaaa-aaaa-aaaa-aaaa;1; '
      MaxLength = 24
      TabOrder = 0
      Text = '    -    -    -    -    '
    end
  end
  object Panel1: TPanel
    Left = 312
    Top = 0
    Width = 158
    Height = 152
    Align = alRight
    BevelOuter = bvLowered
    TabOrder = 2
    object ZButton1: ZButton
      Left = 15
      Top = 32
      Width = 130
      Height = 25
      Caption = #1047#1072#1088#1077#1108#1089#1090#1088#1091#1074#1072#1090#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 18
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
  object ed_contact: ThtmlLite
    Left = 0
    Top = 152
    Width = 470
    Height = 178
    OnHotSpotClick = ed_contactHotSpotClick
    TabOrder = 3
    Align = alBottom
    BorderStyle = htFocused
    HistoryMaxCount = 0
    DefFontName = 'Times New Roman'
    DefPreFontName = 'Courier New'
    NoSelect = False
    CharSet = DEFAULT_CHARSET
    htOptions = []
  end
end
