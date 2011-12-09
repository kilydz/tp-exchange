object fetalon_log: Tfetalon_log
  Left = 0
  Top = 0
  Caption = 'fetalon_log'
  ClientHeight = 341
  ClientWidth = 416
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ed_log: TdxMemo
    Left = 0
    Top = 0
    Width = 416
    Align = alClient
    TabOrder = 0
    ReadOnly = True
    ScrollBars = ssBoth
    ExplicitTop = -6
    Height = 292
    StoredValues = 64
  end
  object Panel1: TPanel
    Left = 0
    Top = 309
    Width = 416
    Height = 32
    Align = alBottom
    BevelOuter = bvSpace
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    ExplicitLeft = -109
    ExplicitTop = 286
    ExplicitWidth = 472
    object bt_cancel: ZButton
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
  end
  object l_pos: TProgressBar
    Left = 0
    Top = 292
    Width = 416
    Height = 17
    Align = alBottom
    TabOrder = 2
    ExplicitLeft = 128
    ExplicitTop = 264
    ExplicitWidth = 150
  end
  object t_start: TTimer
    Enabled = False
    OnTimer = t_startTimer
    Left = 96
    Top = 88
  end
  object base: TIBDatabase
    DatabaseName = '192.168.1.2:/BASE/WWW/W3.GDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    DefaultTransaction = trR
    Left = 104
    Top = 24
  end
  object trR: TIBTransaction
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 136
    Top = 24
  end
  object qR: TIBSQL
    Database = base
    Transaction = trR
    Left = 176
    Top = 24
  end
  object trW: TIBTransaction
    DefaultDatabase = base
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 136
    Top = 56
  end
  object qW: TIBSQL
    Database = base
    Transaction = trW
    Left = 176
    Top = 56
  end
end
