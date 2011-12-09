object fpricejournal: Tfpricejournal
  Left = 413
  Top = 173
  BorderStyle = bsSizeToolWin
  Caption = #1046#1091#1088#1085#1072#1083' '#1079#1084#1110#1085#1080' '#1094#1110#1085#1080
  ClientHeight = 399
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dxDBGrid1: TdxDBGrid
    Left = 0
    Top = 0
    Width = 505
    Height = 363
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    KeyField = 'ODATE_TIME'
    SummaryGroups = <>
    SummarySeparator = ', '
    Align = alClient
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    BandFont.Charset = DEFAULT_CHARSET
    BandFont.Color = clWindowText
    BandFont.Height = -11
    BandFont.Name = 'MS Sans Serif'
    BandFont.Style = []
    DataSource = ds
    Filter.Criteria = {00000000}
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'MS Sans Serif'
    HeaderFont.Style = [fsBold]
    OptionsBehavior = [edgoAutoSort, edgoDragScroll, edgoEnterShowEditor, edgoImmediateEditor, edgoTabThrough, edgoVertThrough]
    OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
    OptionsView = [edgoBandHeaderWidth, edgoRowSelect, edgoUseBitmap]
    PreviewFont.Charset = DEFAULT_CHARSET
    PreviewFont.Color = clBlue
    PreviewFont.Height = -11
    PreviewFont.Name = 'MS Sans Serif'
    PreviewFont.Style = []
    object dxDBGrid1ODATE_TIME: TdxDBGridDateColumn
      Alignment = taCenter
      Caption = #1044#1072#1090#1072'/'#1095#1072#1089' '#1079#1084#1110#1085#1080
      Width = 128
      BandIndex = 0
      RowIndex = 0
      FieldName = 'ODATE_TIME'
    end
    object dxDBGrid1OOUT_PRICE: TdxDBGridMaskColumn
      Alignment = taRightJustify
      Caption = #1062#1110#1085#1072' '#1088#1077#1072#1083#1110#1079'.'
      Width = 88
      BandIndex = 0
      RowIndex = 0
      FieldName = 'OOUT_PRICE'
    end
    object dxDBGrid1OUSER_NAME: TdxDBGridMaskColumn
      Alignment = taCenter
      Caption = #1042#1089#1090#1072#1085#1086#1074#1080#1074
      Width = 76
      BandIndex = 0
      RowIndex = 0
      FieldName = 'OUSER_NAME'
    end
    object dxDBGrid1ONAME: TdxDBGridMaskColumn
      Caption = #1055#1086#1074#1085#1077' '#1110#1084#39#1103
      Width = 187
      BandIndex = 0
      RowIndex = 0
      FieldName = 'ONAME'
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 363
    Width = 505
    Height = 36
    Align = alBottom
    TabOrder = 1
    object Label2: TLabel
      Left = 165
      Top = 7
      Width = 23
      Height = 21
      AutoSize = False
      Caption = ' '#1087#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 4
      Top = 7
      Width = 49
      Height = 21
      AutoSize = False
      Caption = #1055#1077#1088#1110#1086#1076' '#1079
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Date2: TdxDateEdit
      Left = 194
      Top = 6
      Width = 105
      Style.BorderStyle = xbsFlat
      Style.ButtonStyle = btsFlat
      TabOrder = 0
      Date = -700000.000000000000000000
      OnDateChange = Date1DateChange
    end
    object Date1: TdxDateEdit
      Left = 57
      Top = 7
      Width = 105
      Style.BorderStyle = xbsFlat
      Style.ButtonStyle = btsFlat
      TabOrder = 1
      Date = -700000.000000000000000000
      OnDateChange = Date1DateChange
    end
    object bt_ok: ZButton
      Left = 396
      Top = 6
      Width = 103
      Height = 25
      Caption = #1047#1072#1082#1088#1080#1090#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 18
      Font.Name = 'Tahoma'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 2
    end
  end
  object Base: TIBDatabase
    DatabaseName = '192.168.1.201:/BASE/KRAJ/KRAJ.GDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=keymaster'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    DefaultTransaction = tr
    Left = 216
    Top = 88
  end
  object q: TIBQuery
    Database = Base
    Transaction = tr
    SQL.Strings = (
      
        'select odate_time, oout_price, ouser_name, oname from ps_price_j' +
        'ournal(:d1, :d2, :nomen_id)')
    Left = 320
    Top = 88
    ParamData = <
      item
        DataType = ftString
        Name = 'd1'
        ParamType = ptUnknown
        Value = '01.08.2004'
      end
      item
        DataType = ftString
        Name = 'd2'
        ParamType = ptUnknown
        Value = '28.12.2005'
      end
      item
        DataType = ftInteger
        Name = 'nomen_id'
        ParamType = ptUnknown
        Value = '1'
      end>
    object qODATE_TIME: TDateTimeField
      FieldName = 'ODATE_TIME'
      Origin = '"PS_PRICE_JOURNAL"."ODATE_TIME"'
    end
    object qOOUT_PRICE: TFloatField
      FieldName = 'OOUT_PRICE'
      Origin = '"PS_PRICE_JOURNAL"."OOUT_PRICE"'
      DisplayFormat = '0.00'
    end
    object qOUSER_NAME: TIBStringField
      FieldName = 'OUSER_NAME'
      Origin = '"PS_PRICE_JOURNAL"."OUSER_NAME"'
      Size = 12
    end
    object qONAME: TIBStringField
      FieldName = 'ONAME'
      Origin = '"PS_PRICE_JOURNAL"."ONAME"'
      Size = 60
    end
  end
  object tr: TIBTransaction
    DefaultDatabase = Base
    Left = 248
    Top = 88
  end
  object ds: TDataSource
    DataSet = q
    Left = 352
    Top = 88
  end
end
