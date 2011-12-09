object fcreate_like: Tfcreate_like
  Left = 243
  Top = 119
  AutoSize = True
  Caption = #1055#1077#1088#1077#1090#1074#1086#1088#1077#1085#1085#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1110#1074
  ClientHeight = 201
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
  object ed_info_0: TdxMemo
    Left = 0
    Top = 0
    Width = 578
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    StyleController = scStyle
    Lines.Strings = (
      'ed_info_0')
    Height = 168
  end
  object Panel1: TPanel
    Left = 0
    Top = 168
    Width = 578
    Height = 33
    Align = alTop
    TabOrder = 0
    object ed_types_convert: TdxImageEdit
      Left = 7
      Top = 6
      Width = 348
      TabOrder = 0
      Text = 'ed_types_convert'
      StyleController = scStyle
    end
    object bt_ok: ZButton
      Left = 470
      Top = 4
      Width = 103
      Height = 25
      Caption = #1055#1110#1076#1090#1074#1077#1088#1076#1080#1090#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 18
      Font.Name = 'Tahoma'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 2
    end
    object bt_cancel: ZButton
      Left = 361
      Top = 4
      Width = 105
      Height = 25
      Caption = #1042#1110#1076#1084#1110#1085#1080#1090#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 18
      Font.Name = 'Tahoma'
      Font.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 1
    end
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
  object q_W: TIBSQL
    Database = base
    Transaction = tr_W
    Left = 368
    Top = 88
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
end
