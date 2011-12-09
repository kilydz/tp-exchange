inherited fpoint_popup: Tfpoint_popup
  Left = 0
  Top = 0
  Caption = 'fpoint_popup'
  ClientHeight = 355
  ClientWidth = 471
  Font.Name = 'Tahoma'
  Position = poDesktopCenter
  ExplicitWidth = 479
  ExplicitHeight = 389
  PixelsPerInch = 96
  TextHeight = 13
  inherited panel: TPanel
    Left = 8
    Top = 8
    ExplicitLeft = 8
    ExplicitTop = 8
    inherited p_top_control_bar: ZControlBar
      inherited p_main_tool_bar: ZToolBar
        inherited bt_ins: ZToolButton
          Visible = False
        end
      end
    end
    inherited g_dic: TdxDBGrid
      KeyField = 'OL3_POINT_ID'
      Filter.Criteria = {00000000}
      OptionsView = [edgoAutoWidth, edgoBandHeaderWidth, edgoInvertSelect, edgoUseBitmap]
      ExplicitTop = 29
      object g_dicOL3_POINT_ID: TdxDBGridMaskColumn
        Visible = False
        Width = 73
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OL3_POINT_ID'
      end
      object g_dicOPOST_CODE: TdxDBGridMaskColumn
        Caption = #1055#1086#1096#1090#1086#1074#1080#1081' '#1082#1086#1076
        Width = 69
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OPOST_CODE'
      end
      object g_dicOFULL_NAME: TdxDBGridMaskColumn
        Caption = #1053#1072#1079#1074#1072' '#1085#1072#1089#1077#1083#1077#1085#1086#1075#1086' '#1087#1091#1085#1082#1090#1072
        Width = 359
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OFULL_NAME'
      end
    end
  end
  inherited q_dic: TIBQuery
    SQL.Strings = (
      
        'select ol3_point_id, opost_code, ofull_name from PS_POPUP_POINTS' +
        '_VIEW'
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
      ''
      ''
      '')
    object q_dicOL3_POINT_ID: TIntegerField
      FieldName = 'OL3_POINT_ID'
      Origin = '"PS_POPUP_POINTS_VIEW"."OL3_POINT_ID"'
    end
    object q_dicOPOST_CODE: TIBStringField
      FieldName = 'OPOST_CODE'
      Origin = '"PS_POPUP_POINTS_VIEW"."OPOST_CODE"'
      Size = 12
    end
    object q_dicOFULL_NAME: TIBStringField
      FieldName = 'OFULL_NAME'
      Origin = '"PS_POPUP_POINTS_VIEW"."OFULL_NAME"'
      Size = 128
    end
  end
end
