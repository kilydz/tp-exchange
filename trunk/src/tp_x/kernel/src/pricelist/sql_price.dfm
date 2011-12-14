object fsql_price: Tfsql_price
  Left = 509
  Top = 123
  BorderStyle = bsToolWindow
  Caption = #1044#1088#1091#1082' '#1094#1110#1085#1085#1080#1082#1110#1074' '#1087#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
  ClientHeight = 431
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pBottom: TPanel
    Left = 0
    Top = 396
    Width = 640
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object bt_cancel: ZButton
      Left = 421
      Top = 6
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
      TabOrder = 0
    end
    object bt_ok: ZButton
      Left = 532
      Top = 5
      Width = 103
      Height = 25
      Caption = #1055#1110#1076#1090#1074#1077#1088#1076#1080#1090#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 18
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnPrintClick
      Blink = True
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 25
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 3
      Top = 6
      Width = 72
      Height = 13
      Caption = #1058#1080#1087' '#1094#1110#1085#1085#1080#1082#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ed_price_type: TdxImageEdit
      Left = 105
      Top = 2
      Width = 375
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Style.BorderStyle = xbsFlat
      Style.ButtonStyle = btsFlat
      TabOrder = 0
      Text = '0'
      Descriptions.Strings = (
        #1052#1072#1083#1077#1085#1100#1082#1110' '#1094#1110#1085#1085#1080#1082#1080
        #1062#1110#1085#1085#1080#1082' '#1040'5'
        #1062#1110#1085#1085#1080#1082' '#1040'4'
        #1055#1077#1088#1077#1086#1094#1110#1085#1082#1072' '#1040'5'
        #1055#1077#1088#1077#1086#1094#1110#1085#1082#1072' '#1040'4'
        #1044#1083#1103' '#1084#1086#1088#1086#1079#1080#1083#1100#1085#1080#1082#1110#1074
        #1050#1086#1084#1110#1095#1085#1080#1081' '#1089#1090#1080#1083#1100' ('#1073#1077#1079' '#1079#1085#1080#1078#1082#1080')'
        #1050#1086#1084#1110#1095#1085#1080#1081' '#1089#1090#1080#1083#1100' '#1040'5 ('#1073#1077#1079' '#1079#1085#1080#1078#1082#1080')'
        #1050#1086#1084#1110#1095#1085#1080#1081' '#1089#1090#1080#1083#1100' '#1040'4 ('#1073#1077#1079' '#1079#1085#1080#1078#1082#1080')')
      ImageIndexes.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8')
      Values.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8')
    end
  end
  object g_dic: TdxDBGrid
    Left = 0
    Top = 25
    Width = 640
    Height = 371
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    KeyField = 'id'
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
    PopupMenu = mi_popup
    TabOrder = 2
    BandFont.Charset = DEFAULT_CHARSET
    BandFont.Color = clWindowText
    BandFont.Height = -11
    BandFont.Name = 'MS Sans Serif'
    BandFont.Style = []
    DataSource = ds_dic
    Filter.Criteria = {00000000}
    HeaderFont.Charset = RUSSIAN_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -13
    HeaderFont.Name = 'Times New Roman'
    HeaderFont.Style = [fsBold]
    LookAndFeel = lfUltraFlat
    OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
    OptionsView = [edgoAutoWidth, edgoBandHeaderWidth, edgoInvertSelect, edgoUseBitmap]
    PreviewFont.Charset = DEFAULT_CHARSET
    PreviewFont.Color = clBlue
    PreviewFont.Height = -11
    PreviewFont.Name = 'MS Sans Serif'
    PreviewFont.Style = []
    object g_dicid: TdxDBGridMaskColumn
      DisableEditor = True
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'id'
    end
    object g_dicnomen_id: TdxDBGridMaskColumn
      DisableEditor = True
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'nomen_id'
    end
    object g_dicnomen_code: TdxDBGridMaskColumn
      Caption = #1050#1086#1076' '#1090#1086#1074#1072#1088#1091
      DisableEditor = True
      BandIndex = 0
      RowIndex = 0
      FieldName = 'nomen_code'
    end
    object g_dicnomen_name: TdxDBGridMaskColumn
      Caption = #1053#1072#1079#1074#1072' '#1090#1086#1074#1072#1088#1091
      DisableEditor = True
      BandIndex = 0
      RowIndex = 0
      FieldName = 'nomen_name'
    end
    object g_dicoutprice: TdxDBGridMaskColumn
      Caption = #1062#1110#1085#1072' '#1088#1077#1072#1083#1110#1079#1072#1094#1110#1111
      DisableEditor = True
      BandIndex = 0
      RowIndex = 0
      FieldName = 'outprice'
    end
    object g_dicprint_it: TdxDBGridCheckColumn
      Caption = #1044#1088#1091#1082#1091#1074#1072#1090#1080' '#1094#1110#1085#1085#1080#1082
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'print_it'
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object g_dicis_in_discount: TdxDBGridCheckColumn
      Caption = #1047#1110' '#1079#1085#1080#1078#1082#1086#1102
      Visible = False
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'is_in_discount'
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object g_diccnt: TdxDBGridMaskColumn
      Caption = #1050'-'#1090#1100' '#1094#1110#1085#1085#1080#1082#1110#1074
      BandIndex = 0
      RowIndex = 0
      FieldName = 'cnt'
    end
  end
  object base: TIBDatabase
    DatabaseName = '192.168.0.223:tp_svn'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    Left = 32
    Top = 88
  end
  object ds_dic: TDataSource
    DataSet = mem_dic
    Left = 208
    Top = 128
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
  object tr_W: TIBTransaction
    DefaultDatabase = base
    Params.Strings = (
      'write'
      'concurrency'
      'nowait')
    Left = 72
    Top = 120
  end
  object q_W: TIBSQL
    Database = base
    Transaction = tr_W
    Left = 104
    Top = 120
  end
  object mem_dic: TRxMemoryData
    FieldDefs = <>
    Left = 176
    Top = 128
    object mem_dicid: TIntegerField
      FieldName = 'id'
    end
    object mem_dicnomen_id: TIntegerField
      FieldName = 'nomen_id'
    end
    object mem_dicnomen_code: TStringField
      FieldName = 'nomen_code'
      Size = 7
    end
    object mem_dicnomen_name: TStringField
      FieldName = 'nomen_name'
      Size = 40
    end
    object mem_dicoutprice: TFloatField
      FieldName = 'outprice'
      DisplayFormat = '0.00'
    end
    object mem_dicis_in_discount: TIntegerField
      FieldName = 'is_in_discount'
    end
    object mem_dicprint_it: TIntegerField
      FieldName = 'print_it'
    end
    object mem_diccnt: TIntegerField
      FieldName = 'cnt'
    end
  end
  object mem_print: TRxMemoryData
    FieldDefs = <
      item
        Name = 'CODE_WARES'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NAME_WARES'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'NAME_WARES_RECEIPT'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'PRICE_DEALER'
        DataType = ftFloat
      end
      item
        Name = 'DEFAULT_BARCODE'
        DataType = ftString
        Size = 30
      end>
    Left = 176
    Top = 184
    object mem_printID: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'ID'
      Calculated = True
    end
    object mem_printCODE_WARES: TIntegerField
      FieldName = 'CODE_WARES'
      Required = True
    end
    object mem_printNAME_WARES: TStringField
      FieldName = 'NAME_WARES'
      Size = 100
    end
    object mem_printNAME_WARES_RECEIPT: TStringField
      FieldName = 'NAME_WARES_RECEIPT'
      Size = 50
    end
    object mem_printPRICE_DEALER: TFloatField
      FieldName = 'PRICE_DEALER'
      DisplayFormat = '0.00'
      EditFormat = '0.00'
    end
    object mem_printDEFAULT_BARCODE: TStringField
      FieldName = 'DEFAULT_BARCODE'
      Size = 30
    end
  end
  object base_frf: TfrDBDataSet
    DataSet = mem_print
    OpenDataSource = False
    Left = 288
    Top = 192
  end
  object report_frf: TfrReport
    Dataset = base_frf
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit, pbPageSetup]
    StoreInDFM = True
    OnUserFunction = report_frfUserFunction
    Left = 320
    Top = 192
    ReportForm = {
      180000002A07000018FFFF000001000100FFFFFFFFFF09000000340800009A0B
      00000000000000000000000000000000000000000000000000FFFF0100000000
      000000000500506167653100030400466F726D000F000080DC00000078000000
      7C0100002C010000040000000200D00000000C005265706F72745469746C6531
      0002010000000014000000F50200000A00000030000000010000000000000000
      00FFFFFF1F00000000000000000000000000FFFF000000000002000000010000
      000000000001000000C800000014000000010000000000000200470100000B00
      4D617374657244617461310002010000000024000000F5020000E60100003000
      050001000000000000000000FFFFFF1F000000000C0066724442446174615365
      743100000000000000FFFF000000000002000000010000000000000001000000
      C800000014000000010000000000000000D90100000900515244425465787436
      00020015010000D4000000620000004D00000000000000010000000000000000
      00FFFFFF1F2C000401020030300001000E005B7143696E2E225244454350225D
      00000000FFFF00000000000200000001000000000500417269616C0037000000
      02000800008000000000CC00020000000000FFFFFF0000000002000000000000
      0000007902000009005152444254657874310002001900000030000000530200
      007F0000000200000001000000000000000000FFFFFF1F2C0000000000000100
      14005B7143696E2E22524E4F4D454E5F4E414D45225D00000000FFFF00000000
      000200000001000000000F0054696D6573204E657720526F6D616E0028000000
      02000800008002000000CC00020000000000FFFFFF0000000002000000000000
      00000009030000090051524442546578743300020019000000CC000000FC0000
      00950000000000000001000000000000000000FFFFFF1F2C0001010000000100
      0E005B7143696E2E2252494E5450225D00000000FFFF00000000000200000001
      000000000500417269616C006400000002000800008001000000010002000000
      0000FFFFFF0000000002000000000000000A0E00546672426172436F64655669
      65770000960300000400426172310002006A020000900100004F000000180000
      000100000001000000000000000000FFFFFF1F2C020000000000010014005B71
      5065722E22524E4F4D454E5F434F4445225D00000000FFFF0000000000020000
      0001000000000101000701000000000000000000004000000000000000000000
      3804000005004D656D6F3100020061010000E9000000100100009D0000000000
      000001000000000000000000FFFFFF1F2C000101000000010024005B696E745F
      70617274285B7143696E2E22524F55545052494345225D2C20302E3935295D00
      000000FFFF00000000000200000001000000000500417269616C007800000002
      0008000080010000000100020000000000FFFFFF000000000200000000000000
      0000DC04000005004D656D6F3200020069020000FB0000006200000051000000
      0000000001000000000000000000FFFFFF1F2C0004010200303000010024005B
      6465635F70617274285B7143696E2E22524F55545052494345225D2C20302E39
      35295D00000000FFFF00000000000200000001000000000500417269616C003C
      00000002000800008000000000CC00020000000000FFFFFF0000000002000000
      0000000000005E05000005004D656D6F33000200140100001801000060000000
      3E0000000300000001000000000000000000FFFFFF1F2C020000000000010004
      00E3F0ED2E00000000FFFF00000000000200000001000000000500417269616C
      002800000000000000000000000000CC00020000000000FFFFFF000000000200
      0000000000000000F205000005004D656D6F3400020058000000A0000000BC00
      0000420000000300000001000000000000000000FFFFFF1F2C02000000000002
      000900D6B3ED20E7E020F8F20D0A00E1E5E720E7EDE8E6EAE800000000FFFF00
      000000000200000001000000000500417269616C001600000000000000000002
      000000CC00020000000000FFFFFF000000000200000000000000000088060000
      05004D656D6F350002008C010000B8000000F80000004E000000030000000100
      0000000000000000FFFFFF1F2C02000000000002000900D6B3ED20E7E020F8F2
      0D0C00E720352520E7EDE8E6EAEEFE00000000FFFF0000000000020000000100
      0000000500417269616C001800000000000000000002000000CC000200000000
      00FFFFFF00000000020000000000000000001B07000005004D656D6F36000200
      6801000090010000F0000000120000000300000001000000000000000000FFFF
      FF1F2C02000000000001001500D8CA3A205B7143696E2E2252424152434F4445
      225D00000000FFFF00000000000200000001000000000500417269616C000C00
      000002000000000002000000CC00020000000000FFFFFF000000000200000000
      000000FEFEFF000000000000000000000000}
  end
  object frBarCodeObject1: TfrBarCodeObject
    Left = 384
    Top = 192
  end
  object frShapeObject1: TfrShapeObject
    Left = 416
    Top = 224
  end
  object mi_popup: TPopupMenu
    OnPopup = mi_popupPopup
    Left = 440
    Top = 120
    object mi_select_all: TMenuItem
      Caption = #1055#1086#1084#1110#1090#1080#1090#1080' '#1074#1089#1110
      OnClick = mi_itemsClick
    end
    object mi_deselect_all: TMenuItem
      Caption = #1047#1085#1103#1090#1080' '#1074#1089#1110' '#1087#1086#1084#1110#1090#1082#1080
      OnClick = mi_itemsClick
    end
  end
  object frDesigner1: TfrDesigner
    Left = 352
    Top = 128
  end
end
