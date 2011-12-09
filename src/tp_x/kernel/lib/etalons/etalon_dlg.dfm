object fetalon_dlg: Tfetalon_dlg
  Left = 47
  Top = 451
  BorderStyle = bsToolWindow
  Caption = 'fetalon_dlg'
  ClientHeight = 261
  ClientWidth = 858
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object master: ZMaster
    Left = 16
    Top = 8
    Width = 360
    Height = 225
    OnMasterResult = masterMasterResult
  end
  object p_pages: TPageControl
    Left = 400
    Top = 8
    Width = 425
    Height = 233
    TabOrder = 1
    Visible = False
  end
  object base: TIBDatabase
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
    DefaultDatabase = base
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 64
    Top = 80
  end
  object qR: TIBSQL
    Database = base
    Transaction = trR
    Left = 104
    Top = 80
  end
  object qW: TIBSQL
    Database = base
    Transaction = trW
    Left = 104
    Top = 112
  end
  object trW: TIBTransaction
    DefaultDatabase = base
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 64
    Top = 112
  end
  object scStyle: TdxEditStyleController
    BorderColor = clBlack
    BorderStyle = xbsFlat
    ButtonStyle = btsFlat
    Left = 168
    Top = 80
  end
end
