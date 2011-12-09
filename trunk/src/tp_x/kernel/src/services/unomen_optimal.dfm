object fnomen_optimal: Tfnomen_optimal
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1054#1087#1090#1080#1084#1110#1079#1072#1094#1110#1103' '#1072#1089#1086#1088#1090#1080#1084#1077#1085#1090#1091
  ClientHeight = 272
  ClientWidth = 459
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 9
    Top = 17
    Width = 94
    Height = 13
    Caption = #1050'-'#1090#1100' '#1076#1085#1110#1074' '#1073#1077#1079' '#1088#1091#1093#1091
  end
  object Label2: TLabel
    Left = 210
    Top = 17
    Width = 32
    Height = 13
    Caption = #1056#1077#1078#1080#1084
  end
  object ed_termin: TdxSpinEdit
    Left = 113
    Top = 9
    Width = 71
    TabOrder = 0
    StyleController = scStyle
    MaxValue = 360.000000000000000000
    MinValue = 30.000000000000000000
    Value = 90.000000000000000000
    StoredValues = 48
  end
  object ed_log: TdxMemo
    Left = 0
    Top = 36
    Width = 459
    Align = alBottom
    TabOrder = 1
    StyleController = scStyle
    Lines.Strings = (
      'ed_log')
    ScrollBars = ssVertical
    Height = 188
  end
  object Panel1: TPanel
    Left = 0
    Top = 241
    Width = 459
    Height = 31
    Align = alBottom
    TabOrder = 2
    object ZButton1: ZButton
      Left = 4
      Top = 3
      Width = 75
      Height = 25
      Caption = #1047#1072#1082#1088#1080#1090#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 18
      Font.Name = 'Tahoma'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 0
    end
    object bt_optimization: ZButton
      Left = 85
      Top = 3
      Width = 220
      Height = 25
      Caption = #1054#1087#1090#1080#1084#1110#1079#1091#1074#1072#1090#1080' '#1072#1089#1086#1088#1090#1080#1084#1077#1085#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 18
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = bt_optimizationClick
      Blink = True
    end
  end
  object progress: TProgressBar
    Left = 0
    Top = 224
    Width = 459
    Height = 17
    Align = alBottom
    TabOrder = 3
  end
  object ed_mode: TdxImageEdit
    Left = 248
    Top = 9
    Width = 196
    Style.BorderStyle = xbsFlat
    Style.ButtonStyle = btsFlat
    TabOrder = 4
    Text = '0'
    Descriptions.Strings = (
      #1053#1077#1074#1080#1076#1080#1084#1110' ('#1103#1082#1097#1086' '#1079#1072#1083#1080#1096#1086#1082' = 0)'
      #1053#1077#1072#1082#1090#1080#1074#1085#1110' ('#1103#1082#1097#1086' '#1079#1072#1083#1080#1096#1086#1082' > 0)')
    ImageIndexes.Strings = (
      '0'
      '1')
    Values.Strings = (
      '0'
      '1')
  end
  object base: TIBDatabase
    DatabaseName = '192.168.1.2:/BASE/WWW/W3.GDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    DefaultTransaction = trR
    Left = 32
    Top = 80
  end
  object trR: TIBTransaction
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 64
    Top = 80
  end
  object trW: TIBTransaction
    DefaultDatabase = base
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 64
    Top = 112
  end
  object qW: TIBSQL
    Database = base
    Transaction = trW
    Left = 104
    Top = 112
  end
  object qR: TIBSQL
    Database = base
    Transaction = trR
    Left = 104
    Top = 80
  end
  object scStyle: TdxEditStyleController
    BorderColor = clBlack
    BorderStyle = xbsFlat
    ButtonStyle = btsFlat
    Left = 168
    Top = 80
  end
end
