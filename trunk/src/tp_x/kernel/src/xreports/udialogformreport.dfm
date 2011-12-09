object report_dialog_form: Treport_dialog_form
  Left = 235
  Top = 431
  BorderStyle = bsToolWindow
  Caption = #1047#1074#1110#1090
  ClientHeight = 303
  ClientWidth = 281
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 232
    Width = 281
    Height = 71
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object ch_OLAP: TdxCheckEdit
      Left = 22
      Top = 6
      Width = 121
      TabOrder = 0
      Caption = 'OLAP '#1088#1077#1078#1080#1084
    end
    object bt_cancel: ZButton
      Left = 152
      Top = 33
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
      OnClick = btnCancelClick
    end
    object bt_ok: ZButton
      Left = 22
      Top = 33
      Width = 103
      Height = 25
      Caption = #1042#1080#1082#1086#1085#1072#1090#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 18
      Font.Name = 'Tahoma'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 2
      Blink = True
    end
  end
  object pTop: TPanel
    Left = 0
    Top = 0
    Width = 281
    Height = 25
    Align = alTop
    BevelOuter = bvLowered
    Caption = #1056#1077#1108#1089#1090#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1110#1074
    Color = clGray
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object DialogPanel: TPanel
    Left = 0
    Top = 25
    Width = 281
    Height = 207
    Align = alClient
    TabOrder = 2
  end
  object base: TIBDatabase
    DefaultTransaction = tr
    Left = 16
    Top = 40
  end
  object tr: TIBTransaction
    DefaultDatabase = base
    Params.Strings = (
      'read'
      'read_committed'
      'rec_version'
      'nowait')
    AutoStopAction = saCommit
    Left = 104
    Top = 40
  end
  object q: TIBSQL
    Database = base
    Transaction = tr
    Left = 56
    Top = 40
  end
end
