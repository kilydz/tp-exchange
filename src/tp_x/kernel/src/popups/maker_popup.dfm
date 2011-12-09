inherited fmaker_popup: Tfmaker_popup
  Left = 455
  Top = 97
  Caption = 'fmaker_popup'
  ClientHeight = 374
  ClientWidth = 506
  OldCreateOrder = True
  ExplicitWidth = 514
  ExplicitHeight = 408
  PixelsPerInch = 96
  TextHeight = 13
  inherited panel: TPanel
    Width = 393
    ExplicitWidth = 393
    inherited p_top_control_bar: ZControlBar
      Width = 391
      ExplicitWidth = 391
      inherited p_main_tool_bar: ZToolBar
        AutoSize = False
      end
    end
    inherited g_dic: TdxDBGrid
      Width = 391
      KeyField = 'OMAKER_ID'
      Filter.Criteria = {00000000}
      ExplicitWidth = 391
      object g_dicOMAKER_ID: TdxDBGridMaskColumn
        Caption = #1050#1086#1076
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OMAKER_ID'
      end
      object g_dicOMAKER_NAME: TdxDBGridMaskColumn
        Caption = #1042#1080#1088#1086#1073#1085#1080#1082' ('#1058'.'#1052'.)'
        Width = 308
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OMAKER_NAME'
      end
    end
    inherited filter_dic: ZFilter
      Width = 391
      ExplicitWidth = 391
    end
    inherited Panel1: TPanel
      Width = 391
      ExplicitWidth = 391
    end
  end
  inherited base: TIBDatabase
    DatabaseName = '192.168.0.5:/BASE/SOFTWEST/KRAJ.GDB'
  end
  inherited q_dic: TIBQuery
    SQL.Strings = (
      'select omaker_id, omaker_name from PS_POPUP_MAKERS_VIEW'
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      '')
    object q_dicOMAKER_ID: TIntegerField
      FieldName = 'OMAKER_ID'
      Origin = '"PS_POPUP_MAKERS_VIEW"."OMAKER_ID"'
    end
    object q_dicOMAKER_NAME: TIBStringField
      FieldName = 'OMAKER_NAME'
      Origin = '"PS_POPUP_MAKERS_VIEW"."OMAKER_NAME"'
      Size = 40
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
