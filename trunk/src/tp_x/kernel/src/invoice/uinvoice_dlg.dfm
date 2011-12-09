object finvoice_dlg: Tfinvoice_dlg
  Left = 57
  Top = 117
  Caption = #1044#1088#1091#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
  ClientHeight = 280
  ClientWidth = 627
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object master: ZMaster
    Left = 16
    Top = 19
    Width = 377
    Height = 241
    OnMasterResult = masterMasterResult
  end
  object pPages: TPageControl
    Left = 209
    Top = 24
    Width = 390
    Height = 236
    ActivePage = TabSheet1
    TabOrder = 1
    Visible = False
    object TabSheet1: TTabSheet
      Caption = #1044#1088#1091#1082#1086#1074#1072#1085#1072' '#1092#1086#1088#1084#1072
      object pStage0: TPanel
        Left = 0
        Top = 19
        Width = 361
        Height = 153
        TabOrder = 0
        object p_main: TPanel
          Left = 1
          Top = 1
          Width = 359
          Height = 73
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label2: TLabel
            Left = 8
            Top = 19
            Width = 76
            Height = 13
            Caption = #1042#1080#1076' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
          end
          object Label1: TLabel
            Left = 8
            Top = 49
            Width = 33
            Height = 13
            Caption = #1042#1077#1088#1089#1110#1103
          end
          object ed_type_invoice: TdxImageEdit
            Left = 88
            Top = 12
            Width = 265
            TabOrder = 0
            Text = 'ed_type_invoice'
            StyleController = scStyle
            OnChange = ed_type_invoiceChange
            Descriptions.Strings = (
              '')
            ImageIndexes.Strings = (
              '0')
            Values.Strings = (
              '')
          end
          object ed_version: TdxImageEdit
            Left = 48
            Top = 43
            Width = 305
            TabOrder = 1
            Text = 'ed_version'
            StyleController = scStyle
          end
        end
        object p_period: TPanel
          Left = 1
          Top = 74
          Width = 359
          Height = 78
          Align = alClient
          BevelEdges = []
          BevelOuter = bvNone
          TabOrder = 1
          object Label3: TLabel
            Left = 16
            Top = 10
            Width = 10
            Height = 13
            Caption = #1047':'
          end
          object Label4: TLabel
            Left = 184
            Top = 10
            Width = 17
            Height = 13
            Caption = #1055#1086':'
          end
          object ed_date0: TdxDateEdit
            Left = 32
            Top = 2
            Width = 121
            TabOrder = 0
            StyleController = scStyle
            Date = -700000.000000000000000000
          end
          object ed_date1: TdxDateEdit
            Left = 207
            Top = 2
            Width = 114
            TabOrder = 1
            StyleController = scStyle
            Date = -700000.000000000000000000
          end
        end
      end
    end
  end
  object base: TIBDatabase
    DatabaseName = '192.168.1.2:/BASE/WWW/W3.GDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    DefaultTransaction = trR
    Left = 32
    Top = 120
  end
  object trR: TIBTransaction
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 64
    Top = 120
  end
  object qR: TIBSQL
    Database = base
    Transaction = trR
    Left = 104
    Top = 120
  end
  object qW: TIBSQL
    Database = base
    Transaction = trW
    Left = 104
    Top = 152
  end
  object trW: TIBTransaction
    DefaultDatabase = base
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 64
    Top = 152
  end
  object scStyle: TdxEditStyleController
    BorderColor = clBlack
    BorderStyle = xbsFlat
    ButtonStyle = btsFlat
    Left = 440
    Top = 8
  end
end
