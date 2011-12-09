object fdocument: Tfdocument
  Left = 216
  Top = 305
  BorderStyle = bsDialog
  Caption = 'fdocument'
  ClientHeight = 258
  ClientWidth = 549
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
    Left = 8
    Top = 8
    Width = 377
    Height = 241
    OnMasterResult = masterMasterResult
  end
  object pPages: TPageControl
    Left = 159
    Top = 8
    Width = 373
    Height = 193
    ActivePage = TabSheet1
    TabOrder = 1
    Visible = False
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      object pStage0: TPanel
        Left = 3
        Top = 3
        Width = 361
        Height = 145
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 66
          Width = 164
          Height = 13
          Caption = #8470' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1074#1110#1076' '#1087#1086#1089#1090#1072#1095#1072#1083#1100#1085#1080#1082#1072
        end
        object Label11: TLabel
          Left = 8
          Top = 24
          Width = 26
          Height = 13
          Caption = #1044#1072#1090#1072
        end
        object Label2: TLabel
          Left = 8
          Top = 101
          Width = 69
          Height = 13
          Caption = #1050#1086#1076' '#1028#1044#1056#1055#1054#1059
        end
        object ed_number: TdxEdit
          Left = 178
          Top = 58
          Width = 175
          TabOrder = 1
          Text = 'ed_number'
          OnKeyDown = ed_documentKeyDown
          OnKeyPress = ed_documentKeyPress
          OnKeyUp = ed_documentKeyUp
          MaxLength = 50
          ReadOnly = False
          StyleController = scStyle
          StoredValues = 66
        end
        object ed_doc_date: TdxDateEdit
          Left = 40
          Top = 16
          Width = 105
          TabOrder = 0
          OnKeyDown = ed_documentKeyDown
          OnKeyPress = ed_documentKeyPress
          OnKeyUp = ed_documentKeyUp
          StyleController = scStyle
          Date = -700000.000000000000000000
        end
        object ed_EDRPOU: TdxEdit
          Left = 178
          Top = 93
          Width = 175
          TabOrder = 2
          Text = 'ed_number'
          OnKeyDown = ed_documentKeyDown
          OnKeyPress = ed_documentKeyPress
          OnKeyUp = ed_documentKeyUp
          MaxLength = 10
          ReadOnly = False
          StyleController = scStyle
          StoredValues = 66
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
  object trW: TIBTransaction
    DefaultDatabase = base
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 64
    Top = 112
  end
  object qW: TIBSQL
    Database = base
    Transaction = trW
    Left = 104
    Top = 112
  end
  object scStyle: TdxEditStyleController
    BorderColor = clBlack
    BorderStyle = xbsFlat
    ButtonStyle = btsFlat
    Left = 480
    Top = 8
  end
end
