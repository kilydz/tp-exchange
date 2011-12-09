object fdoc_filter: Tfdoc_filter
  Left = 677
  Top = 191
  Caption = 'fdoc_filter'
  ClientHeight = 452
  ClientWidth = 307
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object panel: TGroupBox
    Left = 24
    Top = 8
    Width = 217
    Height = 433
    Caption = ' '#1060#1110#1083#1100#1090#1088' '#1087#1086': '
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 185
      Width = 215
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object Splitter2: TSplitter
      Left = 1
      Top = 297
      Width = 215
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object Panel1: TPanel
      Left = 1
      Top = 400
      Width = 215
      Height = 32
      Align = alBottom
      TabOrder = 0
      object bt_ok: TButton
        Left = 3
        Top = 4
        Width = 75
        Height = 25
        Caption = #1055#1088#1080#1081#1085#1103#1090#1080
        TabOrder = 0
        OnClick = bt_okClick
      end
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 14
      Width = 215
      Height = 171
      Align = alTop
      Caption = ' '#1090#1080#1087#1072#1084' '#1076#1086#1082#1091#1084#1077#1085#1090#1110#1074' '
      TabOrder = 1
      object ed_typedoc: ZFilterCombo
        Left = 1
        Top = 14
        Width = 213
        Height = 156
        Align = alClient
        BevelInner = bvNone
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        OnClick = ed_typedocClick
      end
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 188
      Width = 215
      Height = 109
      Align = alTop
      Caption = ' '#1090#1080#1087#1072#1084' '#1087#1088#1086#1087#1083#1072#1090#1080
      TabOrder = 2
      object ed_typepay: ZFilterCombo
        Left = 1
        Top = 14
        Width = 213
        Height = 94
        Align = alClient
        BevelInner = bvNone
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        OnClick = ed_typedocClick
      end
    end
    object GroupBox3: TGroupBox
      Left = 1
      Top = 300
      Width = 215
      Height = 100
      Align = alClient
      Caption = #1089#1090#1072#1085#1072#1084' '#1087#1088#1086#1087#1083#1072#1090#1080' '
      TabOrder = 3
      object ed_oplata_state: ZFilterCombo
        Left = 1
        Top = 14
        Width = 213
        Height = 85
        Align = alClient
        BevelInner = bvNone
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        OnClick = ed_typedocClick
      end
    end
  end
  object base: TIBDatabase
    DatabaseName = '192.168.0.5:/BASE/SOFTWEST/KRAJ.GDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    DefaultTransaction = tr
    Left = 48
    Top = 64
  end
  object tr: TIBTransaction
    DefaultDatabase = base
    Params.Strings = (
      'read'
      'read_committed'
      'rec_version'
      'nowait')
    Left = 88
    Top = 64
  end
  object q: TIBSQL
    Database = base
    Transaction = tr
    Left = 120
    Top = 64
  end
end
