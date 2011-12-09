inherited fmanager_popup: Tfmanager_popup
  Left = 0
  Top = 0
  Caption = 'fmanager_popup'
  ClientHeight = 381
  ClientWidth = 530
  Font.Name = 'Tahoma'
  ExplicitWidth = 538
  ExplicitHeight = 415
  PixelsPerInch = 96
  TextHeight = 13
  inherited panel: TPanel
    inherited g_dic: TdxDBGrid
      KeyField = 'MANAGER_ID'
      Filter.Criteria = {00000000}
      OptionsView = [edgoAutoWidth, edgoBandHeaderWidth, edgoInvertSelect, edgoUseBitmap]
      object g_dicMANAGER_ID: TdxDBGridMaskColumn
        Caption = 'ID'
        Width = 63
        BandIndex = 0
        RowIndex = 0
        FieldName = 'MANAGER_ID'
      end
      object g_dicMANAGER_NAME: TdxDBGridMaskColumn
        Caption = #1050#1072#1090#1077#1075#1086#1088#1110#1081#1085#1080#1081' '#1084#1077#1085#1077#1076#1078#1077#1088
        Width = 365
        BandIndex = 0
        RowIndex = 0
        FieldName = 'MANAGER_NAME'
      end
    end
  end
  inherited base: TIBDatabase
    DatabaseName = '127.0.0.1:D:\BASE\SHOP.GDB'
  end
  inherited q_dic: TIBQuery
    SQL.Strings = (
      'select manager_id, manager_name  from t_managers'
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
      ' order by manager_name')
    object q_dicMANAGER_ID: TIntegerField
      FieldName = 'MANAGER_ID'
      Origin = '"T_MANAGERS"."MANAGER_ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object q_dicMANAGER_NAME: TIBStringField
      FieldName = 'MANAGER_NAME'
      Origin = '"T_MANAGERS"."MANAGER_NAME"'
    end
  end
end
