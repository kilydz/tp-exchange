inherited fedmarkup: Tfedmarkup
  Tag = 1
  Left = 404
  Top = 208
  Caption = #1056#1077#1076#1072#1075#1091#1074#1072#1085#1085#1103' '#1072#1082#1090#1091' '#1087#1077#1088#1077#1086#1094#1110#1085#1082#1080
  ClientHeight = 542
  ClientWidth = 869
  OldCreateOrder = True
  ExplicitWidth = 877
  ExplicitHeight = 576
  PixelsPerInch = 96
  TextHeight = 13
  inherited Splitter1: TSplitter
    Top = 269
    Width = 869
    ExplicitTop = 276
    ExplicitWidth = 869
  end
  inherited ZControlBar2: ZControlBar
    Width = 869
    ExplicitWidth = 869
  end
  inherited g_dic: TdxDBGrid
    Width = 869
    Height = 140
    Filter.Criteria = {00000000}
    OptionsView = [edgoAutoWidth, edgoBandHeaderWidth, edgoInvertSelect, edgoUseBitmap]
    ExplicitWidth = 869
    ExplicitHeight = 140
    object g_dicOCODE: TdxDBGridMaskColumn
      Caption = #1050#1086#1076
      Width = 59
      BandIndex = 0
      RowIndex = 0
      FieldName = 'OCODE'
    end
    object g_dicOFULL_NAME: TdxDBGridMaskColumn
      Caption = #1055#1086#1074#1085#1072' '#1085#1072#1079#1074#1072' '#1090#1086#1074#1072#1088#1091
      Width = 240
      BandIndex = 0
      RowIndex = 0
      FieldName = 'OFULL_NAME'
    end
    object g_dicOIN_PRICE: TdxDBGridMaskColumn
      Caption = #1062#1047' ('#1079' '#1055#1044#1042')'
      Width = 63
      BandIndex = 0
      RowIndex = 0
      FieldName = 'OIN_PRICE'
    end
    object g_dicOIN_PRICE_OLD: TdxDBGridMaskColumn
      Caption = #1057#1090#1072#1088#1072' '#1062#1047' ('#1079#1055#1044#1042')'
      Width = 94
      BandIndex = 0
      RowIndex = 0
      FieldName = 'OIN_PRICE_OLD'
    end
    object g_dicIN_PRICE_DELTA: TdxDBGridColumn
      Caption = #1047#1084#1110#1085#1072' '#1062#1047
      Width = 60
      BandIndex = 0
      RowIndex = 0
      FieldName = 'IN_PRICE_DELTA'
    end
    object g_dicOOUT_PRICE: TdxDBGridMaskColumn
      Caption = #1062#1056' ('#1079' '#1055#1044#1042')'
      Width = 73
      BandIndex = 0
      RowIndex = 0
      FieldName = 'OOUT_PRICE'
    end
    object g_dicOOUT_PRICE_CURR: TdxDBGridMaskColumn
      Caption = #1055#1086#1090#1086#1095#1085#1072' '#1062#1056'('#1079' '#1055#1044#1042')'
      Width = 101
      BandIndex = 0
      RowIndex = 0
      FieldName = 'OOUT_PRICE_CURR'
    end
    object g_dicMARKUP: TdxDBGridColumn
      Caption = #1042#1110#1076#1089#1086#1090#1086#1082' '#1085#1072#1094'.'
      Width = 82
      BandIndex = 0
      RowIndex = 0
      FieldName = 'MARKUP'
    end
    object g_dicMARKUP_SUM: TdxDBGridColumn
      Caption = #1053#1072#1094#1110#1085#1082#1072' ('#1079' '#1055#1044#1042')'
      Width = 95
      BandIndex = 0
      RowIndex = 0
      FieldName = 'MARKUP_SUM'
    end
    object g_dicORECORD_ID: TdxDBGridMaskColumn
      Visible = False
      Width = 76
      BandIndex = 0
      RowIndex = 0
      FieldName = 'ORECORD_ID'
    end
  end
  inherited p_choicer: TPanel
    Top = 273
    Width = 869
    ExplicitTop = 273
    ExplicitWidth = 869
  end
  inherited p_header: TPanel
    Width = 869
    ExplicitWidth = 869
    inherited m_header: TdxMemo
      Width = 867
      ExplicitWidth = 867
      Height = 99
    end
  end
  inherited base: TIBDatabase
    DatabaseName = '192.168.0.5:/BASE/SOFTWEST/KRAJ.GDB'
  end
  inherited q_dic: TIBQuery
    OnCalcFields = q_dicCalcFields
    SQL.Strings = (
      
        'select omarkup_record_id as orecord_id, ocode, ofull_name, oin_p' +
        'rice, oout_price, oin_price_old, oout_price_curr, onomen_id  fro' +
        'm PS_MARKUP_RECORDS_VIEW_V1(:imarkup_id) order by omarkup_record' +
        '_id'
      ''
      ''
      ''
      ''
      ''
      '')
    ParamData = <
      item
        DataType = ftString
        Name = 'imarkup_id'
        ParamType = ptUnknown
        Value = '20'
      end>
    object q_dicORECORD_ID: TIntegerField
      FieldName = 'ORECORD_ID'
      Origin = '"PS_MARKUP_RECORDS_VIEW"."OMARKUP_RECORD_ID"'
    end
    object q_dicOCODE: TIBStringField
      FieldName = 'OCODE'
      Origin = '"PS_MARKUP_RECORDS_VIEW"."OCODE"'
      Size = 7
    end
    object q_dicOFULL_NAME: TIBStringField
      FieldName = 'OFULL_NAME'
      Origin = '"PS_MARKUP_RECORDS_VIEW"."OFULL_NAME"'
      Size = 40
    end
    object q_dicOIN_PRICE: TFloatField
      FieldName = 'OIN_PRICE'
      Origin = '"PS_MARKUP_RECORDS_VIEW"."OIN_PRICE"'
      DisplayFormat = '0.000'
    end
    object q_dicOOUT_PRICE: TFloatField
      FieldName = 'OOUT_PRICE'
      Origin = '"PS_MARKUP_RECORDS_VIEW"."OOUT_PRICE"'
      DisplayFormat = '0.00'
    end
    object q_dicMARKUP: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'MARKUP'
      DisplayFormat = '0.00'
      Calculated = True
    end
    object q_dicMARKUP_SUM: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'MARKUP_SUM'
      DisplayFormat = '0.00'
      Calculated = True
    end
    object q_dicOIN_PRICE_OLD: TFloatField
      FieldName = 'OIN_PRICE_OLD'
      Origin = '"PS_MARKUP_RECORDS_VIEW"."OIN_PRICE_OLD"'
      DisplayFormat = '0.000'
    end
    object q_dicOOUT_PRICE_CURR: TFloatField
      FieldName = 'OOUT_PRICE_CURR'
      Origin = '"PS_MARKUP_RECORDS_VIEW"."OOUT_PRICE_CURR"'
      DisplayFormat = '0.00'
    end
    object q_dicIN_PRICE_DELTA: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'IN_PRICE_DELTA'
      DisplayFormat = '0.000'
      Calculated = True
    end
    object q_dicONOMEN_ID: TIntegerField
      FieldName = 'ONOMEN_ID'
      Origin = '"PS_MARKUP_RECORDS_VIEW"."ONOMEN_ID"'
    end
  end
  inherited upd_dic: TIBUpdateSQL
    RefreshSQL.Strings = (
      'Select '
      'from PS_MARKUP_RECORDS_VIEW '
      'where'
      '  OCODE = :OCODE and'
      '  OFULL_NAME = :OFULL_NAME and'
      '  OIN_PRICE = :OIN_PRICE and'
      '  OMARKUP_RECORD_ID = :OMARKUP_RECORD_ID and'
      '  OOUT_PRICE = :OOUT_PRICE')
    ModifySQL.Strings = (
      'update PS_MARKUP_RECORDS_VIEW'
      'set'
      '  OCODE = :OCODE,'
      '  OFULL_NAME = :OFULL_NAME,'
      '  OIN_PRICE = :OIN_PRICE,'
      '  OMARKUP_RECORD_ID = :OMARKUP_RECORD_ID,'
      '  OOUT_PRICE = :OOUT_PRICE'
      'where'
      '  OCODE = :OLD_OCODE and'
      '  OFULL_NAME = :OLD_OFULL_NAME and'
      '  OIN_PRICE = :OLD_OIN_PRICE and'
      '  OMARKUP_RECORD_ID = :OLD_OMARKUP_RECORD_ID and'
      '  OOUT_PRICE = :OLD_OOUT_PRICE')
    InsertSQL.Strings = (
      'insert into PS_MARKUP_RECORDS_VIEW'
      '  (OCODE, OFULL_NAME, OIN_PRICE, OMARKUP_RECORD_ID, OOUT_PRICE)'
      'values'
      
        '  (:OCODE, :OFULL_NAME, :OIN_PRICE, :OMARKUP_RECORD_ID, :OOUT_PR' +
        'ICE)')
    DeleteSQL.Strings = (
      'delete from PS_MARKUP_RECORDS_VIEW'
      'where'
      '  OCODE = :OLD_OCODE and'
      '  OFULL_NAME = :OLD_OFULL_NAME and'
      '  OIN_PRICE = :OLD_OIN_PRICE and'
      '  OMARKUP_RECORD_ID = :OLD_OMARKUP_RECORD_ID and'
      '  OOUT_PRICE = :OLD_OOUT_PRICE')
  end
end
