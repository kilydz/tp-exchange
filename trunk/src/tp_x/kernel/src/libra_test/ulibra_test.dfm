object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #1057#1080#1085#1079#1088#1086#1085#1110#1079#1072#1094#1110#1103' '#1079' "'#1052#1040#1057#1057#1040'-'#1050'"'
  ClientHeight = 261
  ClientWidth = 474
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
  object Panel1: TPanel
    Left = 0
    Top = 220
    Width = 474
    Height = 41
    Align = alBottom
    TabOrder = 0
    object Button1: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = #1047#1072#1082#1088#1080#1090#1080
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 97
      Top = 8
      Width = 75
      Height = 25
      Caption = #1045#1082#1089#1087#1086#1088#1090
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 474
    Height = 220
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #1053#1072#1083#1072#1096#1090#1091#1074#1072#1085#1085#1103
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label1: TLabel
        Left = 3
        Top = 16
        Width = 25
        Height = 13
        Caption = #1055#1086#1088#1090
      end
      object Label2: TLabel
        Left = 3
        Top = 48
        Width = 39
        Height = 13
        Caption = #8470' '#1074#1072#1075#1080
      end
      object ed_port: TComboBox
        Left = 57
        Top = 13
        Width = 64
        Height = 21
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = 'COM1'
        Items.Strings = (
          'COM1'
          'COM2'
          'COM3'
          'COM4')
      end
      object ed_num: TComboBox
        Left = 57
        Top = 40
        Width = 64
        Height = 21
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 1
        Text = '22'
        Items.Strings = (
          '22'
          '28')
      end
      object ed_zero_prog: TCheckBox
        Left = 3
        Top = 75
        Width = 190
        Height = 17
        Caption = #1042#1082#1083#1102#1095#1085#1086' '#1079' '#1085#1091#1083#1100#1086#1074#1080#1084' '#1079#1072#1083#1080#1096#1082#1086#1084
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1051#1086#1075
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object ed_log: TMemo
        Left = 0
        Top = 0
        Width = 466
        Height = 192
        Align = alClient
        Lines.Strings = (
          'ed_log')
        TabOrder = 0
      end
    end
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
  object qR: TIBSQL
    Database = base
    Transaction = trR
    Left = 216
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
end
