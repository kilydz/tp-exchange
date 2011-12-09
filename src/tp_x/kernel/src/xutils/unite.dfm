object funite: Tfunite
  Left = 440
  Top = 100
  BorderStyle = bsToolWindow
  Caption = #1054#1073#39#1108#1076#1085#1072#1090#1080' '#1079#1072#1087#1080#1089#1080
  ClientHeight = 413
  ClientWidth = 578
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 578
    Height = 369
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 0
    object ed_info_0: TdxMemo
      Left = 325
      Top = 0
      Width = 253
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      StyleController = scStyle
      Lines.Strings = (
        'ed_info_0')
      Height = 369
    end
    object Panel2: TPanel
      Left = 257
      Top = 0
      Width = 68
      Height = 369
      Align = alLeft
      BevelOuter = bvNone
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
      object bt_change: ZButton
        Left = 2
        Top = 163
        Width = 65
        Height = 25
        Caption = '<<>>'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 18
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = bt_changeClick
      end
    end
    object ed_info_1: TdxMemo
      Left = 0
      Top = 0
      Width = 257
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      StyleController = scStyle
      Lines.Strings = (
        'ed_info_1')
      Height = 369
    end
  end
  object ZButton1: ZButton
    Left = 115
    Top = 380
    Width = 123
    Height = 25
    Caption = #1054#1073#39#1108#1076#1085#1072#1090#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 18
    Font.Name = 'Tahoma'
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 1
  end
  object ZButton2: ZButton
    Left = 338
    Top = 380
    Width = 123
    Height = 25
    Caption = #1042#1110#1076#1084#1086#1074#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 18
    Font.Name = 'Tahoma'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 2
  end
  object scStyle: TdxEditStyleController
    BorderColor = clBlack
    BorderStyle = xbsFlat
    ButtonStyle = btsFlat
    Left = 184
    Top = 48
  end
  object base: TIBDatabase
    DatabaseName = 'd:\Base\Krajtop.gdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    DefaultTransaction = tr_R
    Left = 304
    Top = 56
  end
  object tr_W: TIBTransaction
    DefaultDatabase = base
    Params.Strings = (
      'write'
      'concurrency'
      'nowait')
    Left = 336
    Top = 88
  end
  object q_W: TIBSQL
    Database = base
    Transaction = tr_W
    Left = 368
    Top = 88
  end
  object tr_R: TIBTransaction
    DefaultDatabase = base
    Params.Strings = (
      'read'
      'read_committed'
      'rec_version'
      'nowait')
    Left = 336
    Top = 56
  end
  object q_R: TIBSQL
    Database = base
    Transaction = tr_R
    Left = 368
    Top = 56
  end
end
