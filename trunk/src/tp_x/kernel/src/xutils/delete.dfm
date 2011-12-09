object fdelete: Tfdelete
  Left = 330
  Top = 473
  BorderStyle = bsToolWindow
  Caption = #1057#1090#1072#1090#1091#1089' '#1074#1080#1076#1072#1083#1077#1085#1085#1103
  ClientHeight = 240
  ClientWidth = 456
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ed_status: TMemo
    Left = 0
    Top = 0
    Width = 456
    Height = 201
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object bt_close: ZButton
    Left = 176
    Top = 207
    Width = 91
    Height = 25
    Caption = #1055#1088#1080#1081#1085#1103#1090#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 18
    Font.Name = 'Tahoma'
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 1
  end
  object base: TIBDatabase
    DatabaseName = 'd:\Base\Krajtop.gdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    DefaultTransaction = tr_W
    Left = 208
    Top = 24
  end
  object tr_W: TIBTransaction
    DefaultDatabase = base
    Params.Strings = (
      'write'
      'concurrency'
      'nowait')
    Left = 240
    Top = 24
  end
  object q_W: TIBSQL
    Database = base
    Transaction = tr_W
    Left = 272
    Top = 24
  end
end
