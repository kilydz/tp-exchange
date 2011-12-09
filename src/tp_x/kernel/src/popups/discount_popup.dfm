inherited fdiscount_popup: Tfdiscount_popup
  Left = 0
  Top = 0
  Caption = 'fdiscount_popup'
  ClientHeight = 385
  ClientWidth = 283
  Font.Name = 'Tahoma'
  ExplicitWidth = 291
  ExplicitHeight = 419
  PixelsPerInch = 96
  TextHeight = 13
  inherited panel: TPanel
    Width = 225
    ExplicitWidth = 225
    inherited p_top_control_bar: ZControlBar
      Width = 223
    end
    inherited g_dic: TdxDBGrid
      Width = 223
      KeyField = 'ODISCOUNT_ID'
      Filter.Criteria = {00000000}
      OptionsView = [edgoAutoWidth, edgoBandHeaderWidth, edgoInvertSelect, edgoUseBitmap]
      object g_dicOPROCENT: TdxDBGridMaskColumn
        Caption = #1047#1085#1080#1078#1082#1072' %'
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OPROCENT'
      end
      object g_dicOSUMMA: TdxDBGridMaskColumn
        Caption = #1055#1086#1088#1086#1075' '#1085#1072#1082#1086#1087#1080#1095#1077#1085#1085#1103
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OSUMMA'
      end
    end
    inherited filter_dic: ZFilter
      Width = 223
    end
    inherited Panel1: TPanel
      Width = 223
    end
  end
  inherited base: TIBDatabase
    DatabaseName = '127.0.0.1:d:\base\shop_src.gdb'
    Left = 72
  end
  inherited tr_dic: TIBTransaction
    Left = 104
  end
  inherited q_dic: TIBQuery
    SQL.Strings = (
      'select odiscount_id, oprocent, osumma from PS_POPUP_DISCOUNTS'
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
    Left = 136
    object q_dicODISCOUNT_ID: TIntegerField
      FieldName = 'ODISCOUNT_ID'
      Origin = '"PS_POPUP_DISCOUNTS"."ODISCOUNT_ID"'
    end
    object q_dicOPROCENT: TFloatField
      FieldName = 'OPROCENT'
      Origin = '"PS_POPUP_DISCOUNTS"."OPROCENT"'
      DisplayFormat = '0.000 %'
    end
    object q_dicOSUMMA: TIntegerField
      FieldName = 'OSUMMA'
      Origin = '"PS_POPUP_DISCOUNTS"."OSUMMA"'
      DisplayFormat = '0.00'
    end
  end
  inherited ds_dic: TDataSource
    Left = 168
  end
  inherited upd_dic: TIBUpdateSQL
    Left = 216
  end
  inherited tr_R: TIBTransaction
    Left = 104
  end
  inherited q_R: TIBSQL
    Left = 136
  end
  inherited tr_W: TIBTransaction
    Left = 104
  end
  inherited q_W: TIBSQL
    Left = 136
  end
  inherited export_dialog: TSaveDialog
    Left = 240
  end
  inherited scStyle: TdxEditStyleController
    Left = 128
    Top = 88
  end
  inherited popup_menu_dic: TPopupMenu
    Left = 216
  end
end
