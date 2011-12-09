inherited fproperty_popup: Tfproperty_popup
  Left = 0
  Top = 0
  Caption = 'fproperty_popup'
  ClientHeight = 382
  ClientWidth = 505
  Font.Name = 'Tahoma'
  ExplicitWidth = 513
  ExplicitHeight = 416
  PixelsPerInch = 96
  TextHeight = 13
  inherited panel: TPanel
    inherited g_dic: TdxDBGrid
      KeyField = 'OTYPEPROP_ID'
      Filter.Criteria = {00000000}
      OptionsView = [edgoAutoWidth, edgoBandHeaderWidth, edgoInvertSelect, edgoUseBitmap]
      object g_dicOTYPEPROP_ID: TdxDBGridMaskColumn
        Visible = False
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OTYPEPROP_ID'
      end
      object g_dicOFULL_NAME: TdxDBGridMaskColumn
        Caption = #1060#1086#1088#1084#1080' '#1074#1083#1072#1089#1085#1086#1089#1090#1110
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OFULL_NAME'
      end
    end
  end
  inherited q_dic: TIBQuery
    SQL.Strings = (
      'select otypeprop_id, ofull_name from PS_POPUP_PROPERTYS_VIEW'
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      '')
    object q_dicOTYPEPROP_ID: TIntegerField
      FieldName = 'OTYPEPROP_ID'
      Origin = '"PS_POPUP_PROPERTYS_VIEW"."OTYPEPROP_ID"'
    end
    object q_dicOFULL_NAME: TIBStringField
      FieldName = 'OFULL_NAME'
      Origin = '"PS_POPUP_PROPERTYS_VIEW"."OFULL_NAME"'
      Size = 114
    end
  end
end
