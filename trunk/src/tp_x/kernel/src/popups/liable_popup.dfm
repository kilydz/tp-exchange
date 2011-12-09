inherited fliable_popup: Tfliable_popup
  Left = 317
  Top = 332
  Caption = 'fliable_popup'
  ClientHeight = 374
  ClientWidth = 506
  OldCreateOrder = True
  ExplicitWidth = 514
  ExplicitHeight = 408
  PixelsPerInch = 96
  TextHeight = 13
  inherited panel: TPanel
    Width = 425
    ExplicitWidth = 425
    inherited p_top_control_bar: ZControlBar
      Width = 423
      ExplicitWidth = 423
      inherited p_main_tool_bar: ZToolBar
        AutoSize = False
      end
    end
    inherited g_dic: TdxDBGrid
      Width = 423
      KeyField = 'OLIABLE_ID'
      Filter.Criteria = {00000000}
      ExplicitWidth = 423
      object g_dicOLIABLE_ID: TdxDBGridMaskColumn
        Visible = False
        Width = 117
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OLIABLE_ID'
      end
      object g_dicOCODE: TdxDBGridMaskColumn
        Caption = #1050#1086#1076
        Width = 61
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OCODE'
      end
      object g_dicOFULL_NAME: TdxDBGridMaskColumn
        Caption = #1055#1086#1074#1085#1072' '#1085#1072#1079#1074#1072
        Width = 342
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OFULL_NAME'
      end
    end
    inherited filter_dic: ZFilter
      Width = 423
      ExplicitWidth = 423
    end
    inherited Panel1: TPanel
      Width = 423
      ExplicitWidth = 423
    end
  end
  inherited base: TIBDatabase
    DatabaseName = '192.168.0.5:/BASE/SOFTWEST/KRAJ.GDB'
  end
  inherited q_dic: TIBQuery
    SQL.Strings = (
      'select oliable_id, ocode, ofull_name from PS_POPUP_LIABLES_VIEW'
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      '')
    object q_dicOLIABLE_ID: TIntegerField
      FieldName = 'OLIABLE_ID'
      Origin = '"PS_POPUP_LIABLES_VIEW"."OLIABLE_ID"'
    end
    object q_dicOCODE: TIBStringField
      FieldName = 'OCODE'
      Origin = '"PS_POPUP_LIABLES_VIEW"."OCODE"'
      Size = 7
    end
    object q_dicOFULL_NAME: TIBStringField
      FieldName = 'OFULL_NAME'
      Origin = '"PS_POPUP_LIABLES_VIEW"."OFULL_NAME"'
      Size = 30
    end
  end
  inherited dic_images: TImageList
    Left = 360
    Top = 88
  end
  inherited images: TImageList
    Left = 360
    Top = 40
  end
  inherited scStyle: TdxEditStyleController
    Left = 408
    Top = 40
  end
end
