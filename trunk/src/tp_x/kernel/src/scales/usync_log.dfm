object fsync_log: Tfsync_log
  Left = 0
  Top = 0
  Caption = #1051#1086#1075' '#1089#1080#1085#1093#1088#1086#1085#1110#1079#1072#1094#1110#1111
  ClientHeight = 383
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 351
    Width = 634
    Height = 32
    Align = alBottom
    BevelOuter = bvSpace
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object bt_ok: ZButton
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
      ModalResult = 2
      ParentFont = False
      TabOrder = 0
    end
    object bt_go: ZButton
      Left = 86
      Top = 3
      Width = 155
      Height = 25
      Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 18
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = bt_goClick
    end
  end
  object ed_log: TdxMemo
    Left = 0
    Top = 0
    Width = 634
    Align = alClient
    TabOrder = 1
    ReadOnly = True
    ScrollBars = ssBoth
    Height = 351
    StoredValues = 64
  end
  object base: TIBDatabase
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    DefaultTransaction = tr_R
    Left = 32
    Top = 88
  end
  object tr_R: TIBTransaction
    DefaultDatabase = base
    Params.Strings = (
      'read'
      'read_committed'
      'rec_version'
      'nowait')
    Left = 72
    Top = 88
  end
  object q_R: TIBSQL
    Database = base
    Transaction = tr_R
    Left = 104
    Top = 88
  end
end
