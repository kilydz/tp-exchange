inherited fpoint_l0_popup: Tfpoint_l0_popup
  Left = 0
  Top = 0
  Caption = 'fpoint_l0_popup'
  ClientHeight = 361
  ClientWidth = 514
  Font.Name = 'Tahoma'
  ExplicitWidth = 522
  ExplicitHeight = 395
  PixelsPerInch = 96
  TextHeight = 13
  inherited panel: TPanel
    Left = 32
    Top = 8
    ExplicitLeft = 32
    ExplicitTop = 8
    inherited g_dic: TdxDBGrid
      KeyField = 'OL0_POINT_ID'
      Filter.Criteria = {00000000}
      OptionsView = [edgoAutoWidth, edgoBandHeaderWidth, edgoInvertSelect, edgoUseBitmap]
      ExplicitTop = 29
      object g_dicOL0_POINT_ID: TdxDBGridMaskColumn
        Caption = 'ID'
        Width = 72
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OL0_POINT_ID'
      end
      object g_dicONAME: TdxDBGridMaskColumn
        Caption = #1053#1072#1079#1074#1072' '#1082#1088#1072#1111#1085#1080
        Width = 356
        BandIndex = 0
        RowIndex = 0
        FieldName = 'ONAME'
      end
    end
  end
  inherited q_dic: TIBQuery
    SQL.Strings = (
      'select ol0_point_id, oname from PS_POPUP_L0_POINTS_VIEW'
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
    object q_dicOL0_POINT_ID: TIntegerField
      FieldName = 'OL0_POINT_ID'
      Origin = '"PS_POPUP_L0_POINTS_VIEW"."OL0_POINT_ID"'
    end
    object q_dicONAME: TIBStringField
      FieldName = 'ONAME'
      Origin = '"PS_POPUP_L0_POINTS_VIEW"."ONAME"'
      Size = 24
    end
  end
end
