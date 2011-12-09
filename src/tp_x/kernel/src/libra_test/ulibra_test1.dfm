object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 411
  ClientWidth = 553
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ed_log: TMemo
    Left = 0
    Top = 0
    Width = 553
    Height = 201
    Align = alTop
    Lines.Strings = (
      'ed_log')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 224
    Top = 371
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
  end
  object Button2: TButton
    Left = 8
    Top = 216
    Width = 537
    Height = 25
    Caption = 'Wip_CreateDevice | Wip_Setup | Wip_Connect'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button5: TButton
    Left = 8
    Top = 309
    Width = 177
    Height = 25
    Caption = 'Wip_GetFile'
    TabOrder = 3
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 8
    Top = 340
    Width = 177
    Height = 25
    Caption = 'Wip_Disconnect'
    TabOrder = 4
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 8
    Top = 371
    Width = 177
    Height = 25
    Caption = 'Wip_DestroyDevice'
    TabOrder = 5
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 191
    Top = 309
    Width = 122
    Height = 25
    Caption = 'send'
    TabOrder = 6
    OnClick = Button8Click
  end
  object Button3: TButton
    Left = 8
    Top = 264
    Width = 249
    Height = 25
    Caption = 'send_tovar'
    TabOrder = 7
    OnClick = Button3Click
  end
  object base: TIBDatabase
    DatabaseName = '127.0.0.1:D:\BASE\KRAJ.GDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    DefaultTransaction = trR
    Left = 152
    Top = 152
  end
  object trR: TIBTransaction
    DefaultDatabase = base
    Params.Strings = (
      'read'
      'consistency')
    Left = 184
    Top = 152
  end
  object qR: TIBSQL
    Database = base
    Transaction = trR
    Left = 216
    Top = 152
  end
end
