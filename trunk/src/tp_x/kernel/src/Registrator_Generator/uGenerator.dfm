object Form2: TForm2
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1043#1077#1085#1077#1088#1072#1090#1086#1088' '#1050#1086#1085#1082#1091#1088#1077#1085#1090'-'#1051' '#1057#1082#1083#1072#1076
  ClientHeight = 226
  ClientWidth = 469
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 40
    Width = 64
    Height = 13
    Caption = #1044#1072#1090#1072' '#1089#1084#1077#1088#1090#1110':'
  end
  object Label2: TLabel
    Left = 24
    Top = 80
    Width = 141
    Height = 13
    Caption = #1050#1086#1076' '#1085#1072#1076#1110#1089#1083#1072#1085#1080#1081' '#1074#1110#1076' '#1082#1083#1110#1108#1085#1090#1072':'
  end
  object edDate: TDateTimePicker
    Left = 94
    Top = 36
    Width = 186
    Height = 21
    Date = 40296.494628043980000000
    Time = 40296.494628043980000000
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 144
    Width = 281
    Height = 65
    Caption = #1056#1077#1108#1089#1090#1088#1072#1094#1110#1081#1085#1080#1081' '#1082#1086#1076': '
    TabOrder = 1
    object edCode: TEdit
      Left = 16
      Top = 24
      Width = 256
      Height = 21
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = 'EDCODE'
    end
  end
  object edShopCode: TMaskEdit
    Left = 24
    Top = 99
    Width = 251
    Height = 21
    CharCase = ecUpperCase
    EditMask = 'aaaa-aaaa-aaaa-aaaa-aaaa;1; '
    MaxLength = 24
    TabOrder = 2
    Text = '    -    -    -    -    '
  end
  object Panel1: TPanel
    Left = 309
    Top = 0
    Width = 160
    Height = 226
    Align = alRight
    BevelOuter = bvLowered
    TabOrder = 3
    object BitBtn1: TBitBtn
      Left = 24
      Top = 35
      Width = 113
      Height = 25
      Caption = #1047#1075#1077#1085#1077#1088#1091#1074#1072#1090#1080
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
end
