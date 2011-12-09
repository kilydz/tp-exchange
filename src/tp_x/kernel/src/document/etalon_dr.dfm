object fetalon_dr: Tfetalon_dr
  Left = 423
  Top = 210
  Caption = 'fetalon_dr'
  ClientHeight = 431
  ClientWidth = 529
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
    Width = 360
    Height = 401
    OnMasterResult = masterMasterResult
  end
  object p_stage0: TPanel
    Left = 144
    Top = 56
    Width = 361
    Height = 313
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 48
      Width = 21
      Height = 13
      Caption = #1050'-'#1090#1100
    end
    object Label_name: TLabel
      Left = 8
      Top = 16
      Width = 69
      Height = 13
      Caption = #1053#1072#1079#1074#1072' '#1090#1086#1074#1072#1088#1091
    end
    object lbl1: TLabel
      Left = 136
      Top = 48
      Width = 44
      Height = 13
      Caption = #1054#1076#1080#1085#1080#1094#1103
    end
    object ed_goods_list: TStringGrid
      Left = 1
      Top = 136
      Width = 359
      Height = 176
      TabStop = False
      Align = alBottom
      ColCount = 4
      DefaultRowHeight = 16
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      TabOrder = 0
      ColWidths = (
        72
        85
        88
        83)
    end
    object ed_kilk: TdxCalcEdit
      Left = 40
      Top = 40
      Width = 81
      TabOrder = 1
      OnKeyDown = EditsKeyDown
      OnKeyPress = EditsKeyPress
      OnKeyUp = EditsKeyUp
      StyleController = scStyle
      Text = '0'
      OnChange = EditsChange
    end
    object ed_price: TdxCalcEdit
      Left = 40
      Top = 72
      Width = 97
      TabOrder = 2
      OnKeyDown = EditsKeyDown
      OnKeyPress = EditsKeyPress
      OnKeyUp = EditsKeyUp
      StyleController = scStyle
      Text = '0'
      OnChange = EditsChange
    end
    object ed_sum: TdxCalcEdit
      Left = 40
      Top = 104
      Width = 97
      TabOrder = 3
      OnKeyDown = EditsKeyDown
      OnKeyPress = EditsKeyPress
      OnKeyUp = EditsKeyUp
      StyleController = scStyle
      Text = '0'
      OnChange = EditsChange
    end
    object ed_price_pdv: TdxCalcEdit
      Left = 224
      Top = 72
      Width = 97
      TabOrder = 4
      OnKeyDown = EditsKeyDown
      OnKeyPress = EditsKeyPress
      OnKeyUp = EditsKeyUp
      StyleController = scStyle
      Text = '0'
      OnChange = EditsChange
    end
    object ed_sum_pdv: TdxCalcEdit
      Left = 224
      Top = 104
      Width = 97
      TabOrder = 5
      OnKeyDown = EditsKeyDown
      OnKeyPress = EditsKeyPress
      OnKeyUp = EditsKeyUp
      StyleController = scStyle
      Text = '0'
      OnChange = EditsChange
    end
    object ed_name: TdxEdit
      Left = 88
      Top = 10
      Width = 233
      Enabled = False
      TabOrder = 6
      Text = 'ed_name'
      MaxLength = 14
      StyleController = scStyle
      StoredValues = 2
    end
    object ed_code_unit: TdxLookupEdit
      Left = 200
      Top = 40
      Width = 121
      TabOrder = 7
      OnKeyDown = EditsKeyDown
      OnKeyPress = EditsKeyPress
      OnKeyUp = EditsKeyUp
      StyleController = scStyle
      ListFieldName = 'NAME_UNIT'
      KeyFieldName = 'CODE_UNIT'
      ListSource = ds_dic
      LookupKeyValue = Null
    end
  end
  object base: TIBDatabase
    DatabaseName = '192.168.0.223:tp_svn'
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
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 72
    Top = 56
  end
  object qR: TIBSQL
    Database = base
    Transaction = trR
    Left = 104
    Top = 56
  end
  object trW: TIBTransaction
    DefaultDatabase = base
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 72
    Top = 88
  end
  object qW: TIBSQL
    Database = base
    Transaction = trW
    Left = 104
    Top = 88
  end
  object scStyle: TdxEditStyleController
    BorderColor = clBlack
    BorderStyle = xbsFlat
    ButtonStyle = btsFlat
    Left = 168
    Top = 80
  end
  object trR1: TIBTransaction
    DefaultDatabase = base
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 32
    Top = 168
  end
  object q_dic: TIBQuery
    Database = base
    Transaction = trR1
    CachedUpdates = True
    SQL.Strings = (
      
        'select ud.code_unit ,ud.name_unit, au.coefficient, au.bar_code, ' +
        'au.default_unit'
      '    from addition_unit au, unit_dimension ud'
      '    where au.code_wares = :icode_wares'
      '        and au.code_unit = ud.code_unit'
      'order by ud.name_unit')
    Left = 64
    Top = 168
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'icode_wares'
        ParamType = ptUnknown
      end>
    object q_dicCODE_UNIT: TIntegerField
      FieldName = 'CODE_UNIT'
      Origin = '"UNIT_DIMENSION"."CODE_UNIT"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object q_dicNAME_UNIT: TIBStringField
      FieldName = 'NAME_UNIT'
      Origin = '"UNIT_DIMENSION"."NAME_UNIT"'
      Size = 70
    end
    object q_dicCOEFFICIENT: TFMTBCDField
      FieldName = 'COEFFICIENT'
      Origin = '"ADDITION_UNIT"."COEFFICIENT"'
      Precision = 18
      Size = 6
    end
    object q_dicBAR_CODE: TIBStringField
      FieldName = 'BAR_CODE'
      Origin = '"ADDITION_UNIT"."BAR_CODE"'
      Size = 30
    end
    object q_dicDEFAULT_UNIT: TIBStringField
      FieldName = 'DEFAULT_UNIT'
      Origin = '"ADDITION_UNIT"."DEFAULT_UNIT"'
      FixedChar = True
      Size = 1
    end
  end
  object ds_dic: TDataSource
    DataSet = q_dic
    Left = 96
    Top = 168
  end
end
